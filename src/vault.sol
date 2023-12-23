// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {ERC4626} from "solmate/mixins/ERC4626.sol";
import {ERC20} from "solmate/tokens/ERC20.sol";
import {IERC20} from "openzeppelin/token/ERC20/IERC20.sol";
import {SafeERC20} from "openzeppelin/token/ERC20/utils/SafeERC20.sol";
import {Owned} from "solmate/auth/Owned.sol";
import {IPool} from "aave-v3-core/interfaces/IPool.sol";
import {IPoolAddressesProvider} from "aave-v3-core/interfaces/IPoolAddressesProvider.sol";


contract vault is ERC4626, Owned {

    IPoolAddressesProvider public immutable POOL_PROVIDER; //0x012bAC54348C0E635dCAc9D5FB99f06F24136C9A
    IPool public immutable POOL;

    constructor(
        address _asset,//
        string memory _name,
        string memory _symbol,
        address _poolProvider
    ) ERC4626(ERC20(_asset),_name,_symbol) Owned(msg.sender) {
        POOL_PROVIDER = IPoolAddressesProvider(_poolProvider);
        POOL = IPool(POOL_PROVIDER.getPool());
    }

    function totalAssets() public view override returns (uint256){
        return asset.balanceOf(address(this));
    }

    function supplyToAaveV3(uint256 amount) public onlyOwner {
        //arrange
        SafeERC20.safeIncreaseAllowance(IERC20(address(asset)), address(POOL), amount);

        //returns nothing 
        POOL.supply(address(asset), amount, address(this), 0);
    }

    function withdrawFromAaveV3() public onlyOwner returns(uint256) {
        return POOL.withdraw(address(asset), type(uint).max, address(this));
    }
   
}
