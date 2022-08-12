const { expect } = require("chai");

describe("Getter setter contract", function () {
  it("Should display the text", async function () {
    const HelloWorld = await ethers.getContractFactory("HelloWorld");
    const hardhatToken = await HelloWorld.deploy();
    const gettedText = await hardhatToken.get();

    expect(gettedText).to.equal("Hello World !");
  });
});
