pragma solidity ^0.8.0;

/*  Ether - pay smart contracts
	Modifiers
	Visibility
	Events
	Enums  */

contract HotelRoom {

	enum Statues {Vacant, Occupied}
	Statuses currentStatus;

	event Occupy( address _occupant, uint _value);

	address payable public owner;

	constructor() public{
		owner = msg.sender;
		currentStatus = Statuses.Vacant;
	}

	modifier onlyWhileVacant {
		require(currentStatus == Statuses.Vacant, 'Currently occupied.');
		_;
	}

	modifier cost (uint _amount) {
		require(msg.value >= _amount, 'Not enough Ether provided.');
		_;
	}
	receive() external payable onlyWhileVacant cost(2 ether) {
		currentStatus = Statuses.Occupied;
		owner.transfer(msg.value);
		emit Occupy(msg.sender, msg.value);
	}
}