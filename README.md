## yieldVaults

An ERC4626 implementation of a vault that accepts DAI as assets and generates yield via AAVE yield pool.
1.  users can deploy minimal clones of the vault implementation contract
2.  beacon proxy upgradable main vault implementation.
3.  test cases for correct smart contract behaviour prior to deployment
4.  tools : solidity, openzeppelin-upgradable, AAVE, DAI, foundry, sepolia testnet, infura, ethers.js, HTML, CSS, JavaScript

## clone and try locally
### clone the repo
``git clone [link]``
``cd yieldVaults_dev``

### test
``forge test -vvv``

