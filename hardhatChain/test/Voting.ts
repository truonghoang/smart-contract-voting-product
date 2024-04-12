const {expect} = require('chai')
const {ethers} = require("hardhat")

describe("Deploy Voting",async () => {
    let votingContract:any;
    beforeEach(async function () {
        const Voting = await ethers.getContractFactory("Voting");
        votingContract = await Voting.deploy();
       
      });
    describe("addProduct", function () {
        it("should create a new product with valid name and image link", async function () {
          const name = "Test Product";
          const imageLink = "https://example.com/image.jpg";
          const tx = await votingContract.addProduct(name, imageLink);
          await tx.wait();
          const productCount = await votingContract.productCount();
          expect(productCount).to.equal(2); // Initial product + new product
        });
    
        it("should revert if name is empty", async function () {
          const imageLink = "https://example.com/image.jpg";
          await expect(votingContract.addProduct("", imageLink)).to.be.revertedWith(
            "Product name cannot be empty"
          );
        });
        it("should revert if link is empty", async function () {
            const name = "testsp1";
            await expect(votingContract.addProduct(name,"")).to.be.revertedWith(
              "Product link cannot be empty"
            );
          });
      });
      describe("feedBackProduct", function () {
          const productId = 1;
          const reviewText = "test"
          const rating = 4;
          const timestamp = "11-12-2024"
        it("should create a new feedback with valid name and image link", async function () {
          const tx = await votingContract.feedbackProduct(productId, reviewText,rating,timestamp);
          await tx.wait();
         
        });
    
        it("should revert if rate is invalid", async function () {
          const revertRate = 6
          await expect(votingContract.feedbackProduct(productId, reviewText,revertRate,timestamp)).to.be.revertedWith(
            "Vote rates cannot be empty and maximum 5"
          );
        });
        it("should revert if user has already voted for the product", async function () {
         
          await votingContract.feedbackProduct(productId, reviewText, rating, timestamp); // First vote
    
          await expect(votingContract.feedbackProduct(productId, reviewText, rating, timestamp)).to.be.revertedWith(
            "This product has voted by you"
          );
        });
      });
      describe("getRatingProduct",function (){
        const productId = 1
        it("should get rating product",async ()=>{
          
           await votingContract.getRatingProduct(productId);
        })
        it("should revert if productId invalid",async()=>{
          await expect(votingContract.getRatingProduct(0)).to.be.revertedWith(
            "ProductId must be greater than 0"
          );
        })
      })

      describe("getPaginationProduct",function (){
        const page = 1;
        const limit =10;
        it("should get pagination product",async ()=>{
          
           await votingContract.getPaginationProduct(limit,page);
        })
        it("should revert if page and limit invalid",async()=>{
          await expect(votingContract.getPaginationProduct(0,0)).to.be.revertedWith(
            "page or limit invalid"
          );
        })
      })
})