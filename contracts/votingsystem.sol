// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

import "hardhat/console.sol";

contract VotingSystem {

    struct Candidate {
        string name;
        uint votes;
    }

    address admin;
    mapping(address=>bool) public hasVoted;
    Candidate[] public candidates;

    event VoteCasted(address Voter, string Candidate);

    constructor(string[] memory _candidatenames){

        console.log("stetting up canidate names");

        for(uint i=0;i<_candidatenames.length;i++){
            candidates.push(Candidate(_candidatenames[i],0));
            console.log("   pushing candidate %d who is %s",i+1,_candidatenames[i]);
        }

        admin = msg.sender;

        console.log("canidate names successfully set");

    }

    function vote (uint _candidateindex) public 
    {
        console.log("casting a vote to candiate at index",_candidateindex);

        require(_candidateindex < candidates.length ,"Invalid candiate index ");
        require(!hasVoted[msg.sender],"You have already voted");

        candidates[_candidateindex].votes+=1;
        hasVoted[msg.sender]=true;

        emit VoteCasted(msg.sender , candidates[_candidateindex].name);

        console.log("   successfully casted vote to %s at index %d he has %d votes",candidates[_candidateindex].name,_candidateindex ,candidates[_candidateindex].votes);
    }

    function getWinner() external view returns (string memory)
    {
        console.log("Picking a winner ");
        uint winnerv=candidates[0].votes;
        uint winnerindex=0;
        for(uint i=1; i< candidates.length ;i++)
        {
            if (candidates[i].votes > winnerv)
            {
                winnerindex = i;
                winnerv = candidates[i].votes;
            }
        }

        require(candidates[winnerindex].votes > 0, "no one has voted yet");

        for(uint i=0;i< candidates.length;i++){
    
            console.log(" %s has %d votes",candidates[i].name,candidates[i].votes);
        }


        console.log("winner is  %s with %d votes",candidates[winnerindex].name,candidates[winnerindex].votes);

        return candidates[winnerindex].name;
    }

   
}

