# Blockchain chỉ đơn giản là một công nghệ lưu trữ, dữ liệu sẽ được lưu trữ trên các block và các block tham chiếu lùi lại với nhau ,tạo sự kết nối với nhau tạo thành blockchain

# Trong mỗi block có metadata và transaction

- Metadata chứ thông tin về block như (thời gian, số của block, block đó tham chiếu đến block trước đó nào)
- Dữ liệu được thay đổi trong block đó (mọi sự thay đổi trong blockchain đều gọi là transaction)
  Điểm nổi bật của blockchain:
- tính immuteability : tính không thể sửa đổi (không ai có thể sửa đổi khi đã ghi lên blockchain chỉ thêm dữ liệu mới không thể thay đổi dữ liệu cũ)
- tính decentralization:

=> nhờ thuật toán consensus mechainism (15-16 thuật toán) đảm bảo không ai được ghi một transaction không hợp lệ lên block

# điểm yếu :

- đắt => trả phí gas
- chậm: do các node cần validator với nhau

# thuật toán cryptographic hash :

- xác định 1 transaction thông qua 1 transaction hash
- không quan trọng dữ liệu to hay nhỏ, mỗi lần hash đều ra một chuỗi giống nhau
- truy ra hash từ dữ liệu gốc , không thể từ hash truy ra dữ liệu gốc
- trong ethereum có thuật toán hash tương tự : Keccak256 giống với sha3 trong secure hash algorithm

# wallet

- Mnemonic phrase là gồm 12 kí tự khóa được sắp xếp dùng để truy cập vào các private key

# Blockchain address

- địa chỉ mà mk sẽ gửi và nhận trên blockchain
- mọi thứ bắt đầu từ private key => dùng thuật toán hash (Elliptic-curve- crytography) hash thành public key gồm 128 kí tự => dùng keccak256 hash 1 lần nữa ra public key gồm 64 kí tự => sau đó lấy 42 kí tự cuối của public key 64 kí tự cộng thêm tiền tố 0x trước nó => tạo thành address
- dùng private key để sign transaction (xác nhận giao dịch)

# có 2 loại address

- **_ EOA (external of account) _** : address của 1 người nào đó
- **_ Contract address _**: address của smart contract sẽ không có private key mà sẽ được controll bằng code của smart contract

# note: bản chất 1 smart contract không thể tự tạo transaction mà từ một EOA gọi đến hàm trong smart contract

# transaction (sự thay đổi ví dụ gửi nhận coin, deploy smart, gọi hàm làm thay đổi dữ liệu trên blockchain)

- thành phần của transaction :

* from : ai gửi transaction đó
* to : gửi tới ai , trong smart contract thì người gọi tới hàm trong smart contract sẽ là from, contract chứa hàm sẽ là to
* value :
* data : (được mã hóa)
* gas: (phí giao dịch mà khi gửi 1 transaction)
 - chống spam
 - trả cho miner hoặc validator node tùy theo consensus
 - người gửi transaction là người trả private key
 - người nào ghi block đó lên blockchain là người được trả gas
 - phụ thuộc vào phức tạp transaction mà lượng gas khác nhau 

- hàm sẽ cộng tất cả các Seri Elementary Instruction ra tổng gas của hàm
- trả gas bằng ethereum = tổng  EI * [gas_price]




# life cycle transaction :

1. build transaction (from ,to, data)
2. sign transaction bằng private key
3. send transaction lên blockchain
4. đợi verify (có thể là từ validator node hoặc minner node)
=> khi transaction được ghi lên blockchain, sẽ nhận lại transaction receipt (giống như 1 hóa đơn)

# smart contract

- ứng dụng nhỏ chạy trên blockchain thông qua EVM

- đặc điểm :
 + code smc không thể thay đổi
 + không bị quản lí bởi tổ chức nào
 + không cần server
 + gửi lưu chuyển tiền tệ dễ dàng

 nhược:
 - tốn đắt : nhiều phí gas
 - chậm
 - khả năng lưu trữ giới hạn (do đắt)
 - smc không thể gọi api ngoài
*** build 1 smc (smart contract) ***:

1. code smart contract
2. compile code thành EVm bytecode
3. gửi transaction contract creation + EVM bytecode lên blockchian
4. chờ transaction được đào bởi minner, khi đào được thì smart contract sẵn sàng trên blockchain

*** giao tiếp giữa smart contract ***

-

# Dapp
- cấu trúc 
 + viết smart contract, deploy lên blockchain
 + tạo frontend
 + giao tiếp với chương trình quản lí ví
 + giao tiếp vs smart contract vs web3
- các bước build Dapp
 + xác định logic smart contract
 + code smart contract (remix, truffle, hardhat)
 + test smart contract (test toàn bộ hàm trong smc happy-pass và unhappy-pass)
 + deploy testnet ()
 + deploy lên mainet

 # cách tạo 1 account wallet

1. Tạo Seed Phrase:
  - MetaMask sẽ tạo ra một cụm từ bí mật gồm 12 từ ngẫu nhiên.
  - Seed phrase này là bản sao lưu của private key của bạn và cần được lưu trữ an toàn.
  - Đừng bao giờ chia sẻ seed phrase của bạn với bất kỳ ai.
  - Viết seed phrase ra giấy và cất giữ ở nơi an toàn.
2. Tạo Mật Khẩu:

- Bạn sẽ được yêu cầu tạo một mật khẩu để bảo vệ tài khoản MetaMask của bạn.
- Mật khẩu này khác với seed phrase của bạn.
- Sử dụng mật khẩu mạnh và duy nhất cho MetaMask.
3. Khởi Tạo Ví:
 - MetaMask sẽ sử dụng seed phrase và mật khẩu của bạn để tạo ví trên blockchain Ethereum.
 - Quá trình này có thể mất vài phút.
`
 # cách lấy lại mật khẩu ví 

 Cách thức hoạt động:

1. Khi bạn chọn "Quên mật khẩu" trong MetaMask, bạn sẽ được yêu cầu nhập seed phrase.
2. Seed phrase là bản sao lưu của private key (khóa bí mật) của bạn, cho phép bạn truy cập vào tài khoản MetaMask của mình.
3. MetaMask sẽ sử dụng seed phrase để tạo lại private key và mật khẩu mới cho bạn.
4. Bạn có thể sử dụng mật khẩu mới để đăng nhập vào tài khoản MetaMask của mình.