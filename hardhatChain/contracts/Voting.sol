// SPDX-License-Identifier: none
pragma solidity ^0.8.19;

contract ProductVoting {
    // tạo struct để lưu cấu trúc dữ liệu liên quan
    struct Product {
        string name;
        uint256 totalVotes;
        uint256[] voteCounts;
    }

    struct Voter {
        address voterAddress;
        uint256 productId;
        uint256 voteIndex;
    }

    mapping(address => Voter) voters;
    mapping(uint256 => Product) products;
    uint256 public productCount;

    event ProductAdded(uint256 indexed productId, string name);
    event VoteCast(address indexed voter, uint256 indexed productId, uint256 voteIndex);

    function addProduct(string memory name, uint256[] memory voteRates) public {
        require(bytes(name).length > 0, "Product name cannot be empty");
        require(voteRates.length > 0, "Vote rates cannot be empty");

        products[productCount++] = Product({
            name: name,
            totalVotes: 0,
            voteCounts: voteRates
        });

        emit ProductAdded(productCount - 1, name);
    }

    function vote(uint256 productId, uint256 voteIndex) public {
        require(productId < productCount, "Invalid product ID");
        require(voteIndex < products[productId].voteCounts.length, "Invalid vote index");
        require(voters[msg.sender].productId == 0, "You have already voted");

        voters[msg.sender] = Voter({
            voterAddress: msg.sender,
            productId: productId,
            voteIndex: voteIndex
        });

        products[productId].totalVotes++;
        products[productId].voteCounts[voteIndex]++;

        emit VoteCast(msg.sender, productId, voteIndex);
    }

    function getProducts() public view returns (Product[] memory) {
        Product[] memory allProducts = new Product[](productCount);
        for (uint256 i = 0; i < productCount; i++) {
            allProducts[i] = products[i];
        }
        return allProducts;
    }

    function getVoteCounts(uint256 productId) public view returns (uint256[] memory) {
        require(productId < productCount, "Invalid product ID");
        return products[productId].voteCounts;
    }

    function getTotalVotes(uint256 productId) public view returns (uint256) {
        require(productId < productCount, "Invalid product ID");
        return products[productId].totalVotes;
    }

    function hasUserVoted(address user) public view returns (bool) {
        return voters[user].productId != 0;
    }

    function getVoteDetails(address user) public view returns (uint256, uint256) {
        require(hasUserVoted(user), "User has not voted");
        Voter memory voter = voters[user];
        return (voter.productId, voter.voteIndex);
    }
}