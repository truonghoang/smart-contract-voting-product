# Sample Hardhat Project

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat ignition deploy ./ignition/modules/Voting.ts
```
# TECHNICAL
- hardhat
- react/nextjs
- etherjs
- server node
- database mysql
# cách thức sử dụng và tối ưu
- cách 1: lưu thông tin người dùng và sản phẩm trên db tập trung và lưu product(id,vote,total vote,) và user (addressUser,) comment(productId,addressUser,comment) trên phi tập trung
- cách 2: lưu toàn bộ trên blockchain
# advantage :
- secure : no chance
- transparency : everybody can check voting data
# disadvantages :
- fee : expensive
- extend : difficult when having people vote  
# introduce hardhat:
- a development environment to compile, deploy,test and debug your Ether software
# introduce ether:
- library aim to be a complete and compact library for interacting with Ethereum BlockChain
# metamask method :
- isConnected()
- request({method: "eth_requestAccounts"}) : get address of MT wallet
- request({method: "eth_getBalance"}) : get balance of wallet
- request({method: "wallet_requestPermissions"})
- request({method: "wallet_addEthereumChain"})
- request({method: "eth_switchEthereumChain"})
- request({method: "eth_sendTransaction"})

# SET UP PROJECT

- I : hardhat setup

 1. init project hardhat : npx hardhat init ( if you want to init the project)
 2. structure project 
   - /contract : write contract here
   - /test: write test here
   - /ignition/modules: write deploy contract here
   - hardhat.config.ts|js : config it here
 
- II: step to deploy to network blockchain local

  1. test is extremely important : npx hardhat test | write script in package.json
  2. deploy local : npx hardhat node | write script in package.json
  3. ignition in block local : npx hardhat ignition deploy ignition/modules/Voting.ts --network localhost | write script in package.json

note :  nằm ngoài phạm vi an toàn của js :nếu loại nằm trong phạm vi an toàn của JavaScript (tức là dưới 53 bit, chẳng hạn như int24 hoặc uint48), thì số JavaScript bình thường sẽ được sử dụng Nếu không thì BigNumber sẽ được trả về

