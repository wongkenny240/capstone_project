import React, { useState, useEffect } from "react";
import { makeStyles } from '@material-ui/core/styles';
import TextField from '@material-ui/core/TextField';
import Button from '@material-ui/core/Button';
import Web3 from "web3";
import getWeb3 from "../getWeb3"

const NewProperty = () => {
    useEffect(() => {
        const init = async() => {




        }

    }, []);
    return (
        <div className="form-submit"><h2>Create a New Building</h2>
        <TextField id="outlined-basic" margin="normal" label="Location" variant="outlined" />
        <TextField id="outlined-basic" margin="normal" label="Block" variant="outlined" />
        <TextField id="outlined-basic" margin="normal" label="Floor" variant="outlined" />
        <TextField id="outlined-basic" margin="normal" label="Flat" variant="outlined" />
        <TextField id="outlined-basic" margin="normal" label="Property ID" variant="outlined" />
        <TextField id="outlined-basic" margin="normal" label="Price" variant="outlined" />

        <Button variant="contained">Submit</Button>
        </div>



    )
}
export default NewProperty;