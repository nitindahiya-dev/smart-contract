// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import {NftContract} from "../src/NftContract.sol";
import {DeployNftContract} from "../script/DeployNftContract.s.sol";

contract NftContractTest is Test {
    DeployNftContract public deployer;
    NftContract public nftContract;
    address public USER = makeAddr("user");
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployNftContract();
        nftContract = deployer.run();
    }
    function testNameisCorrect() public view {
        string memory expectedName = "Doggie";
        string memory actualName = nftContract.name();

        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        nftContract.mintnft(PUG);

        assert(nftContract.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(PUG)) ==
                keccak256(abi.encodePacked(nftContract.tokenURI(0)))
        );
    }
}
