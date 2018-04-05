var AttackCaller = artifacts.require("./AttackCaller.sol");
module.exports = function(deployer) {
  deployer.deploy(AttackCaller);
};
