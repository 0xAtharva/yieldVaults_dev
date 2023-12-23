// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {Script, console2} from "forge-std/Script.sol";
import {vault} from "src/vault.sol";

contract deployScript is Script {
    address public dai = 0xFF34B3d4Aee8ddCd6F9AFFFB6Fe49bD371b8a357;
    address public addressProvider = 0x012bAC54348C0E635dCAc9D5FB99f06F24136C9A;

    function setUp() public {}

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // NFT nft = new NFT("NFT_tutorial", "TUT", "baseUri");
        vault v = new vault(dai, "Yield Vaults","YVT",addressProvider);


        vm.stopBroadcast();
    }
}
