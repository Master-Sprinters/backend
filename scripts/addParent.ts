import {ethers} from "hardhat";
import '@nomiclabs/hardhat-ethers'
import { getAddress } from "ethers/lib/utils";

async function main () {
/*     const accounts = await ethers.provider.listAccounts();
    console.log(accounts); */

    const address = '0x5FbDB2315678afecb367f032d93F642f64180aa3';
    const Eth_Inherit = await ethers.getContractFactory('Eth_Inherit');
    const eth_inherit = await Eth_Inherit.attach(address);

    const admin = await eth_inherit.getRole(getAddress('0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266'));
    console.log(admin);
  }
  
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });
    