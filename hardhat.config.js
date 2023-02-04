require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: {
    version:   "0.8.17",
    settings: {
      optimizer: {
        enabled: true,
        runs: 1,
      },
      "viaIR": true,

    }
  },
  networks: {
    localganache: {
      url: process.env.PROVIDER_URL,
      accounts: [`0x${process.env.PRIVATE_KEY}`]
    }
  }
};