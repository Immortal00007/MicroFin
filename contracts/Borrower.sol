// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;


import "./LendingPool.sol";

contract Borrower {
    LendingPool public lendingPool;

    event Borrow(address indexed borrower, uint256 amount);
    event Repay(address indexed borrower, uint256 amount);

    constructor(address _lendingPool) {
        lendingPool = LendingPool(_lendingPool);
    }

    function borrow(uint256 amount, uint256 interestRate) external {
        lendingPool.lend(msg.sender, amount, interestRate);
        emit Borrow(msg.sender, amount);
    }

    function repay(uint256 amount) external payable {
        lendingPool.repay{value: msg.value}();
        emit Repay(msg.sender, amount);
    }
}
