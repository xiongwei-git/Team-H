//var SimpleStorage = artifacts.require("./SimpleStorage.sol");
// var Ownable = artifacts.require("./Ownable.sol");
// var SafeMath = artifacts.require("./SafeMath.sol");
//var Payroll = artifacts.require("./Payroll.sol");
var Attacker = artifacts.require("./Attacker.sol");

module.exports = function(deployer) {
  //deployer.deploy(SimpleStorage);
  // deployer.deploy(Ownable);
  // deployer.deploy(SafeMath);
  // deployer.link(Ownable,Payroll);
  // deployer.link(SafeMath,Payroll);
  //deployer.deploy(Payroll);
  deployer.deploy(Attacker);
};
