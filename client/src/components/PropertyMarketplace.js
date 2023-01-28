import PropertyTile from "./PropertyTile";
import { useState } from "react";
import React, { Component } from "react";


export default function PropertyMarketplace() {
    const sampleData = [
        {
            "propname": "XXX",
            "location": "Aberdeen",
            "block": "Block 1",
            "floor": "Floor 1",
            "flat": "Flat A"
        },
        {
            "propname": "XXX",
            "location": "Sai Kung",
            "block": "Block 1",
            "floor": "Floor 1",
            "flat": "Flat A"
        }
    ]

    const [data, updateData] = useState(sampleData);


    return (
        <div>
            <div className="flex flex-col place-items-center mt-20">
                <div className="md:text-xl font-bold text-white">
                    <h2>Property Full Listing</h2>
                </div>
                <div className="flex mt-5 justify-between flex-wrap max-w-screen-xl text-center">
                    {data.map((value, index) => {
                        return <PropertyTile data={value} key={index}></PropertyTile>;
                    })}
                </div>
            </div>
        </div>
    );


}
