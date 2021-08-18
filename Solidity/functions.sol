//// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

/*	There are four types of functions:
- Internal:(Default type): They can only be called inside the cyrrent contract.
- External:They can be called from other contracts and via transactions.
- Private: they are only visible for the contract they are defined in and not in derived contracts.
- Public: Functions are part of the contract interface and can be either called internally or via messages.
  for public state variables, an automatic getter function is generated.

Function definition:
	function (parameter types) {internal|external} [pure|view|payable] [returns (return types)]

	A public function can be accessed both internally and externally with this keyword -- public -- */

contract FunctionTypes {

		// Below are function visiblity types.

		// A private function is one that can only be called by the main contract itself.

	function secret() private {
		secret();
	}

		// An internal function can be called by the main contract itself, plus any derived contracts.

	function _address() internal {
		this._address();
	}

		// 
}