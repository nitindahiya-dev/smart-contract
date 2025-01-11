// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Contract.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Mock USDT token for testing
contract MockUSDT is ERC20 {
    constructor() ERC20("Mock USDT", "USDT") {
        _mint(msg.sender, 1000000 * 10**18); // Mint 1,000,000 USDT to deployer
    }

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}

contract LockUSDTTest is Test {
    LockUSDT lockUSDT;
    MockUSDT usdt;

    address owner = address(this);
    address user1 = address(0x1);
    address user2 = address(0x2);

    function setUp() public {
        // Deploy mock USDT and LockUSDT contracts
        usdt = new MockUSDT();
        lockUSDT = new LockUSDT(address(usdt));
    }

    function testDeposit() public {
        uint256 depositAmount = 1000 * 10**18;

        // Mint and approve USDT for user1
        usdt.mint(user1, depositAmount);
        vm.prank(user1);
        usdt.approve(address(lockUSDT), depositAmount);

        // Deposit USDT into LockUSDT contract
        vm.prank(user1);
        lockUSDT.deposit(depositAmount);

        // Check balances
        assertEq(usdt.balanceOf(user1), 0);
        assertEq(usdt.balanceOf(address(lockUSDT)), depositAmount);
        assertEq(lockUSDT.getPendingBalance(user1), depositAmount);
    }

    function testDepositWithoutApprovalReverts() public {
        uint256 depositAmount = 1000 * 10**18;

        // Mint USDT for user1 but do not approve
        usdt.mint(user1, depositAmount);

        // Attempt to deposit without approval
        vm.prank(user1);
        vm.expectRevert(); // Expect revert due to insufficient allowance
        lockUSDT.deposit(depositAmount);
    }

    function testWithdraw() public {
        uint256 depositAmount = 1000 * 10**18;

        // Mint and approve USDT for user1
        usdt.mint(user1, depositAmount);
        vm.prank(user1);
        usdt.approve(address(lockUSDT), depositAmount);

        // Deposit USDT
        vm.prank(user1);
        lockUSDT.deposit(depositAmount);

        // Withdraw USDT
        vm.prank(user1);
        lockUSDT.withdraw();

        // Check balances
        assertEq(usdt.balanceOf(user1), depositAmount);
        assertEq(usdt.balanceOf(address(lockUSDT)), 0);
        assertEq(lockUSDT.getPendingBalance(user1), 0);
    }

    function testWithdrawWithoutDepositReverts() public {
        // Attempt to withdraw without any deposit
        vm.prank(user1);
        vm.expectRevert(); // Expect revert due to zero balance
        lockUSDT.withdraw();
    }

    function testMultipleDepositsAndWithdrawals() public {
        uint256 depositAmount1 = 1000 * 10**18;
        uint256 depositAmount2 = 500 * 10**18;

        // Mint and approve USDT for user1 and user2
        usdt.mint(user1, depositAmount1 + depositAmount2);
        usdt.mint(user2, depositAmount2);
        vm.prank(user1);
        usdt.approve(address(lockUSDT), depositAmount1 + depositAmount2);
        vm.prank(user2);
        usdt.approve(address(lockUSDT), depositAmount2);

        // User1 deposits twice
        vm.prank(user1);
        lockUSDT.deposit(depositAmount1);
        vm.prank(user1);
        lockUSDT.deposit(depositAmount2);

        // User2 deposits once
        vm.prank(user2);
        lockUSDT.deposit(depositAmount2);

        // Check balances after deposits
        assertEq(lockUSDT.getPendingBalance(user1), depositAmount1 + depositAmount2);
        assertEq(lockUSDT.getPendingBalance(user2), depositAmount2);
        assertEq(usdt.balanceOf(address(lockUSDT)), depositAmount1 + depositAmount2 * 2);

        // Users withdraw their balances
        vm.prank(user1);
        lockUSDT.withdraw();
        vm.prank(user2);
        lockUSDT.withdraw();

        // Check balances after withdrawals
        assertEq(usdt.balanceOf(user1), depositAmount1 + depositAmount2);
        assertEq(usdt.balanceOf(user2), depositAmount2);
        assertEq(usdt.balanceOf(address(lockUSDT)), 0);
    }
}
