// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract PropertyContract is IERC721Metadata, ERC721 
{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // map the token id to an address
    mapping(uint => address) private _ownerlist;

    // map the token id to property details
    mapping(uint => Property) public _propertylist;

    // dict to store the target price of each property
    mapping(uint => uint) private _target_price_list;

    //  dict to store the property status
    mapping(uint => bool) private _property_status_list;

    // dict to map the token id to token URIs
    mapping(uint256 => string) _tokenURIs;


    event ContractOwnerShipTransferred(address owner);

    event Start();
    event Bid(address indexed sender, uint amount);

    event End(address winner, uint amount);

    enum Status {NotExist, OnSale, Sold}

    //variable for primary market, first issuance of properties

    string _name;
    string _symbol;
    address _owner;
    uint _target_selling_price;


    // variable for secondary market (english auction)
    bool public started;
    bool public ended;
    uint public endAt;
    address public highest_bidder;
    uint public highest_bid;
    mapping(address => uint) public bids;


    struct Property{
        string location;
        string unit_block;
        string unit_floor;
        string unit_flat;
        string prop_id;
    }

    // initialised the contract, only the owner of the building can initialised the contract
    constructor() ERC721("PropertyTokens", "PT") {
        _owner = msg.sender;
        _name = "PropertyTokens";
        _symbol = "PT";
        emit ContractOwnerShipTransferred(_owner);

    }

    // function to register property
    function registerProperty(
        string memory _location, 
        string memory _unit_block, 
        string memory _unit_floor, 
        string memory _unit_flat, 
        string memory _prop_id,
        uint256 _target_price) public returns(uint256){
        //location = _location;

        // only owner of the building can register property
        require(msg.sender == _owner, "Only owner can register property");

        Property memory property = Property(
            _location,
            _unit_block,
            _unit_floor,
            _unit_flat,
            _prop_id
        );

        uint256 currentItemId = _tokenIds.current();
        _propertylist[currentItemId] = property;
        _ownerlist[currentItemId] = msg.sender;
        _target_price_list[currentItemId] = _target_price;
        //for sale = true
        _property_status_list[currentItemId] = true;
        _mint(msg.sender, currentItemId);
        _tokenIds.increment();
        return currentItemId;
    }

    // get property location
    function get_property_location(uint tokenId) public view returns(string memory){
        string memory location = _propertylist[tokenId].location;
        return location;
    }

    // set the property for sale
    function set_for_sale(uint tokenId) public {
        bool for_sale = true;
        _property_status_list[tokenId] = for_sale;
    }

    function start(uint tokenId, uint start_bid) external{
        require(!started, "Auction has been started previously");
        address owner = ownerOf(tokenId);
        // check if seller is owner
        require (msg.sender == owner , "not property owner");
        _transfer(msg.sender, address(this), tokenId);
        _ownerlist[tokenId] = address(this);
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


    }


    function end() external{


    }


    function setTokenURI(uint256 tokenId, string memory URI) public {
        address owner = _ownerlist[tokenId];
        require(owner != address(0), "ERROR: token id is not valid");
        _tokenURIs[tokenId] = URI;
    }


    function tokenURI(uint256 tokenId) public view override(ERC721, IERC721Metadata) returns (string memory) {
        address owner = _ownerlist[tokenId];
        require(owner != address(0), "ERROR: token id is not valid");
        return _tokenURIs[tokenId];
    }


    function bidProperty(uint tokenId, uint bidPrice) external payable {
        require(msg.sender != _ownerlist[tokenId], "Owner cannot buy the property");
        require(bidPrice >= _target_price_list[tokenId], "You bid price is lower than the target selling price");
        require(_property_status_list[tokenId] == true, "Property not for sale at the moment");
        address seller = ownerOf(tokenId);
        _transfer(seller, msg.sender, tokenId);
        // for sale = false > not for sale
        _property_status_list[tokenId] = false;
        _ownerlist[tokenId] = msg.sender;
        payable(seller).transfer(msg.value); // send the ETH to seller
    }





    //function registerContract(uint256 _tokenId, string memory _uri) public {
    //    _mint(msg.sender, _tokenId);
    //    _registerProperty()
        //addContractMetadata(_tokenId, _uri);
        //emit ContractRegistered(msg.sender, _tokenId);
    //}


}
