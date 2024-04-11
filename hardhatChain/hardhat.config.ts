import { HardhatUserConfig ,vars} from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-ethers"; 
// const ETHERSCAN_API_KEY = vars.get("ETHERCAN_API_KEY");
const config: HardhatUserConfig = {
  solidity: "0.8.24",
  // etherscan :{
  //   apiKey: ETHERSCAN_API_KEY
  // }
  

};

export default config;
