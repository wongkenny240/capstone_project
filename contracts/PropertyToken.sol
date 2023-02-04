// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";


contract PropertyToken is IERC721Metadata, ERC721URIStorage 
{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // dict to map the token id to token URIs
    mapping(uint256 => string) _tokenURIs;

    event ContractOwnerShipTransferred(address owner);

    enum Status {NotExist, OnSale, Sold}

    //variable for primary market, first issuance of properties

    string _name;
    string _symbol;
    address _owner;
    uint _target_selling_price;


    struct Property{
        uint256 tokenId;
        string building;
        address owner;
        string location;
        string unit_block;
        string unit_floor;
        string unit_flat;
        string prop_id;
        uint256 price;
        bool for_sale;
        bool primary_mkt;
    }

    // map the token id to property details
    mapping(uint => Property) public _propertylist;


    // initialised the contract, only the owner of the building can initialised the contract
    constructor() ERC721("PropertyToken", "PTT") {
        //address owner_, string memory name_, string memory symbol_
        _owner = msg.sender; //owner_;
        //_name = name_;
        //_symbol = symbol_;
        emit ContractOwnerShipTransferred(_owner);

    }

    // function to register property
    function registerProperty(
        string memory _building,
        string memory _location, 
        string memory _unit_block, 
        string memory _unit_floor, 
        string memory _unit_flat, 
        string memory _prop_id,
        uint256 _target_price,
        string memory tokenURI) public returns(uint256){
        //location = _location;

        // only owner of the building can register property
        require(msg.sender == _owner, "Only owner can register property");


        uint256 currentItemId = _tokenIds.current();
        _propertylist[currentItemId] = Property(
            currentItemId,
            _building,
            _owner,
            _location,
            _unit_block,
            _unit_floor,
            _unit_flat,
            _prop_id,
            _target_price,
            true,
            true
        );

        _mint(msg.sender, currentItemId);

        _setTokenURI(currentItemId, tokenURI);

        _tokenIds.increment();
        return currentItemId;
    }

    // function to get all listed property (i.e. property token)
    function getAllProps() public view returns (Property[] memory){
        uint256 propCount = _tokenIds.current();
        Property[] memory propTokens = new Property[](propCount);
        uint currentIndex = 0;
        uint currentItemId;

        for (uint i = 0; i < propCount; i++){
            currentItemId = i;
            Property storage currentItem = _propertylist[currentItemId];
            propTokens[currentIndex] = currentItem;
            currentIndex +=1;
        }

        return propTokens;
    }    

    // function to get all my property
    function getMyProps() public view returns(Property[] memory){
        

    }
    



    // set property for sale or not for sale
    function setForSale(uint tokenId, bool forSale) public{
        _propertylist[tokenId].for_sale = forSale;
        //_property_status_list[tokenId] = forSale;
    }

    function setOwner(uint tokenId, address ownerAddress) public{
        _propertylist[tokenId].owner = ownerAddress;
        //_ownerlist[tokenId] = ownerAddress;
    }

    // function to set the primary market flag to false
    function setSecondary(uint tokenId) public {
        _propertylist[tokenId].primary_mkt = false;
    }


    // get property location
    function get_property_location(uint tokenId) public view returns(string memory){
        string memory location = _propertylist[tokenId].location;
        return location;
    }


    function getOwner(uint tokenId) public view returns(address){
        return _propertylist[tokenId].owner;
        //return _ownerlist[tokenId]; 
    }



    function bidProperty(uint tokenId, uint bidPrice) external payable {
        require(msg.sender != _propertylist[tokenId].owner, "Owner cannot buy the property");
        require(bidPrice >= _propertylist[tokenId].price,"You bid price is lower than the target selling price");
        require(_propertylist[tokenId].for_sale == true, "Property not for sale at the moment");
        address seller = ownerOf(tokenId);
        _transfer(seller, msg.sender, tokenId);
        payable(seller).transfer(msg.value); // send the ETH to seller
        // for sale = false > not for sale
        _propertylist[tokenId].for_sale = false;
        _propertylist[tokenId].owner = msg.sender;
        _propertylist[tokenId].primary_mkt = false;        
    }

    // event for secondary market
    event Start();
    event Bid(address indexed sender, uint amount);
    event Withdraw(address indexed sender, uint auctionId);
    event End(address winner, uint amount);
    event Cancel();

    address payable public auction_seller;

    Counters.Counter private _auctionIds;


    struct Auction{
        uint256 auctionTokenId; 
        uint256 highestBid;
        address highestBidder;
        address seller;
        bool started;
        bool ended;
        Property auctionProperty;
    }

    mapping(uint => Auction) public _auctions;

    function start(uint auctionTokenId, uint startBid) external{
        //primary market = false and for sale = false
           
        bool primaryMkt = _propertylist[auctionTokenId].primary_mkt;
        bool forSale = _propertylist[auctionTokenId].for_sale;
        require(!primaryMkt && !forSale, "Property cannot be auctioned");
        address owner = _propertylist[auctionTokenId].owner;
        require (msg.sender == owner , "Cannot sell as not property owner");

        // create Auction
        uint256 currentAuctionItemId = _auctionIds.current();
        _auctions[currentAuctionItemId] = Auction(
            auctionTokenId,
            startBid,
            msg.sender,
            owner,
            true,
            false,
            _propertylist[auctionTokenId]
        );

        transferFrom(msg.sender, address(this), auctionTokenId);             

        _propertylist[auctionTokenId].for_sale = true;


    }


    // function to end the auction
    function end(uint auctionId) external{

        bool started = _auctions[auctionId].started;
        address payable seller = payable(_auctions[auctionId].seller);
        address highestBidder = _auctions[auctionId].highestBidder;
        uint highestBid = _auctions[auctionId].highestBid;

        require(started, "Auction not started");
        require(msg.sender == seller, "Only seller can close the auction");
        uint token_id = _auctions[auctionId].auctionTokenId;

        if (highestBidder != seller ){
            safeTransferFrom(address(this), highestBidder, token_id);
            _propertylist[token_id].owner = highestBidder;
            _propertylist[token_id].for_sale = false;
            seller.transfer(highestBid);
        }else{
            safeTransferFrom(address(this), seller, token_id);
        }

        emit End(highestBidder, highestBid);


    }



    function bid(uint bidPrice, uint auctionId) external payable{

        bool started = _auctions[auctionId].started;
        bool ended = _auctions[auctionId].ended;
        uint highestBid = _auctions[auctionId].highestBid;

        require(started, "not started");
        require(!ended, "ended");
        //require(block.timestamp < endAt, "ended");
        require(bidPrice > highestBid, "bid value smaller than highest bid");
        //require(msg.value > highestBid, "bid value smaller than highest bid");

        // update highest bid if bid price larger than highest bid
        _auctions[auctionId].highestBid = bidPrice;
        _auctions[auctionId].highestBidder = msg.sender;

        emit Bid(msg.sender, bidPrice);
    }


    function withdraw(uint auctionId) external{
        address seller = _auctions[auctionId].seller;
        uint token_id = _auctions[auctionId].auctionTokenId;

        require(msg.sender == seller, "Only seller can withdraw auction");        
        _auctions[auctionId].ended = true;
        _propertylist[token_id].for_sale = false;

        emit Withdraw(msg.sender, auctionId);

    }



}
