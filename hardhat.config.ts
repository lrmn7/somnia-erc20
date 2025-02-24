import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.26",
  networks: {
    "somnia-devnet": {
      url: "https://somnia-poc.w3us.site/api/eth-rpc",
      chainId: 50311,
      accounts: ["private key"]
    },
  },
  etherscan: {
    apiKey: {
      "somnia-devnet": "empty",
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
