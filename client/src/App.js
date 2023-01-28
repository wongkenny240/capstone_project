import { Routes, Route, Link, NavLink } from "react-router-dom";
import Home from "./components/Home";
import NewBuilding from "./components/NewBuilding";
import React, { Component } from "react";
import Web3 from 'web3';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import "./App.css";
import { useEffect, useState } from 'react';

function App() {

    const [currentAccount, setCurrentAccount] = useState(null);
    const checkWalletIsConnected = async () => {
        const { ethereum } = window;

        if (!ethereum) {
            console.log("Make sure you have Metamask installed!");
            return;
        } else {
            console.log("Wallet exists! We're ready to go!")
        }

        const accounts = await ethereum.request({ method: 'eth_accounts' });

        if (accounts.length !== 0) {
            const account = accounts[0];
            console.log("Found an authorized account: ", account);
            setCurrentAccount(account);
        } else {
            console.log("No authorized account found");
        }
    }

    const connectWalletHandler = async () => {
        const { ethereum } = window;

        if (!ethereum) {
            alert("Please install Metamask!");
        }

        try {
            const accounts = await ethereum.request({ method: 'eth_requestAccounts' });
            console.log("Found an account! Address: ", accounts[0]);
            setCurrentAccount(accounts[0]);
        } catch (err) {
            console.log(err)
        }
    }


    const connectWalletButton = () => {
        return (
            <button onClick={connectWalletHandler} className='cta-button connect-wallet-button'>
                Connect Wallet
            </button>
        )
    }

    useEffect(() => {
        checkWalletIsConnected();
    }, [])

    return (
        <div>

            <AppBar position="static" color="default" style={{ margin: 0 }}>
                <Toolbar>
                    <Typography variant="h6" color="inherit">
                        <NavLink className="nav-link" to="/">Home</NavLink>
                        <NavLink className="nav-link" to="/new/">New Building</NavLink>
                    </Typography>
                </Toolbar>
            </AppBar>

            <Routes>
                <Route path="/" exact element={<Home />} />
                <Route path="/new/" element={<NewBuilding />} />
            </Routes>
        </div>
    )
}

export default App;