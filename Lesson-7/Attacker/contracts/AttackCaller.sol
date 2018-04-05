pragma solidity ^0.4.18;
import './Attacker.sol';
import './Ownable.sol';

contract AttackCaller is Ownable{
    Attacker attacker;

    //use the attacker from Meng， address is 0x960d1aa9b4e79b8e4fcf4e6853976cfa0b32697f
    function init(address attackerAddress) public onlyOwner{
        attacker = Attacker(attackerAddress);
    }

    //attack the contract from Dong, address is 0x2260d6b770afdc7695b7f000150bc2e9167d4241
    function onAttack(address target, uint count) public onlyOwner{
        attacker.attack(target,count);
    }

    function getBalance() public returns (uint) {
        return attacker.getBalance();
    }
}
