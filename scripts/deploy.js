const hre = require("hardhat");

async function main() {
    const VotingSys = await hre.ethers.getContractFactory("VotingSystem");

    const candidates = ["Ram","Sham","Gansham"];
    const votingsys = await VotingSys.deploy(candidates);

    await votingsys.deployed();

    console.log("VotingSystem deployed to:", votingsys.address);
}

main().catch((error)=>{console.error(error);process.exit(1);});