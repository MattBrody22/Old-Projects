//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract MyFlicks {
	string public name = 'MyFlicks';
	uint public flicksAmount = 0;
	mapping(uint => Flicks) public flicks;

	struct Flicks {
		address owner;
		string title;
		string hash;
		uint id;
	}

	event FlicksUpload(
		address owner,
		string title,
		string hash,
		uint id
	);

	constructor(MyFlicks) {

	}

	function uploadFlicks(string memory _flicksHash, string memory _title) public {
		require(bytes(_flicksHash).length > 0);
		require(bytes(_title).length > 0);
		require(msg.sender != address(0));
		flicksAmount ++;
		flicks[flicksAmount] = Flicks(flicksAmount, _flicksHash, _title, msg.sender);
		emit FlicksUpload(flicksAmount, _flicksHash, _title, msg.sender);
	}
}