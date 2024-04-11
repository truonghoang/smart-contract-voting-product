
const { ethers } = require("hardhat");
const Voting = require("../artifacts/contracts/Voting.sol").Voting;
const {expect} = require("chai")
describe("Voting Contract", function () {
    
  before(async ()=>{
    const signer = await ethers.getSigner();
    
  })
 it("should",async () => {
  const [owner] = await ethers.getSigner();
  const Voting = await ethers.deployContract('Voting')
 })
  // More test cases for other functions...
 
});
