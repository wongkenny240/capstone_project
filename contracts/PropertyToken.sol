// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract PropertyContract is ERC721
{

    enum Status {NotExist, OnSale, Sold}

    address owner;
    uint target_selling_price;

    struct Property{
        string location;
        string unit_block;
        string unit_floor;
        string unit_flat;
        string prop_id;
    }

    // initialised the contract
    constructor(string memory _name, string memory _symbol) 
        ERC721(_name, _symbol) public {
    }

    function registerProperty(string memory _location, string memory _unit_block, string memory _unit_floor, string memory _unit_flat, string memory _prop_id) public {
        //location = _location;
        Property memory property = Property(
            _location,
            _unit_block,
            _unit_floor,
            _unit_flat,
            _prop_id
        );
    }

    function getPropertyDetail() public{
        
    }

    function bidProperty(uint bidPrice) public{

    }


    function registerContract(uint256 _tokenId, string memory _uri) public {
        _mint(msg.sender, _tokenId);
        //addContractMetadata(_tokenId, _uri);
        //emit ContractRegistered(msg.sender, _tokenId);
    }


}
