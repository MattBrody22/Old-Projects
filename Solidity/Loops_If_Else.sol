pragma solidity ^0.8.0;

contract Conditionals{
	/* Conditionals - commonly refered to as control flow / control structor

	if - Do something
	else - Do something else */

	address public owner;

	constructor() public {
		owner = msg.sender;
	}


	uint[] public num = [1,2,3,4,5,6,7,8,9,];
	

	function CountEven() public view returns (uint) {
		uint count = 0;

		for(uint i = 0; i < num.length; i++) {
				if(isEvenNum(num[i])) {
					count++
				}
		}
	}

	function isEvenNum(uint _num) public view returns(bool) {
		if(_num % 2 == 0) {
			return true;
		} else {
			return false;
		}
	}

	function isOwner() public view returns(bool) {
		return(msg.sender == owner);
	}

}