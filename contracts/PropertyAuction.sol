// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./PropertyToken.sol";


contract PropertyAuction{

    // event for secondary market
    event Start();
    event Bid(address indexed sender, uint amount);
    event Withdraw(address indexed bidder, uint amount);
    event End(address winner, uint amount);
    event Cancel();

    // variable for secondary market (english auction)
    bool public started;
    bool public ended;
    uint public endAt;


    address payable public seller;
    address public highestBidder;
    uint public highestBid;
    mapping(address => uint) public bids;

    PropertyContract public property_token;
    //PropertyContract public property_token;
    uint public tokenId;

    constructor(
        address _tokenAddress,
        uint _tokenId,
        uint _startingBid
    ){
        property_token = PropertyContract(_tokenAddress);
        tokenId = _tokenId;

        seller = payable(msg.sender);
        highestBid = _startingBid;
    }


    function start() external{
        require(!started, "Auction has been started previously");
        address owner = property_token.ownerOf(tokenId);
        // check if seller is owner
        require (msg.sender == owner , "Cannot sell as not property owner");

        property_token.transferFrom(msg.sender, address(this), tokenId);

        property_token.setForSale(tokenId, true);
        started = true;

        endAt = block.timestamp + 0.5 days;
        //highestBid = start_bid;

        emit Start();

    }

    function bid() external payable{
        require(started, "not started");
        require(block.timestamp < endAt, "ended");
        require(msg.value > highestBid, "bid value smaller than highest bid");

        if (highestBidder != address(0)){
            bids[highestBidder] += highestBid;
        }
        
        highestBidder = msg.sender;
        highestBid = msg.value;

        emit Bid(msg.sender, msg.value);

    }


    function withdraw() external{
        uint bal = bids[msg.sender];
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(bal);

        emit Withdraw(msg.sender, bal);

    }

    function cancel_auction() external {
        address owner = property_token.getOwner(tokenId);//_ownerlist[tokenId];
        require(owner == msg.sender, "only owner can cancel auction");
        property_token.transferFrom(address(this), msg.sender, tokenId);

        property_token.setForSale(tokenId, false);
        started = false;

        emit Cancel();
    }


    function end() external{
        require(started, "Auction not started");
        require(!ended, "Auction has already eneded");

        ended = true;
        if (highestBidder != address(0)){
            property_token.safeTransferFrom(address(this), highestBidder, tokenId);
            property_token.setOwner(tokenId, highestBidder);
            //address payable seller = _ownerlist[tokenId];
            seller.transfer(highestBid);
        } else {
            property_token.safeTransferFrom(address(this), seller, tokenId);
        }

        emit End(highestBidder, highestBid);
    }






}


