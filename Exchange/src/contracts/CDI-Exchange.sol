pragma solidity ^0.5.0;

import './CDItoken.sol';

contract CDIexchange {
	string public name = 'Cedar Design Inc Exchange';
	CDItoken public cditoken;
	uint public ratio = 2000;

	event Purchase(
		address consumer,
		address cditoken,
		uint quantity,
		uint ratio
	);

	event Traded(
		address consumer,
		address cditoken,
		uint quantity,
		uint ratio
	);

	constructor(CDItoken _cditoken) public {
		cditoken = _cditoken;
	}

	function purchased() public payable {
		uint quantity = msg.value * ratio;
		require(cditoken.balanceOf(address(this)) >= quantity);
		cditoken.transfer(msg.sender, quantity);
		emit Purchase(msg.sender, address(cditoken), quantity, ratio);
	}

	function traded(uint _quantity) public{
		require(cditoken.balanceOf(msg.sender) >= _quantity);
		uint XRPquantity = _quantity/ratio;
		require(address(this).balance >= XRPquantity);
		cditoken.transferFrom(msg.sender, address(this), _quantity);
		msg.sender.transfer(XRPquantity);
		emit Traded(msg.sender, address(cditoken), _quantity, ratio);
	}
}