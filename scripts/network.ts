const { ethers } = require("hardhat");
import '@nomiclabs/hardhat-ethers'

async function main() {
    const network = await ethers.getDefaultProvider().getNetwork();
    console.log("Network name=", network.name);
    console.log("Network chain id=", network.chainId);
    console.log("Network url=", network.url);
}
  
main()
.then(() => process.exit(0))
.catch((error) => {
    console.error(error);
    process.exit(1);
});