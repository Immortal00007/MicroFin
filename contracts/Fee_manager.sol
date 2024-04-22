// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;



import "./LendingPool.sol";

contract FeeManager {
    LendingPool public lendingPool;

    uint256 public platformFeePercentage;

    event FeeCharged(address indexed payer, uint256 amount);

    constructor(address _lendingPool, uint256 _platformFeePercentage) {
        lendingPool = LendingPool(_lendingPool);
        platformFeePercentage = _platformFeePercentage;
    }

    function chargeFee(uint256 amount) external {
        uint256 fee = (amount * platformFeePercentage) / 100;
        lendingPool.balances[msg.sender] -= fee;
        lendingPool.balances[lendingPool.feeReceiver()] += fee;
        emit FeeCharged(msg.sender, fee);
    }
}
