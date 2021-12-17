pragma solidity ^0.5.0;

contract AssociateProfitSplitter {
    // Create three payable addresses representing `employee_one`, `employee_two` and `employee_three`
    address payable employee_one;
    address payable employee_two;
    address payable employee_three;

    // Create a constructor function, and set set the employee addresses to equal the parameter values
    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }
    // balance function that will return the contract's current balance: (this) represents contract address
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        // Split `msg.value` into three
        uint amount = msg.value / 3; 

        // Transfer the amount to each employee
        employee_one.transfer(amount);
        employee_two.transfer(amount);
        employee_three.transfer(amount);
        

        // Take care of a potential remainder by sending back to HR (`msg.sender`)
        uint remainder = msg.value - (amount * 3);
        msg.sender.transfer(remainder);
    }

    function() external payable {
        // Enforce that the `deposit` function is called in the fallback function!
        deposit();
        
    }
}