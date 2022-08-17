import '@nomiclabs/hardhat-ethers'
import { ethers } from "hardhat";
const { expect } = require("chai");

// consola bunu yaz:
// npx hardhat test

// before each()
// before()

describe("Main eth inherit contract", function () {
  it("Should return the role of the person as admin", async function () {
    const [owner] = await ethers.getSigners();
    const Contract = await ethers.getContractFactory("Eth_Inherit");
    const hardhatToken = await Contract.deploy();
    const role = await hardhatToken.getRole(owner.address);

    // enum'da 0 = ADMIN, 1 = PARENT, 2 = CHILD demek.
    expect(0).to.equal(role);
  });
});
