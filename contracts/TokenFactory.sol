// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "./PropertyToken.sol";


contract TokenFactory{
    PropertyContract[] private _propertyToken;

    uint256 constant maxLimit = 20;

    event PropertyContractCreated(PropertyContract indexed propContract, address indexed owner);

    function propTokenCount() public view returns(uint256){
        return _propertyToken.length;
    }

    function createPropToken(
        string memory name,
        string memory symbol
    )public {
        PropertyContract propContract = new PropertyContract(
            msg.sender,
            name,
            symbol
        );
        _propertyToken.push(propContract);
        emit PropertyContractCreated(propContract, msg.sender);

    }

    function propTokens(uint256 limit, uint256 offset)
    public
    view
    returns(PropertyContract[] memory coll)
    {
        require(offset <= propTokenCount(), "offset out of bounds");
        uint256 size = propTokenCount() - offset;
        size = size < limit ? size : limit;
        size = size < maxLimit ? size : maxLimit;
        coll = new PropertyContract[](size);
        for(uint256 i = 0; i < size; i++) {
            coll[i] = _propertyToken[offset + i];
        }
        return coll;
    }

    // function to get all property token

    

}
