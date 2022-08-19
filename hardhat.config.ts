/** @type import('hardhat/config').HardhatUserConfig */
import '@nomiclabs/hardhat-ethers'
require("@nomicfoundation/hardhat-toolbox");
module.exports = {
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {},
    localhost: {

    }
  },
  solidity: "0.8.16",
};
