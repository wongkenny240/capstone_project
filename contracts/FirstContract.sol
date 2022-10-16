// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PropertyContract
{

    enum Status {NotExist, Pending, Approved, Rejected}


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
    constructor() public {


    }


}
