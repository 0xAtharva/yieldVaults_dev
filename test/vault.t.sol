// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {vault} from "src/vault.sol";
import {IPoolAddressesProvider} from "aave-v3-core/interfaces/IPoolAddressesProvider.sol";
import {IPool} from "aave-v3-core/interfaces/IPool.sol";


contract vaultTest is Test {
    vault public v;
    // mintable testnet DAI
    address public dai = 0xFF34B3d4Aee8ddCd6F9AFFFB6Fe49bD371b8a357;
    address public addressProvider = 0x012bAC54348C0E635dCAc9D5FB99f06F24136C9A;
    address public deployer = 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496;
    address public u1 = vm.addr(1);

    uint256 sepoliaFork;

    // uint256 optimismFork;
    // string MAINNET_SEPOLIA_RPC_URL = vm.envString("MAINNET_SEPOLIA_RPC_URL");
    // string OPTIMISM_SEPOLIA_RPC_URL = vm.envString("OPTIMISM_SEPOLIA_RPC_URL");

    function setUp() public {
        sepoliaFork = vm.createFork("https://sepolia.infura.io/v3/f9f12ceb3d56436aaf50ff3800a10856");
        vm.selectFork(sepoliaFork);
        // TestnetERC20(t).mint(deployer,1e24);
        v = new vault(dai, "Yield Vaults","YVT",addressProvider);
    }

    ///////////////////////////////////////////////
    //////               VAULT               //////
    ///////////////////////////////////////////////

    // function test_depositAndSupply() public {
    //     //arrange
    //     dai.approve(address(v), 1e21);
    //     //act
    //     v.deposit(1e21, msg.sender);
    //     v.supplyToAaveV3(1e21);
    //     //assert
    //     assertEq(v.totalAssets(), 0);
        
    // }

}
