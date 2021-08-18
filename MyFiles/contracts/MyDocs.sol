//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract MyDocs {
	string public name = MyDocs;
	uint public amount = 0;
	mapping(uint => Docs) public docs;

	struct Docs {
		uint id;
		string docsHash;
		uint docsSize;
		string docsType;
		string docsName;
		string Description;
		uint Time;
		address payable uploader;
	}

	event DocsUpload(
		uint id,
		string docsHash,
		uint docsSize,
		string docsType,
		string docsName,
		string Description,
		uint Time,
		address payable uploader
	);

	constructor() {
	}

	function docsUpload(
		string memory _docsHash, 
		uint _docsSize, 
		string memory _docsType, 
		string memory _docsName,
		string memory _description
		) public payable {

		require(bytes(_docsHash).length > 0);
		require(bytes(_docsType).length > 0);
		require(bytes(_description).length > 0);
		require(bytes(_docsName).length > 0);
		require(msg.sender != address(0));
		require(_docsSize > 0);
		amount ++;
		docs[amount] = Docs(amount, _docsHash, _docsSize, _docsType, _docsName, _description, block.timestamp, msg.sender);
		emit DocsUpload(amount, _docsHash, _docsSize, _docsType, _docsName, _description, block.timestamp, msg.sender);
	}
}