import React, { useState, useEffect } from "react";
import { makeStyles } from '@material-ui/core/styles';
import TextField from '@material-ui/core/TextField';
import Button from '@material-ui/core/Button';


const NewBuilding = () => {
    useEffect(() => {
    }, []);
    return (
        <div className="form-submit"><h2>Create a New Property</h2>
        <TextField id="outlined-basic" margin="normal" label="Building" variant="outlined" />
        <TextField id="outlined-basic" margin="normal" label="Symbol" variant="outlined" />
        <Button variant="contained">Submit</Button>
        </div>



    )
}
export default NewBuilding;