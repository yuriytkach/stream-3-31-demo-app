// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Fundraiser {
    // Mapping to store contributions made by each address
    mapping(address => uint256) public contributions;

    uint256 public totalContributors;

    // Minimum contribution allowed
    uint256 public minimumContribution;

    // Fundraising goal
    uint256 public goal;

    // Fundraising deadline
    uint256 public deadline;

    // Address of the creator of this contract
    address public creator;
    // Address of the recipient of funds (that can be different from the creator)
    address public fundRecipient;

    // Enum to keep track of contract state
    enum State {
        Fundraising,
        Successful,
        Closed
    }
    // Current state of the contract
    State public state = State.Fundraising;

    // Total amount raised
    uint256 public raisedAmount = 0;

    // Modifier to check if contract is in specified state
    modifier inState(State _state) {
        require(state == _state, "Contract is not in required state");
        _;
    }

    // Modifier to check if the message sender is the creator
    modifier isCreator() {
        require(msg.sender == creator, "Caller is not the creator of contract");
        _;
    }

    // Constructor to initialize the contract
    constructor(
        uint256 _goal,
        uint256 _minimumContribution,
        uint256 _livespan,
        address _fundRecipient,
        address _fundCreator
    ) {
        // Convert goal to wei
        goal = _goal * 1000000000000000000;

        minimumContribution = _minimumContribution;

        // Calculate the deadline as the current block number + lifespan
        deadline = block.number + _livespan;

        fundRecipient = _fundRecipient;

        // Set the creator
        creator = _fundCreator;
    }

    // Function to contribute to the fundraising
    function contribute() public payable inState(State.Fundraising) {
        require(
            msg.value > minimumContribution,
            "Contibution should be above minimum"
        );
        require(block.number < deadline, "Contract is expired");

        // If this is the first contribution from the sender
        if (contributions[msg.sender] == 0) {
            totalContributors++; // Increase the total number of contributors
        }

        // Add the contribution to the sender's total
        contributions[msg.sender] += msg.value;

        // Add the contribution to the total raised
        raisedAmount += msg.value;

        if (raisedAmount > goal) {
            state = State.Successful;
        }
    }

    // Try to refund the amount to the caller if requirements are met: contract is expired, goal is not achieved,
    // sender did any contribution.
    // Return false if the transfer of funds fails.
    function getRefund() public returns (bool) {
        require(block.number > deadline, "Contract has not expired yet");
        require(raisedAmount < goal, "Contract has already reached its goal"); // or use inState(State.Fundraising)
        require(
            contributions[msg.sender] > 0,
            "You didn't contribute to contract!"
        );

        // Security risk:
        //msg.sender.transfer(contributions[msg.sender]);
        //contributions[msg.sender] = 0;
        //raisedAmount -= amountToRefund;

        uint256 amountToRefund = contributions[msg.sender];
        contributions[msg.sender] = 0;

        if (!payable(msg.sender).send(amountToRefund)) {
            // Revert the contribution amount to the original value.
            contributions[msg.sender] = amountToRefund;
            return false;
        }

        return true;
    }

    // Try to transfer the balance of the contract to the fund recipient and then set contract state to Closed.
    // If the transfer fails, revert the transaction.
    function payOut() public inState(State.Successful) isCreator {
        if (!payable(fundRecipient).send(address(this).balance)) {
            revert();
        }
        state = State.Closed;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function getDeadline() public view returns (uint256) {
        return deadline;
    }

    function getCreator() public view returns (address) {
        return creator;
    }
}

