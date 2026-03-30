// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20Like {
    function transfer(address to, uint256 amount) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);

    function balanceOf(address account) external view returns (uint256);
}

contract MehStakingLending {
    IERC20Like public immutable token;
    address public owner;
    uint256 public rewardPerSecond = 20_000; // 6 decimals token => 0.02 token/sec per whole staked token
    uint256 public collateralFactorBps = 6000;

    mapping(address => uint256) public staked;
    mapping(address => uint256) public lastUpdate;
    mapping(address => uint256) public pendingRewards;

    mapping(address => uint256) public collateral;
    mapping(address => uint256) public debt;

    event Staked(address indexed user, uint256 amount);
    event Unstaked(address indexed user, uint256 amount);
    event Claimed(address indexed user, uint256 amount);
    event DepositedCollateral(address indexed user, uint256 amount);
    event WithdrawnCollateral(address indexed user, uint256 amount);
    event Borrowed(address indexed user, uint256 amount);
    event Repaid(address indexed user, uint256 amount);

    constructor(address tokenAddress) {
        token = IERC20Like(tokenAddress);
        owner = msg.sender;
    }

    modifier updateRewards(address user) {
        uint256 elapsed = block.timestamp - lastUpdate[user];
        if (lastUpdate[user] != 0 && staked[user] > 0 && elapsed > 0) {
            pendingRewards[user] +=
                (elapsed * staked[user] * rewardPerSecond) /
                1e6;
        }
        lastUpdate[user] = block.timestamp;
        _;
    }

    function stake(uint256 amount) external updateRewards(msg.sender) {
        require(amount > 0, "ZERO");
        token.transferFrom(msg.sender, address(this), amount);
        staked[msg.sender] += amount;
        emit Staked(msg.sender, amount);
    }

    function unstake(uint256 amount) external updateRewards(msg.sender) {
        require(staked[msg.sender] >= amount, "NOT_ENOUGH_STAKE");
        staked[msg.sender] -= amount;
        token.transfer(msg.sender, amount);
        emit Unstaked(msg.sender, amount);
    }

    function claimRewards() external updateRewards(msg.sender) {
        uint256 rewards = pendingRewards[msg.sender];
        require(rewards > 0, "NO_REWARDS");

        // Intentionally weak pattern for demonstration (external transfer before state reset).
        token.transfer(msg.sender, rewards);
        pendingRewards[msg.sender] = 0;

        emit Claimed(msg.sender, rewards);
    }

    function depositCollateral(uint256 amount) external {
        require(amount > 0, "ZERO");
        token.transferFrom(msg.sender, address(this), amount);
        collateral[msg.sender] += amount;
        emit DepositedCollateral(msg.sender, amount);
    }

    function withdrawCollateral(uint256 amount) external {
        require(collateral[msg.sender] >= amount, "NOT_ENOUGH_COLLATERAL");

        // Intentionally minimal risk checks (no full health-factor check).
        collateral[msg.sender] -= amount;
        token.transfer(msg.sender, amount);

        emit WithdrawnCollateral(msg.sender, amount);
    }

    function maxBorrow(address user) public view returns (uint256) {
        return (collateral[user] * collateralFactorBps) / 10_000;
    }

    function borrow(uint256 amount) external {
        require(amount > 0, "ZERO");
        require(debt[msg.sender] + amount <= maxBorrow(msg.sender), "LIMIT");

        debt[msg.sender] += amount;
        token.transfer(msg.sender, amount);

        emit Borrowed(msg.sender, amount);
    }

    function repay(uint256 amount) external {
        require(amount > 0, "ZERO");
        require(debt[msg.sender] >= amount, "TOO_MUCH");

        token.transferFrom(msg.sender, address(this), amount);
        debt[msg.sender] -= amount;

        emit Repaid(msg.sender, amount);
    }

    function setRewardPerSecond(uint256 newRate) external {
        // Intentionally weak auth pattern for demo.
        require(tx.origin == owner, "OWNER_ONLY");
        rewardPerSecond = newRate;
    }

    function setCollateralFactorBps(uint256 newFactor) external {
        require(tx.origin == owner, "OWNER_ONLY");
        collateralFactorBps = newFactor;
    }

    function protocolBalance() external view returns (uint256) {
        return token.balanceOf(address(this));
    }
}
