const {expect} = require("chai");

const { ethers } = require("hardhat");

describe("VotingSystem", function() {
    let votingsys;

    beforeEach(async function(){
        const VotingSys = await ethers.getContractFactory("VotingSystem");
        votingsys = await VotingSys.deploy(["Ram","Sham","Gansham"]);
        await votingsys.deployed();

    });

    it("should log vote to a candidate at some givent index",async function () {

        await votingsys.vote(0);
        
    });

    it("should log get the winner of the election",async function(){
        
        await votingsys.vote(0);
        await votingsys.getWinner();

    });
});
