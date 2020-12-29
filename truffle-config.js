
require('dotenv').config();
const HDWalletProvider = require("truffle-hdwallet-provider");

module.exports = {
  /**
   * Networks define how you connect to your ethereum client and let you set the
   * defaults web3 uses to send transactions. If you don't specify one truffle
   * will spin up a development blockchain for you on port 9545 when you
   * run `develop` or `test`. You can ask a truffle command to use a specific
   * network from the command line, e.g
   *
   * $ truffle test --network <network-name>
   */

  networks: {
    mainnet: {
      provider: () => new HDWalletProvider(process.env.MAINNET_PRIVATE_KEY, process.env.MAINNET_URL),
      network_id: 1,
      gasPrice: 450000000000,
      gas: 3000000
    },
    rinkeby: {
      provider: () => new HDWalletProvider(process.env.RINKEBY_PRIVATE_KEY ,process.env.RINKEBY_URL),
      network_id: 4,
      gasPrice: 20000000000
    },
    development: {
      host: '127.0.0.1',
      port: 7545,
      network_id: '*',
      gasPrice: 450000000000
    }
  },

  // Set default mocha options here, use special reporters etc.
  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      // version: "0.5.1",    // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      // settings: {          // See the solidity docs for advice about optimization and evmVersion
      //  optimizer: {
      //    enabled: false,
      //    runs: 200
      //  },
      //  evmVersion: "byzantium"
      // }
    },
  },
};
