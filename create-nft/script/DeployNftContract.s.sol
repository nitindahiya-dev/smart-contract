// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {NftContract} from "../src/NftContract.sol";

contract DeployNftContract is Script{
    function run() external returns(NftContract){
        vm.startBroadcast();
        NftContract nftContract = new NftContract();
        vm.stopBroadcast();
        return nftContract;
    }
}