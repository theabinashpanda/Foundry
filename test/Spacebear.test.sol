// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Spacebear.sol";

contract SpacebearTest is Test {
    Spacebear spacebear;
    function setUp() public{
        spacebear = new Spacebear();
    }
    function testNameIsSpacebear() public {
        assertEq(spacebear.name(),"Spacebear");   
    }
    function testMintingNTFs() public{
        spacebear.safeMint(msg.sender);
        assertEq(spacebear.ownerOf(0),msg.sender);
        assertEq(spacebear.tokenURI(0),"https://ethereum-blockchain-developer.com/2022-06-nft-truffle-hardhat-foundry/nftdata/spacebear_1.json");
    }

    function testMintWrongOwner() public{
        address purchaser = address(0x1);
        vm.startPrank(purchaser);
        vm.expectRevert();
        spacebear.safeMint(purchaser);
        vm.stopPrank();
    }
    function testNFTBuyToken() public{
        address purchaser = address(0x2);
        vm.startPrank(purchaser);
        spacebear.buyToken();
        vm.stopPrank();
        assertEq(spacebear.ownerOf(0),purchaser);

    }
}