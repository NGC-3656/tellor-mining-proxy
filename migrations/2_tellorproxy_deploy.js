const ChiGasSaver = artifacts.require("ChiGasSaver");
const TellorProxy = artifacts.require("TellorProxy");

module.exports = async function (deployer) {

  if (network == "rinkeby" || network == "rinkeby-fork") {

    tellorOracleAddress = "0xFe41Cb708CD98C5B20423433309E55b53F79134a";
    chiAddress = "You must deploy your own CHI to rinkeby then mint some chi";

  } else if (network == "mainnet" || network == "mainnet-fork") {

    tellorOracleAddress = "0x0ba45a8b5d5575935b8158a88c631e9f9c95a2e5";
    chiAddress = "0x0000000000004946c0e9F43F4Dee607b0eF1fA1c";

  }
  await deployer.deploy(ChiGasSaver);
  await deployer.deploy(TellorProxy, tellorOracleAddress, chiAddress);
};
