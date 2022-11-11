// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract PropertyContract is ERC721
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

    event ContractOwnerShipTransferred(address owner);

    enum Status {NotExist, OnSale, Sold}

    address _owner;
    uint _target_selling_price;

    struct Property{
        string location;
        string unit_block;
        string unit_floor;
        string unit_flat;
        string prop_id;
    }

    // initialised the contract
    constructor() ERC721("PropertyTokens", "PT") {
        _owner = msg.sender;
        emit ContractOwnerShipTransferred(_owner);

    }

    // function to register property
    function _registerProperty(
        string memory _location, 
        string memory _unit_block, 
        string memory _unit_floor, 
        string memory _unit_flat, 
        string memory _prop_id,
        uint256 _target_price) public returns(uint256){
        //location = _location;

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

    function get_property_location(uint tokenId) public view returns(string memory){
        string memory location = _propertylist[tokenId].location;
        return location;
    }

    function bidProperty(uint tokenId, uint bidPrice) external payable {
        require(msg.sender != _ownerlist[tokenId], "Owner cannot buy the property");
        require(bidPrice >= _target_price_list[tokenId], "You bid price is lower than the target selling price");

        address seller = ownerOf(tokenId);
        _transfer(seller, msg.sender, tokenId);
        // for sale = false
        _property_status_list[tokenId] = false;
    }


    //function registerContract(uint256 _tokenId, string memory _uri) public {
    //    _mint(msg.sender, _tokenId);
    //    _registerProperty()
        //addContractMetadata(_tokenId, _uri);
        //emit ContractRegistered(msg.sender, _tokenId);
    //}


}
