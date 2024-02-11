// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "openzeppelin-up/token/ERC20/extensions/ERC4626Upgradeable.sol";
import "openzeppelin-up/token/ERC20/ERC20Upgradeable.sol";
import "openzeppelin-up/access/OwnableUpgradeable.sol";
import "openzeppelin/token/ERC20/IERC20.sol";
import "openzeppelin/token/ERC20/utils/SafeERC20.sol";
import "aave-v3-core/interfaces/IPool.sol";
import "aave-v3-core/interfaces/IPoolAddressesProvider.sol";

import "openzeppelin/proxy/Clones.sol";


contract Vault is ERC4626Upgradeable, OwnableUpgradeable {

    IPoolAddressesProvider public POOL_PROVIDER; //0x012bAC54348C0E635dCAc9D5FB99f06F24136C9A
    IPool public POOL;
    // Certificate public certificate;

    function initialize(
        address _asset,//0xFF34B3d4Aee8ddCd6F9AFFFB6Fe49bD371b8a357
        string memory _name,
        string memory _symbol,
        address _poolProvider
    ) public initializer {
        __ERC4626_init(IERC20(_asset));
        __ERC20_init(_name,_symbol);
        __Ownable_init(msg.sender);
        POOL_PROVIDER = IPoolAddressesProvider(_poolProvider);
        POOL = IPool(POOL_PROVIDER.getPool());
    }


    function supplyToAaveV3(uint256 amount) public onlyOwner {
        //arrange
        SafeERC20.safeIncreaseAllowance(IERC20(asset()), address(POOL), amount);

        //returns nothing 
        POOL.supply(address(asset()), amount, address(this), 0);
    }

    function withdrawFromAaveV3() public onlyOwner returns(uint256) {
        return POOL.withdraw(address(asset()), type(uint).max, address(this));
    }
   
}

contract Factory {
    using Clones for address;

    Vault internal v;

    constructor() {
        v = new Vault();
    }

    function getNewVault() public returns(address) {
        
        return address(v).clone();
    }

}
