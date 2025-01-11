// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract LockUSDT {
    address private usdtAddress;
    mapping(address => uint) private pendingBalance;

    constructor(address _usdtAddress) {
        usdtAddress = _usdtAddress;
    }

    function getPendingBalance(address user) public view returns (uint) {
        return pendingBalance[user];
    }

    function deposit(uint256 _amount) public {
        require(
            IERC20(usdtAddress).allowance(msg.sender, address(this)) >= _amount,
            "Allowance insufficient"
        );
        IERC20(usdtAddress).transferFrom(msg.sender, address(this), _amount);

        pendingBalance[msg.sender] += _amount;
    }

    function withdraw() public {
        uint256 balance = pendingBalance[msg.sender];
        require(balance > 0, "No balance to withdraw");

        IERC20(usdtAddress).transfer(msg.sender, balance);
        pendingBalance[msg.sender] = 0;
    }
}
