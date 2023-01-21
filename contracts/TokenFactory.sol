// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "./PropertyToken.sol";


contract TokenFactory{
    PropertyContract[] private _propertyToken;

    event PropertyContractCreated(PropertyContract indexed propContract, address indexed owner);

    function propTokenCount() public view returns(uint256){
        return _propertyToken.length
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

    }


}
