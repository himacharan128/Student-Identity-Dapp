const DigiIdentity = artifacts.require("./DigitalIdentity.sol");

module.exports = function(deployer) {
    deployer.deploy(DigiIdentity);
};