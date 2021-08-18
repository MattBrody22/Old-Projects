pragma solidity ^0.8.0;

contract Mappings{
	// Mapping - A key value store
	mapping(uint => string) public names;
	mapping(uint => Letter) public letters;
	mapping(address => mapping(uint => Letter)) public myLetters;

	struct Letter {
		string title;
		string to;
	}

	constructor() public {
		names[1] = 'Damiana';
		names[2] = 'Marlee';
		names[3] = 'Marta';
		names[4] = 'Skylar';
	}

	function addLetter(uint _id, string memory _title, string memory _to) public {
		letters[_id] = Letter(_title, _to);
	}

	function addMyLetter(uint _id, string memory _title, string memory _to) public {
		myLetters[msg.sender][_id] = Letter(_title, _to);
	}
}

