import React, { useState, useEffect } from "react";
import { makeStyles } from '@material-ui/core/styles';
import TextField from '@material-ui/core/TextField';
import Button from '@material-ui/core/Button';
import Web3 from "web3";
import getWeb3 from "../getWeb3";
import contractAddress  from "../contracts/contract-address.json";
import PropertyToken from "../contracts/PropertyToken.json"
import { ethers } from "ethers";


function NewProperty(){

    const [buildName, setBuildName] = useState(null)
    const [location, setLocation] = useState(null)
    const [block, setBlock] = useState(null)
    const [floor, setFloor] = useState(null)
    const [flat, setFlat] = useState(null)
    const [prop_id, setPropID] = useState(null)
    const [price, setPrice] = useState(null)
    const [contract, setContract] = useState(null)
    const [address, setAddress ] = useState(null)
    const [currentAccount, setCurrentAccount] = useState(null)

                
    const ethers = require("ethers");
    let signer = null;
    let provider;
    if (window.ethereum == null) {
    
        // If MetaMask is not installed, we use the default provider,
        // which is backed by a variety of third-party services (such
        // as INFURA). They do not have private keys installed so are
        // only have read-only access
        console.log("MetaMask not installed; using read-only defaults")
        provider = ethers.getDefaultProvider()
    
    } else {
    
        // Connect to the MetaMask EIP-1193 object. This is a standard
        // protocol that allows Ethers access to make all read-only
        // requests through MetaMask.
        provider = new ethers.BrowserProvider(window.ethereum)
    
        // It also provides an opportunity to request access to write
        // operations, which will be performed by the private key
        // that MetaMask manages for the user.
        signer = provider.getSigner();
    }
    
  
    //const addr = signer.getAddress();

    //Pull the deployed contract instance
    console.log(contractAddress.address);
    console.log(PropertyToken.abi);
    //const instance = new ethers.Contract(contractAddress.address, PropertyToken.abi, signer);

    //setContract(instance);
    //setAddress(addr);





    async function registerProperty(){
        const transaction = await contract.registerProperty(
            buildName,
            location,
            block,
            floor,
            flat,
            prop_id,
            price
        )
        
        console.log({
            buildName,
            location,
            block,
            floor,
            flat,
            prop_id,
            price
        });

        //console.log("address", addr);

    }

    useEffect(() => {

    }, [])

    return (
        <div className="form-submit"><h2>Create a New Building</h2>
        <TextField id="outlined-basic" margin="normal" label="Building" variant="outlined" onChange={(e) => setBuildName(e.target.value)}/>
        <TextField id="outlined-basic" margin="normal" label="Location" variant="outlined" onChange={(e) => setLocation(e.target.value)}/>
        <TextField id="outlined-basic" margin="normal" label="Block" variant="outlined" onChange={(e) => setBlock(e.target.value)}/>
        <TextField id="outlined-basic" margin="normal" label="Floor" variant="outlined" onChange={(e) => setFloor(e.target.value)}/>
        <TextField id="outlined-basic" margin="normal" label="Flat" variant="outlined" onChange={(e) => setFlat(e.target.value)}/>
        <TextField id="outlined-basic" margin="normal" label="Property ID" variant="outlined" onChange={(e) => setPropID(e.target.value)}/>
        <TextField id="outlined-basic" margin="normal" label="Price" variant="outlined" onChange={(e) => setPrice(e.target.value)}/>

        <Button onClick={registerProperty} variant="contained">Submit</Button>
        </div>
    )
}

export default NewProperty;