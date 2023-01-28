import React, { useState, useEffect } from "react";
import { makeStyles } from '@material-ui/core/styles';
import Web3 from 'web3'


const useStyles = makeStyles(theme => ({
    button: {
      margin: theme.spacing(1),
    },
    input: {
      display: 'none',
    },
  }));

  const Home = () => {
    const classes = useStyles();
    const [ contract, setContract] = useState(null)
    const [ accounts, setAccounts ] = useState(null)
    const [ funds, setFunds ] = useState([])
    const web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8545'))
  
    useEffect(() => {
    }, []);
  
 
    return (
        <div><h2>Home</h2></div>

    )
  }

export default Home;