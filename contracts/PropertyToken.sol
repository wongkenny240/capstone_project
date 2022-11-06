// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract PropertyContract is ERC721
{

    enum Status {NotExist, OnSale, Sold}

    

    struct Property{
        address owernerAddress;
        string location;
        string unit_block;
        string unit_floor;
        string unit_flat;
        uint cost;
        uint prop_id;
    }

    // initialised the contract
    constructor(string memory _name, string memory _symbol) 
        ERC721(_name, _symbol) public {
    }

    function registerContract(uint256 _tokenId, string memory _uri) public {
        _mint(msg.sender, _tokenId);
        //addContractMetadata(_tokenId, _uri);
        //emit ContractRegistered(msg.sender, _tokenId);
    }


}
