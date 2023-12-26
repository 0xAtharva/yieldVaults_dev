## yieldVaults

An ERC4626 implementation of a vault that accepts DAI as assets and generates yield via AAVE yield pool.

1.  DAI : 0xFF34B3d4Aee8ddCd6F9AFFFB6Fe49bD371b8a357
2.  AAVE pool provider : 0x012bAC54348C0E635dCAc9D5FB99f06F24136C9A
3.  deployed yieldvault : 0x6cf050C2aFC6ed386d805629Ef815A9839292277

**Note** : each user has to deploy his own vault with, as given below.

### compile
``forge build``

### deploy
``forge script script/deploy.s.sol:deployScript --rpc-url $SEPOLIA_RPC_URL --broadcast --verify -vvvv``

