pragma solidity ^0.4.14;
import './ArrayHelper.sol';

contract ArrayCaller{
  ArrayHelper helper;

  function ArrayCaller() {

  }

  function init(address host) {
    helper = ArrayHelper(host);
  }

  function getLength() returns (uint) {
    return helper.getLength();
  }

  function getAddress() returns (uint[]) {
    uint[] result;
    for(uint i = 0; i < helper.getLength(); i++){
      result.push(helper.myAddress(i));
    }
  }
  
}
