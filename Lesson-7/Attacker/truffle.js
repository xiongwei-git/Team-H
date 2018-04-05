var HDWalletProvider = require("truffle-hdwallet-provider");
var mnemonic = "all chunk subway drop another cat human element drastic crazy glance sense";
module.exports = {
  migrations_directory: "./migrations",
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*", // Match any network id
      //from: "0xdC75EB0973F96b735087B6B2f20ef73595509354"
    },
    ropsten: {
      // provider: function() {
      //   return new HDWalletProvider(mnemonic, "https://ropsten.infura.io/btMU7XaHF8J9L2SYkqTA");
      // },
      provider: new HDWalletProvider(mnemonic, "https://ropsten.infura.io/btMU7XaHF8J9L2SYkqTA"),
      gas: 2706583,
      network_id: '3',
    }
  }


  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  // networks: {
  //    development: {
  //        host: "127.0.0.1",
  //        port: 8545,
  //        network_id: "*", // Match any network id
  //        //from: "0xdC75EB0973F96b735087B6B2f20ef73595509354"
  //        }
  //    }
};
