pragma solidity ^0.8.0;

/*
	Solidity - is a statically typed langauge 
	which means you must write the type of data you're using 
	before you declare the variable

	Var - is a variable that you can use to store information that 
	you can reuse inside your smart contracts.

	State Var - is information stored on a blockchain

	Local Var - is information that can be used inside of a function 
	and can not be accesed outside of that function

*/

/*
	NUMBER DATA TYPES

	Uint - ia an unassigned intiger (by defult short for uint256)
	units cannot have a sign before them such as - or +
	There are differnt types of 'uint' such as uint256 or uint8
	The difference between different 'uintxxx' is size which 
	The bigger the 'uintxxx' the more space is needed  
	Int - is an intiger 

	STRING DATA TYPES

	Strings - are letters or charatchers put together 
	bytes32 - is another way of writing a string 
	with less performance

	ADDRESS DATA TYPE

	Address -  tells use were the data is coming from
	every user thats connected to the blockchain has there own address
	every smart contract on the blockchain has an address

	STRUCT DATA TYPE

	Struct -  is a way for you model data
	this could represent a person, a vote, or any data


*/

contract MyContract {

	// State var

	// String 
	string public myString = 'I love you Damiana!!';
	bytes32 public myBytes32 = 'I miss your face';
	int public myint = 22;
	uint public myUnit = 22;
	uint256 public myUint256 = 22;
	uint8 public myUint8 = 22;
	// Address
	address public myAddress = 0x26296bE83d9b4a2E91428327722145d6a6d9dA8D;
	// Stuct 
	struct MyStruct {
		uint myInt;
		string myString;
	}

	MyStruct public myStruct = MyStruct(22, 'Damiana');

	// Local var
	function getValue() public pure returns(uint) {
		uint value = 22;
		return value;
	}
}





































