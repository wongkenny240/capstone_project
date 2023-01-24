const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");
const hre = require("hardhat");
const {
    time,
    loadFixture,
  } = require("@nomicfoundation/hardhat-network-helpers");


describe("TokenFactory", async function(){

    async function deployPropertyContract() {
        // prop token argument
        const name = "Building X";
        const symbol = "BX";
    
        // Contracts are deployed using the first signer/account by default
        const [owner, otherAccount] = await ethers.getSigners();
    
        const TokenFactory = await hre.ethers.getContractFactory("TokenFactory");
        const tokenfactory = await TokenFactory.deploy();
    
        return { tokenfactory, name, symbol, owner, otherAccount };
    }


    describe("Deployment", function(){
        it("increments the property token count", async function (){
            const {tokenfactory, name, symbol, owner, otherAccount} = await loadFixture(deployPropertyContract);
    
            await tokenfactory.createPropToken(
                name,
                symbol
            );
    
            //const propTokenCount = await tokenfactory.propTokenCount();
            
            // assert that the value is correct
            expect(await tokenfactory.propTokenCount()).to.equal(1);
    
    
        });

    });

    describe("Event", function(){
        it("Should emit an event on contract creation", async function(){
            const {tokenfactory, name, symbol, owner, otherAccount} = await loadFixture(deployPropertyContract);
    
            const propContract = await tokenfactory.createPropToken(
                name,
                symbol
            );

            await expect(tokenfactory.createPropToken(
                name,
                symbol
            )).to.emit(tokenfactory, "PropertyContractCreated")
            .withArgs(anyValue, anyValue); // We accept any value as `when` arg

        });

    });


});



