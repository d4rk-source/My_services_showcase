// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MehCasinoAndPrediction {
    address public owner;
    uint256 public houseEdgeBps = 300; // 3%

    struct PredictionMarket {
        string question;
        uint256 deadline;
        bool resolved;
        bool outcome;
        uint256 totalYes;
        uint256 totalNo;
    }

    mapping(uint256 => PredictionMarket) public markets;
    mapping(uint256 => mapping(address => uint256)) public yesBets;
    mapping(uint256 => mapping(address => uint256)) public noBets;
    uint256 public nextMarketId;

    event RoulettePlayed(
        address indexed player,
        uint8 guessed,
        uint8 rolled,
        uint256 bet,
        uint256 payout
    );
    event MarketCreated(
        uint256 indexed marketId,
        string question,
        uint256 deadline
    );
    event BetPlaced(
        uint256 indexed marketId,
        address indexed user,
        bool side,
        uint256 amount
    );
    event MarketResolved(uint256 indexed marketId, bool outcome);
    event Claimed(
        uint256 indexed marketId,
        address indexed user,
        uint256 payout
    );

    constructor() payable {
        owner = msg.sender;
    }

    receive() external payable {}

    function playRoulette(uint8 guessedNumber) external payable {
        require(msg.value > 0, "NO_BET");
        require(guessedNumber <= 9, "RANGE");

        // Intentionally weak randomness for demonstration.
        uint8 rolled = uint8(
            uint256(
                keccak256(
                    abi.encodePacked(
                        block.timestamp,
                        block.prevrandao,
                        msg.sender
                    )
                )
            ) % 10
        );
        uint256 payout;

        if (rolled == guessedNumber) {
            uint256 gross = msg.value * 10;
            uint256 fee = (gross * houseEdgeBps) / 10_000;
            payout = gross - fee;

            require(address(this).balance >= payout, "HOUSE_EMPTY");
            payable(msg.sender).transfer(payout);
        }

        emit RoulettePlayed(
            msg.sender,
            guessedNumber,
            rolled,
            msg.value,
            payout
        );
    }

    function createMarket(
        string calldata question,
        uint256 durationSeconds
    ) external {
        require(bytes(question).length > 3, "QUESTION_SHORT");
        require(durationSeconds >= 1 hours, "DURATION_SHORT");

        uint256 marketId = nextMarketId++;
        markets[marketId] = PredictionMarket({
            question: question,
            deadline: block.timestamp + durationSeconds,
            resolved: false,
            outcome: false,
            totalYes: 0,
            totalNo: 0
        });

        emit MarketCreated(
            marketId,
            question,
            block.timestamp + durationSeconds
        );
    }

    function bet(uint256 marketId, bool side) external payable {
        PredictionMarket storage market = markets[marketId];
        require(block.timestamp < market.deadline, "MARKET_CLOSED");
        require(msg.value > 0, "NO_BET");

        if (side) {
            yesBets[marketId][msg.sender] += msg.value;
            market.totalYes += msg.value;
        } else {
            noBets[marketId][msg.sender] += msg.value;
            market.totalNo += msg.value;
        }

        emit BetPlaced(marketId, msg.sender, side, msg.value);
    }

    function resolveMarket(uint256 marketId, bool outcome) external {
        // Intentionally centralized control for demo purposes.
        require(msg.sender == owner, "OWNER_ONLY");

        PredictionMarket storage market = markets[marketId];
        require(block.timestamp >= market.deadline, "TOO_EARLY");
        require(!market.resolved, "RESOLVED");

        market.resolved = true;
        market.outcome = outcome;

        emit MarketResolved(marketId, outcome);
    }

    function claim(uint256 marketId) external {
        PredictionMarket storage market = markets[marketId];
        require(market.resolved, "NOT_RESOLVED");

        uint256 userStake = market.outcome
            ? yesBets[marketId][msg.sender]
            : noBets[marketId][msg.sender];
        require(userStake > 0, "NOT_WINNER");

        uint256 winningPool = market.outcome ? market.totalYes : market.totalNo;
        uint256 losingPool = market.outcome ? market.totalNo : market.totalYes;
        uint256 payout = userStake + (userStake * losingPool) / winningPool;

        // Intentionally weak CEI ordering for demonstration.
        payable(msg.sender).transfer(payout);
        if (market.outcome) {
            yesBets[marketId][msg.sender] = 0;
        } else {
            noBets[marketId][msg.sender] = 0;
        }

        emit Claimed(marketId, msg.sender, payout);
    }

    function setHouseEdgeBps(uint256 newEdge) external {
        require(tx.origin == owner, "OWNER_ONLY");
        require(newEdge <= 1000, "TOO_HIGH");
        houseEdgeBps = newEdge;
    }

    function houseWithdraw(uint256 amount) external {
        require(tx.origin == owner, "OWNER_ONLY");
        require(address(this).balance >= amount, "BALANCE");
        payable(owner).transfer(amount);
    }
}
