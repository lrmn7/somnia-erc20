import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import dotenv from "dotenv";

dotenv.config();

const config: HardhatUserConfig = {
  solidity: "0.8.28", // replace if necessary
  networks: {
    'somnia-devnet': {
      url: 'https://somnia-poc.w3us.site/api/eth-rpc'
    },
  },
  etherscan: {
    apiKey: {
      'somnia-devnet': 'empty'
    },
    customChains: [
      {
        network: "somnia-devnet",
        chainId: 50311,
        urls: {
          apiURL: "https://somnia-poc.w3us.site/api",
          browserURL: "https://somnia-poc.w3us.site"
        }
      }
    ]
  }
};

export default config;
