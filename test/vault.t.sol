// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import "src/Vault.sol";
import "aave-v3-core/interfaces/IPoolAddressesProvider.sol";
import "aave-v3-core/interfaces/IPool.sol";
import "openzeppelin/token/ERC20/IERC20.sol";


contract vaultTest is Test {
    Vault public v;
    Factory public f;
    address public deployer = 0xd949fb6C12B7aDC6F762c7425B582A880210e0d6;
    address public dai = 0xFF34B3d4Aee8ddCd6F9AFFFB6Fe49bD371b8a357;
    address public addressProvider = 0x012bAC54348C0E635dCAc9D5FB99f06F24136C9A;
    address public u1 = vm.addr(1);
    
    uint256 sepoliaFork;

    function setUp() public {
        sepoliaFork = vm.createFork("https://sepolia.infura.io/v3/f9f12ceb3d56436aaf50ff3800a10856");
        vm.selectFork(sepoliaFork);
        vm.prank(deployer);
        f = new Factory();
    }

    function test_userVault_depositAndSupply() public {
        //get new vault and initialize it
        vm.startPrank(deployer);
        address v1 = f.getNewVault();
        (bool ok,) = v1.call(abi.encodeWithSignature("initialize(address,string,string,address)",dai,"Implementation of Yield Vaults","Impl-YV",addressProvider));
        require(ok);
        (,bytes memory data) = v1.call(abi.encodeWithSignature("name()"));
        string memory name = abi.decode(data,(string));
        assertEq(name,"Implementation of Yield Vaults");

        //approve deposit and supply
        IERC20(dai).approve(address(v1), 1e21);
        (bool deposit,) = v1.call(abi.encodeWithSignature("deposit(uint256,address)",1e21,deployer));
        require(deposit);
        (,bytes memory totalAssets_depositDone) = v1.call(abi.encodeWithSignature("totalAssets()"));
        assertEq(abi.decode(totalAssets_depositDone,(uint256)), 1e21);
        (bool supply,) = v1.call(abi.encodeWithSignature("supplyToAaveV3(uint256)",1e21));
        require(supply);
        (,bytes memory totalAssets2_suppliedToAave) = v1.call(abi.encodeWithSignature("totalAssets()"));
        assertEq(abi.decode(totalAssets2_suppliedToAave,(uint256)), 0);
        vm.stopPrank();
    }

}
