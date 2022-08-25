/** @type import('hardhat/config').HardhatUserConfig */
import '@nomiclabs/hardhat-ethers'
require("@nomicfoundation/hardhat-toolbox");
module.exports = {
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      chainId: 31337,
    },
    localhost: {
      url: "http://127.0.0.1:8545/",
    },
  },
  solidity: "0.8.16",
};
