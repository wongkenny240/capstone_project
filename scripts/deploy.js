const path = require("path");
const fs = require("fs");

// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  // ethers is available in the global scope
  const [deployer] = await ethers.getSigners();
  console.log(
    "Deploying the contracts with the account:",
    await deployer.getAddress()
  );
  const PropertyToken = await ethers.getContractFactory("PropertyToken");
  const propertytoken = await PropertyToken.deploy();
  await propertytoken.deployed();
  saveFrontendFiles(propertytoken);

  //const PropertyToken = await hre.ethers.getContractFactory("PropertyToken");
  //const propertytoken = await PropertyToken.deploy();

  //await propertytoken.deployed();

  console.log(
    `token factory deployed to ${propertytoken.address}`
  );
}

// we add this part to save artifacts and address
function saveFrontendFiles(pt) {
  const contractsDir = path.join(__dirname, "/../client/src/contracts");
  if (!fs.existsSync(contractsDir)) {
    fs.mkdirSync(contractsDir);
  }
  fs.writeFileSync(
    contractsDir + "/contract-address.json",
    JSON.stringify({ PropertyToken: pt.address }, null, 2)
  );
  // `artifacts` is a helper property provided by Hardhat to read artifacts
  const PTArtifact = artifacts.readArtifactSync("PropertyToken");
  fs.writeFileSync(
    contractsDir + "/PropertyToken.json",
    JSON.stringify(PTArtifact, null, 2)
  );
}




// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
