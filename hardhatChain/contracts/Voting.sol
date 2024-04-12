// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Voting {
    /*  variable */
    uint256 public productCount; // dùng để khởi tạo id
    /*  struct */
    struct ProductFeedBack {
        uint256 productId;
        address reviewer;
        uint8 rating;
        string reviewText;
        string timestamp;
    }
    struct Product {
        uint256 productId;
        string name;
        string imageLink;
    }
    struct RateProduct {
        uint256 productId;
        uint8 rate;
        uint256 countUser;
    }
    struct ProductOwner {
        // address voterAddress;
        uint256 productId;
        uint8 rate;
    }

    /*  contructor */

    constructor() {
        Product memory newProduct = Product({
            productId: 0,
            name: "default",
            imageLink: "default"
        });
        products[0] = newProduct;
        productCount++;
    }

    /*  modifier */
    modifier checkName(string memory name, string memory link) {
        require(bytes(name).length > 0, "Product name cannot be empty");
        require(bytes(link).length > 0, "Product link cannot be empty");
        _;
    }

    modifier voteRate(uint8 voteRates) {
        require(
            voteRates > 0 && voteRates <= 5,
            "Vote rates cannot be empty and maximum 5"
        );
        _;
    }

    modifier hasVote(uint256 productId) {
        require(
            hasVotedProduct[productId][msg.sender] == false,
            "This product has voted by you"
        );
        _;
    }
    modifier checkPage(uint page, uint limit) {
        require(page > 0 && limit > 0, "page or limit invalid");
        _;
    }
    modifier productValidate(uint productId){
         require(productId>=1,"ProductId must be greater than 0");
         _;
    }
    /*  mapping 
      - ánh xạ address đại diện là key của mapping
      - User đại diện cho value của mapping
      - voters tên của biến khi mappings
      - mapping save as : voters[address] = User
      - sử dụng mapping lưu trữ dữ liệu tốn ít bộ nhớ hơn vs mảng
     */

    mapping(address => mapping(uint256 => ProductFeedBack)) productFeedBacks; // get info by user voted
    mapping(uint256 => Product) products; // get info by user;
    mapping(uint256 => mapping(address => bool)) hasVotedProduct;
    mapping(uint256 => RateProduct) rateProducts;
    mapping(address => ProductOwner[]) productOwners; // ánh xạ address với 1 mảng productOwner
    /*  event */
    event ProductAdded(uint256 indexed productId, string name);

    event FeedBack(address indexed voter, uint256 indexed productId);

    /*  function */
    /*  function add product*/
    function addProduct(
        string memory name,
        string memory imageLink
    ) public checkName(name,imageLink) {
        uint256 productId = productCount++;

        Product memory newProduct = Product({
            productId: productId,
            name: name,
            imageLink: imageLink
        });

        products[productId] = newProduct;

        emit ProductAdded(productId, name);
    }
    /* đánh giá sản phẩm */

    function feedbackProduct( uint256 productId, string memory reviewText,  uint8 rating,  string memory timestamp ) public voteRate(rating) hasVote(productId) {
        ProductFeedBack memory newProductFeedBack = ProductFeedBack({
            productId: productId,
            reviewText: reviewText,
            reviewer: msg.sender,
            timestamp: timestamp,
            rating: rating
        });

        productFeedBacks[msg.sender][productId] = newProductFeedBack;

        RateProduct memory rateProduct = rateProducts[productId]; // Lấy tham chiếu đến RateProduct từ mapping

        uint userUp = rateProduct.countUser + 1; // Tăng countUser lên 1

        uint rateChange = (rateProduct.rate * rateProduct.countUser + rating) / userUp;

        rateProducts[productId].countUser = userUp; // Cập nhật countUser mới

        rateProducts[productId].rate = uint8(rateChange); // Cập nhật giá trị rate mới

        productOwners[msg.sender].push(ProductOwner(productId, rating)); // thêm sản phẩm vào danh sách của người vote

        hasVotedProduct[productId][msg.sender]=true;

        emit FeedBack(msg.sender, productId);
    }

    /* thông tin về tổng đánh giá của một product*/
    function getRatingProduct(
        uint productId
    ) public view productValidate(productId) returns (uint8, uint256) {

        RateProduct memory rateResult = rateProducts[productId];

        return (rateResult.rate, rateResult.countUser);
    }

    function detailProductVote(uint productId) public view returns (ProductFeedBack memory){

         return productFeedBacks[msg.sender][productId] ;

    }

    /** lấy tất cả sản phẩm  */
    function getPaginationProduct(uint limit, uint page  ) public view checkPage(page,limit) returns (Product[] memory allProduct)  {
       
        if (productCount <1) {
            return new Product[](1);
        }
        allProduct = new Product[](limit);
        uint element = (page - 1) * limit + limit;
        uint index = (page - 1) * limit + 1;

       
        if (index > productCount) {
            return new Product[](1); 
        }

        for (uint i = index; i <= element ; i++) {
           allProduct[i - 1] = products[i];  
        }
        return allProduct;
    }

    /** lấy danh sách các sản phẩm đã vote     */

    function getProductOwners() public view returns (ProductOwner[] memory) {
        if (productOwners[msg.sender].length == 0) {
            return new ProductOwner[](1);
        } else {
            return productOwners[msg.sender];
        }
    }
}
