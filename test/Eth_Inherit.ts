import '@nomiclabs/hardhat-ethers'
import { ethers } from "hardhat";
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");
const { expect } = require("chai");

// consola bunu yaz:
// npx hardhat test

// before each()
// before()

describe("Main eth inherit contract", async function () {

  async function deployTokenFixture() {
    const Contract = await ethers.getContractFactory("Eth_Inherit");
    const [owner, add1, add2] = await ethers.getSigners();
    const hardhatToken = await Contract.deploy();   

    await hardhatToken.deployed();

    return {Contract, hardhatToken, owner, add1, add2};
  }
  
  it("Should return the role of the person as admin", async function () {
    const{hardhatToken, owner} = await loadFixture(deployTokenFixture);
    const role = await hardhatToken.getRole(owner.address);

    // enum'da 0 = ADMIN, 1 = PARENT, 2 = CHILD, 3 = UNREG demek.
    expect(0).to.equal(role);
  })

  it("Should add a child to a parent", async function () {
    const{hardhatToken, add1, add2} = await loadFixture(deployTokenFixture);

    await hardhatToken.connect(add1).addParent(add1.address, "Gökay", "Erez");
    await hardhatToken.connect(add1).addChild(add2.address, "Abdürrezzak", "Erez", 2518220800, { value: ethers.utils.parseEther("5") });
    console.log("added child to parent")

    const balance = await hardhatToken.getChildBalance(add2.address);
    console.log("got the balance of child: ", balance)

    expect(balance).to.equal(ethers.utils.parseEther("5"));

  })

});
