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
    address public highest_bidder;
    uint public highest_bid;
    mapping(address => uint) public bids;


    PropertyContract public property_token;
    uint public tokenId;

    constructor(
        address _nft,
        uint _nftId,
        uint _startingBid

    ){
        
    }



    function start(uint tokenId, uint start_bid) external{
        require(!started, "Auction has been started previously");
        address owner = ownerOf(tokenId);
        // check if seller is owner
        require (msg.sender == owner , "not property owner");
        _transfer(msg.sender, address(this), tokenId);
        //_ownerlist[tokenId] = address(this);
        _set_for_sale(tokenId);
        started = true;
        highest_bid = start_bid;

        emit Start();

    }

    function bid() external payable{
        require(started, "not started");
        require(block.timestamp < endAt, "ended");
        require(msg.value > highest_bid, "bid value smaller than highest bid");

        if (highest_bidder != address(0)){
            bids[highest_bidder] += highest_bid;
        }
        
        highest_bidder = msg.sender;
        highest_bid = msg.value;

        emit Bid(msg.sender, msg.value);

    }


    function withdraw() external{
        uint bal = bids[msg.sender];
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(bal);

        emit Withdraw(msg.sender, bal);

    }

    function cancel_auction(uint tokenId) external {
        address owner = _ownerlist[tokenId];
        require(owner == msg.sender, "only owner can cancel auction");
        _transfer(address(this), msg.sender, tokenId);
        //_ownerlist[tokenId] = msg.sender;
        _property_status_list[tokenId] = false;
        started = false;

        emit Cancel();
    }


    function end(uint tokenId) external{
        require(started, "Auction not started");
        require(!ended, "Auction has already eneded");

        ended = true;
        if (highest_bidder != address(0)){
            _transfer(address(this), highest_bidder, tokenId);
            //address payable seller = _ownerlist[tokenId];
            //seller.transfer(highest_bid);
        } else {

        }


    }






}


