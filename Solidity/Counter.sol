pragma solidity ^0.8.0;

// Stay var
contract Counter {
	uint count; 

// Starts counter at (0)
	constructor() public {
		count = 0;
	}

// Shows the count
	function getCount() public view returns(uint) { 
		return count;
	}

// Adds (1) to the count
	function incrementCount() public {
		count = count +1;
	}
}


/*

Does the EXACT same as above but simplfied
Adding 'public' to uint creates an unseen function
Adding = to 'count' sets the vaule automaticaly
Adding ++ adds 1 to any function its assigned to, in this case the 'count()'

contract Counter {
	uint public count = 1;

	function incrementCount() public {
		count ++;
	}
}