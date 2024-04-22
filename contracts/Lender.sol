// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;


import "./LendingPool.sol";

contract Lender {
    LendingPool public lendingPool;

    event Withdraw(address indexed lender, uint256 amount);

    constructor(address _lendingPool) {
        lendingPool = LendingPool(_lendingPool);
    }

    function deposit() external payable {
        lendingPool.balances[msg.sender] += msg.value;
        emit LendingPool.Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external {
        require(amount <= lendingPool.balances[msg.sender], "Insufficient balance");
        lendingPool.balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }

    function setLendingRate(address borrower, uint256 interestRate) external {
        require(interestRate >= 0, "Interest rate must be non-negative");
        lendingPool.lend(borrower, 0, interestRate); // Lend 0 amount to set the interest rate
    }
}
