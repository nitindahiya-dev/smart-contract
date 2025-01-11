// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract MyTokenTest is Test {
    NitinCoin token;
    address owner = address(this);
    address user1 = address(0x1);
    address user2 = address(0x2);

    function setUp() public {
        token = new NitinCoin();
    }

    function testInitialState() public {
        assertEq(token.name(), "Nitin");
        assertEq(token.symbol(), "NIT");
        assertEq(token.totalSupply(), 0);
    }

    function testMint() public {
        uint256 mintAmount = 1000 * 10**18;
        token.mint(user1, mintAmount);
        assertEq(token.balanceOf(user1), mintAmount);
        assertEq(token.totalSupply(), mintAmount);
    }

    function testMintRevertsWhenNotOwner() public {
        uint256 mintAmount = 1000 * 10**18;
        vm.prank(user1);
        vm.expectRevert("Ownable: caller is not the owner");
        token.mint(user1, mintAmount);
    }

    function testMultipleMints() public {
        token.mint(user1, 500 * 10**18);
        token.mint(user2, 300 * 10**18);
        assertEq(token.balanceOf(user1), 500 * 10**18);
        assertEq(token.balanceOf(user2), 300 * 10**18);
        assertEq(token.totalSupply(), 800 * 10**18);
    }

    function testTransfer() public {
        uint256 mintAmount = 1000 * 10**18;
        uint256 transferAmount = 400 * 10**18;
        token.mint(user1, mintAmount);
        vm.prank(user1);
        token.transfer(user2, transferAmount);
        assertEq(token.balanceOf(user1), mintAmount - transferAmount);
        assertEq(token.balanceOf(user2), transferAmount);
    }

    function testTransferZeroTokens() public {
        uint256 mintAmount = 1000 * 10**18;
        token.mint(user1, mintAmount);
        vm.prank(user1);
        token.transfer(user2, 0);
        assertEq(token.balanceOf(user1), mintAmount);
        assertEq(token.balanceOf(user2), 0);
    }

    function testTransferExceedingBalance() public {
        uint256 mintAmount = 1000 * 10**18;
        token.mint(user1, mintAmount);
        vm.prank(user1);
        vm.expectRevert();
        token.transfer(user2, 2000 * 10**18);
    }
}
