// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";


contract PropertyContract is IERC721Metadata, ERC721URIStorage 
{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // map the token id to an address
    //mapping(uint => address) private _ownerlist;

    // dict to store the target price of each property
    //mapping(uint => uint) private _target_price_list;

    //  dict to store the property status
    //mapping(uint => bool) private _property_status_list;

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
    constructor(address owner_, string memory name_, string memory symbol_) ERC721("Property Token", "PT") {
        _owner = owner_;
        _name = name_;
        _symbol = symbol_;
        emit ContractOwnerShipTransferred(_owner);

    }

    // function to register property
    function registerProperty(
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

        //_ownerlist[currentItemId] = msg.sender;
        //_target_price_list[currentItemId] = _target_price;
        //for sale = true
        //_property_status_list[currentItemId] = true;
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
        //require(msg.sender != _ownerlist[tokenId], "Owner cannot buy the property");
        //require(bidPrice >= _target_price_list[tokenId], "You bid price is lower than the target selling price");
        //require(_property_status_list[tokenId] == true, "Property not for sale at the moment");
        address seller = ownerOf(tokenId);
        _transfer(seller, msg.sender, tokenId);
        payable(seller).transfer(msg.value); // send the ETH to seller
        // for sale = false > not for sale
        _propertylist[tokenId].for_sale = false;
        _propertylist[tokenId].owner = msg.sender;
        _propertylist[tokenId].primary_mkt = false;        
        //_property_status_list[tokenId] = false;
        //_ownerlist[tokenId] = msg.sender;
    }

}
