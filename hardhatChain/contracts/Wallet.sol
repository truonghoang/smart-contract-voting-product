pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Wallet {

 

    // Cấu trúc dữ liệu lưu trữ thông tin ví
    struct WalletData {
        address  owner;
        uint256 balance;
        mapping(address => uint256) allowance;
    }
   // Biến để lưu trữ danh sách các ví
    mapping(address => WalletData) private _wallets;
    // Hàm tạo ví mới
    function createWallet() public {
        _wallets[msg.sender] = WalletData({
            owner: msg.sender,
            balance: 0
        });
    }

    // Hàm gửi tiền
    function deposit(uint256 amount) public payable {
        require(amount > 0, "Amount must be greater than 0");

        _wallets[msg.sender].balance += amount;
    }

    // Hàm rút tiền
    function withdraw(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        require(_wallets[msg.sender].balance >= amount, "Insufficient balance");

        _wallets[msg.sender].balance -= amount;
        msg.sender.transfer(amount);
    }

    // Hàm chuyển tiền
    function transfer(address to, uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        require(_wallets[msg.sender].balance >= amount, "Insufficient balance");

        _wallets[msg.sender].balance -= amount;
        _wallets[to].balance += amount;
    }

    // Hàm cho phép chi tiêu
    function approve(address spender, uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");

        _wallets[msg.sender].allowance[spender] = amount;
    }

    // Hàm chuyển tiền với sự cho phép
    function transferFrom(address from, address to, uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        require(_wallets[from].balance >= amount, "Insufficient balance");
        require(_wallets[from].allowance[msg.sender] >= amount, "Allowance exceeded");

        _wallets[from].balance -= amount;
        _wallets[to].balance += amount;
        _wallets[from].allowance[msg.sender] -= amount;
    }

    // Hàm lấy số dư
    function getBalance() public view returns (uint256) {
        return _wallets[msg.sender].balance;
    }

    // Hàm lấy thông tin ví
    function getWalletData() public view returns (WalletData memory) {
        return _wallets[msg.sender];
    }

}
