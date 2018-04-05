pragma solidity ^0.4.14;
contract TimeDelayedVault {
  uint  public nextWithdrawTime;
  uint  public withdrawCoolDownTime;
  address public withdrawObserver;
  address public additionalAuthorizedContract;
  address public proposedAAA;
  uint public lastUpdated = 455;
  bool[] public votes;
  address [] public observerHistory;
  address[] public authorizedUsers;
  address public owner;

  function TimeDelayedVault(address libAddress) public {
    //authorizedUsers.push(libAddress);
  }

  function setObserver(address ob) {
  }

  function addToReserve() {
  }


  function withdrawFund() external returns (bool) {
      return false;
  }

  function addAuthorizedAccount(uint votePosition, address proposal) external {
  }

  function resolve() {
  }

  function initilizeVault() {
  }

}
