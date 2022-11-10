// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract PropertyContract is ERC721
{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;


    mapping(uint => address) private _ownerlist;

    mapping(uint => Property[]) private _propertylist;

    event ContractOwnerShipTransferred(address owner);

    enum Status {NotExist, OnSale, Sold}

    address _owner;
    uint target_selling_price;

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

    function _registerProperty(
        string memory _location, 
        string memory _unit_block, 
        string memory _unit_floor, 
        string memory _unit_flat, 
        string memory _prop_id) public returns(uint256){
        //location = _location;

        Property memory property = Property(
            _location,
            _unit_block,
            _unit_floor,
            _unit_flat,
            _prop_id
        );

        uint256 currentItemId = _tokenIds.current();
        _propertylist[currentItemId].push(property);
        _ownerlist[currentItemId].push(msg.sender);
        _mint(msg.sender, currentItemId);
        _tokenIds.increment();
        return currentItemId;
    }

    function getPropertyDetail() public{

    }

    function bidProperty(uint bidPrice) public{

    }




    //function registerContract(uint256 _tokenId, string memory _uri) public {
    //    _mint(msg.sender, _tokenId);
    //    _registerProperty()
        //addContractMetadata(_tokenId, _uri);
        //emit ContractRegistered(msg.sender, _tokenId);
    //}


}
