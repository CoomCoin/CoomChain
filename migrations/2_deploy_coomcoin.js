var CoomCoin = artifacts.require("./CoomCoin.sol");

module.exports = function(deployer) {
    deployer.deploy(CoomCoin,690000000);
};