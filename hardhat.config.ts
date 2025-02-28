import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-verify";
import dotenv from "dotenv";

dotenv.config();

const config: HardhatUserConfig = {
  solidity: "0.8.26",
  networks: {
    'somnia-testnet': {
      url: 'https://somnia-poc.w3us.site/api/eth-rpc'
    },
  },
  etherscan: {
    apiKey: {
      'somnia-testnet': 'empty'
    },
    customChains: [
      {
        network: "somnia-testnet",
        chainId: 50311,
        urls: {
          apiURL: "https://somnia-poc.w3us.site/api",
          browserURL: "https://somnia-poc.w3us.site"
        }
      }
    ]
  },
  sourcify: {
    enabled: true,
  },
};

export default config;
