// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

library DataTypes {
    struct Loan {
        address borrower;
        uint256 amount;
        uint256 interestRate;
        uint256 duration; // Duration of the loan in seconds
        uint256 startTime; // Time when the loan was initiated
        bool repaid; // Flag indicating if the loan has been repaid
        bool active; // Flag indicating if the loan is active
    }
}

contract LendingPool {

    mapping(address => uint256) public balances; // Balances of lenders
    mapping(address => Loan) public loans; // Active loans by borrower address

    address public feeReceiver; // Address that receives fees
    uint256 public platformFeePercentage; // Fee percentage charged by the platform

    event Deposit(address indexed lender, uint256 amount);
    event Borrow(address indexed borrower, uint256 amount, uint256 interestRate);
    event Repay(address indexed borrower, uint256 amount);

    constructor(address _feeReceiver, uint256 _platformFeePercentage) {
        feeReceiver = _feeReceiver;
        platformFeePercentage = _platformFeePercentage;
    }

    // Implement functions for managing loans, interest, fees, etc.
}






