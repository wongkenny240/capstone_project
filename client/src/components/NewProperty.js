import React, { useState, useEffect } from "react";
import { makeStyles } from '@material-ui/core/styles';
import TextField from '@material-ui/core/TextField';
import Button from '@material-ui/core/Button';


const NewProperty = () => {
    useEffect(() => {
    }, []);
    return (
        <div className="form-submit"><h2>Create a New Building</h2>
        <TextField id="outlined-basic" margin="normal" label="Location" variant="outlined" />
        <TextField id="outlined-basic" margin="normal" label="Symbol" variant="outlined" />
        <TextField id="outlined-basic" margin="normal" label="Location" variant="outlined" />
        <TextField id="outlined-basic" margin="normal" label="Symbol" variant="outlined" />
        <TextField id="outlined-basic" margin="normal" label="Location" variant="outlined" />
        <TextField id="outlined-basic" margin="normal" label="Symbol" variant="outlined" />

        <Button variant="contained">Submit</Button>
        </div>



    )
}
export default NewProperty;