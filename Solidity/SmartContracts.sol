pragma solidity ^0.8.0;

contract Ownable {
	address owner;

	constructor() public {
		owner = msg.sender;
	}

	modifier onlyOwner() {
		require(msg.sender == owner, 'must be owner');
		_;
	}
}

contract SecretValut {
	string secret;

	constructor(string memory _secret) public {
		secret = _secret;
	}

	function getSecret() public view returns(string memory) {
		return secret;
	}
}

contract SmartC is Ownable {
	address secretValut;

	constructor(string memory _secret) public {
		SecretValut _secretValut = new SecretValut(_secret);
		secret = address(_secretValut);
		super;
	}

	function getSecret() public view onlyOwner returns(string memory) {
		SecretValut _secretValut = SecretValut(secretValut);
		return _secretValut.getSecret();
	}
}
