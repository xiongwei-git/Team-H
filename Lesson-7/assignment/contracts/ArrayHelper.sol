pragma solidity ^0.4.14;

contract ArrayHelper{
  uint[] public myAddress = [1,2,3,4,5];

  function ArrayHelper() {
  }

  function getLength() returns (uint) {
    return myAddress.length;
  }

  function addAddress(uint add) {
    myAddress.push(add);
  }

}
