import React, { useState, useEffect } from "react";
import { makeStyles } from '@material-ui/core/styles';
import TextField from '@material-ui/core/TextField';
import Button from '@material-ui/core/Button';
import Web3 from "web3";
import getWeb3 from "../getWeb3";
import contractAddress  from "../contracts/contract-address.json";
import PTArtifact from "../contracts/PropertyToken.json"
import { ethers } from "ethers";


const [buildName, setBuildName] = useState(null)
const [location, setLocation] = useState(null)
const [block, setBlock] = useState(null)
const [floor, setFloor] = useState(null)
const [flat, setFlat] = useState(null)
const [prop_id, setPropID] = useState(null)
const [price, setPrice] = useState(null)
const [contract, setContract] = useState(null)
const [ addr, setAddress ] = useState(null)


const NewProperty = () => {
    useEffect(() => {
        const init = async() => {
            try {
                
                
                const ethers = require("ethers");
                // A Web3Provider wraps a standard Web3 provider, which is
                // what MetaMask injects as window.ethereum into each page
                const provider = new ethers.providers.Web3Provider(window.ethereum)
        
                // MetaMask requires requesting permission to connect users accounts
                await provider.send("eth_requestAccounts", []);
        
                // The MetaMask plugin also allows signing transactions to
                // send ether and pay to change state within the blockchain.
                // For this, you need the account signer...
                const signer = provider.getSigner()
        
                const addr = await signer.getAddress();

                //Pull the deployed contract instance
                let contract = new ethers.Contract(contractAddress.PropertyToken, PTArtifact.abi, signer)

                setContract(contract)
                setAddress(addr)


              } catch(error) {
                alert(
                  `Failed to load web3, accounts, or contract. Check console for details.`,
                );
                console.error(error);
              }




        }

    }, []);

    const registerProperty = async () =>{
        
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

        console.log("address", addr);

    }


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