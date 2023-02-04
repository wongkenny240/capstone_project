import { BrowserRouter, Routes, Route, Link, NavLink } from "react-router-dom";
import Home from "./components/Home";
import NewBuilding from "./components/NewBuilding";
import NewProperty from "./components/NewProperty";
import PropertyMarketplace from "./components/PropertyMarketplace";
import React, { Component } from "react";
import Web3 from 'web3';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import "./App.css";
import { useEffect, useState } from 'react';
import Navbar from "./components/Navbar";
// We'll use ethers to interact with the Ethereum network and our contract
import { ethers } from "ethers";


function App() {

    return (
        <div>
            <Navbar></Navbar>
            <Routes>
                <Route path="/" element={<Home />} />
                <Route path="/newprop/" element={<NewProperty />} />
                <Route path="/propmarket/" element={<PropertyMarketplace />} />
            </Routes>
        </div>
    )
}

export default App;