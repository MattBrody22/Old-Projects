 //SPDX-License-Identifier: UNLICENSED
 pragma solidity ^0.8.0;

 contract Election {
   uint public candidatesCount;  //store candidates vote count

  mapping(address => bool) public voters; // store accounts that have voted
 	mapping(uint => Candidate) public candidates; // stores candidates

   event votedEvent(uint indexed _candidateId);

   struct Candidate {uint id; string name; uint voteCount;}
   
 	constructor() {
 		addCandidate('Marlee');
 		addCandidate('Dami');
 		addCandidate('Marta');
 		addCandidate('Dylan');

 	}
 	function addCandidate(string memory _name) private {
 		candidatesCount ++;
 		candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
 	}
    function vote(uint _candidateId) public {
        require(!voters[msg.sender]);   // checks voter hasn't already voted
        require(_candidateId > 0 && _candidateId <= candidatesCount);
        voters[msg.sender] = true;  //records that voter has voted
        candidates[_candidateId].voteCount ++;  //updates vote count
        emit votedEvent(_candidateId);
    }
 }