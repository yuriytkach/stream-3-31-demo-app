// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "./Fundraiser.sol";

contract FundraiserFactory {

    address[] public fundraisers;

    function newFundraiser(
        uint256 _goal,
        uint256 _minimumContribution,
        uint256 _livespan,
        address _fundRecipient
    ) public returns (address) {
        Fundraiser f = new Fundraiser(_goal, _minimumContribution, _livespan, _fundRecipient, msg.sender);
        fundraisers.push(address(f));
        return address(f);
    }

}
