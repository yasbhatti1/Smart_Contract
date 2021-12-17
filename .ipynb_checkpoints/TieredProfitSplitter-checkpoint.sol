pragma solidity ^0.5.0;

contract TieredProfitSplitter {
    address payable employee_one; // ceo
    address payable employee_two; // cto
    address payable employee_three; // bob

    // Create a constructor function, and set set the employee addresses to equal the parameter values
    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

    // Should always return 0! Use this to test your `deposit` function's logic
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        // Calculates rudimentary percentage by dividing msg.value into 100 units and declare variables
        uint points = msg.value / 100; 
        uint total;
        uint amount;

        // Calculate and transfer the distribution percentage

        // Step 1: Set amount to equal `points` * the number of percentage points for this employee
        amount = points * 60;
        // Add the `amount` to `total` to keep a running total
        total += amount;
        // Transfer the `amount` to the employee
        employee_one.transfer(amount);


        // Repeat the previous steps for `employee_two` with appropriate percentage points
        amount = points * 25;
        total += amount;
        employee_two.transfer(amount);

        // // Repeat the previous steps for `employee_three` with appropriate percentage points
        amount = points * 15;
        total += amount;
        employee_three.transfer(amount);

        // // ceo (employee_one) gets the remaining value
        employee_one.transfer(msg.value - total); 
    }

    function() external payable {
         // Enforce that the `deposit` function is called in the fallback function!
        deposit();
    }
}

