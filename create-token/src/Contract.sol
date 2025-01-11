// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract NitinCoin is ERC20 {
    address public owner;

    constructor() ERC20("Nitin", "NIT") {
        owner = msg.sender; // Set the deployer as the owner
    }

    function mint(address to, uint256 amount) public {
        require(msg.sender == owner, "Ownable: caller is not the owner");
        _mint(to, amount);
    }
}


// 1e3f99351beae3e18fdfddd58a5877967539bdaef4f89773a414e0574d18aacd