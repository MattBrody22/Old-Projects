//"SPDX-License-Identifier: UNLICENSED"

pragma solidity ^0.8.0;

contract CDI22 {
	mapping(address => uint256) private _balances;
	mapping(address => mapping(address => uint256)) private _allowances;
	uint private _totalSupply;
	string private CedarDesign;
	string private CDI;

		/*  Sets the values for {name} and {symbol}.
		These values are immutable: they can only be set once during construction.  */

		event Transfer(
		address indexed from,
		address indexed to,
		uint256 amount
	);

	event Approval(
		address indexed sender,
		address indexed recipient,
		uint256 amount
	);

	constructor(string memory _name, string memory _symbol) {
		CedarDesign = _name;
		CDI = _symbol;
	}

		//	Returns the name of the cryptocurrency.

	function name() public view virtual returns (string memory) {
		return CedarDesign;
	}

		// Returns the symbol of the cryptocurrency.

	function symbol() public view virtual returns (string memory) {
		return CDI;
	}

		/*	Returns the number of decimals used to get its user representation.
			Example if 'decimals' equals '2' a balance of '202' shares would be
			displayed to user as '2.02'.

			Most cryptocurrency uses 18 decimals (wei).  */

	function decimals() public view virtual returns (uint8) {
		return 18;
	}

		//	Total Shares.

	function totalSupply() public view virtual returns (uint256) {
		return _totalSupply;
	}

		//	The portion of shares.

	function balanceOf(address account) public view virtual returns(uint256) {
		return _balances[account];
	}

		// 	Transfers portions of shares.

	function transfer(address recipient, uint256 amount) public virtual returns (bool) {
		_transfer(msg.sender, recipient, amount);
		return true;
	}

		// 	Allowance

	function allowance(address owner, address spender) public view virtual returns (uint256) {
		return _allowances[owner][spender];
	}

		//	Approves transfer. ('spender' cannot be the zero address).

	function approve(address spender, uint256 amount) public virtual returns (bool) {
		_approve(msg.sender, spender, amount);
		return true;
	}

		/*	Emits an {Approval} event indicating the updated allowance.
	
			Requirements:

			- 'sender' and 'recipient' cannot be the zero address.
			- 'sender' must have a balance of at least 'amount'.
			- the caller must have allowance for 'sender's token of at least 'amount'.  */

	function transferFrom(
		address sender,
		address recipient,
		uint256 amount
		) public virtual returns (bool) {
		_transfer(sender, recipient, amount);

		uint256 currentAllowance = _allowances[sender][msg.sender];
		require(currentAllowance >= amount, 'Transfer amount exceeds allowance');
		unchecked {
			_approve(sender, msg.sender, currentAllowance - amount);
		}

		return true;
	}

		/*	Automatically increases the allowance granted to 'spender' by the caller.

			This is an alternative to {approve} that can be used as a mitigation.
			
			Emits an {Approval} event indicating the updated allowance.

			Requirements:

			- 'spender' cannot be the zero address.  */

	function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
		_approve(msg.sender, spender, _allowances[msg.sender][spender] + addedValue);
		return true;
	}

		/*	automatically decreases the allowance granted to 'spender' by caller.

			This is an alternative to {approve} that can be used as a mitigation.
			
			Emits an {Approval} event indicating the updated allowance.

			Requirements:

			- 'spender' cannot be the zero address.  
			_ 'spender' must have allowance for the last caller of at least 'subtractedValue'.  */

	function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
		uint256 currentAllowance = _allowances[msg.sender][spender];
		require(currentAllowance >= subtractedValue, 'decresed allowance below zero');
		unchecked {
			_approve(msg.sender, spender, currentAllowance - subtractedValue);
		}

		return true;
	}

		/* 	This internal function is wquivalent to {transfer}, and can be used to 
			e.g. implement automatic token fees, slashing mechanisms, ect.

			Emits a {Transfer} event.

			Requirements:

			- 'sender' cannot be the zero address.
			- 'recipient' cannot be the zero address.
			- 'sender' must have a balance of at least 'amount'.  */

	function _transfer(
		address sender,
		address recipient,
		uint256 amount
		) internal virtual {
		require(sender != address(0), 'transfer from zero account');
		require(recipient != address(0), 'transfer to the zero account');
		_beforeTokenTransfer(sender, recipient, amount);
		uint256 senderBalance = _balances[sender];
		require(senderBalance >= amount, 'transfer amount exceeds balance');
		unchecked {
			_balances[sender] = senderBalance - amount;
		}

		_balances[recipient] += amount;
		emit Transfer(sender, recipient, amount);
		_afterTokenTransfer(sender, recipient, amount);
	}

		/*	Creates 'amount' tokens and assigns them to 'account', increasing the total supply.

			Emits a {Transfer} event.

			Requirements:

			-'account' cannot be the zero address.  */

	function _mint(address account, uint256 amount) internal virtual {
		require(account != address(0), 'mint to the zero account');
		_beforeTokenTransfer(address(0), account, amount);
		_totalSupply += amount;
		_balances[account] += amount;
		emit Transfer(address(0), account, amount);
	}

		/*	Destroys 'amount' tokens from 'account', reducing the total supply.

			Emits a {Transfer} event with a 'to' set ti the zero address.

			Requirements:

			- 'accounts' cannot be the zero address.
			- 'acounts' must have at least 'amount' tokens.  */

	function _burn(address account, uint256 amount) internal virtual {
		require(account != address(0), 'burn from the zero account');
		uint256 accountBalance = _balances[account];
		require(accountBalance >= amount, 'burn amount exceeds balance');
		unchecked {
			_balances[account] = accountBalance - amount;
		}

		_totalSupply -= amount;
		emit Transfer(account, address(0), amount);
	}

		/*	Sets 'amount' as the allowance of 'spender' over the 'owner's tokens.

			This internal function is wquivalent to 'approve', and can be used to 
			e.g. set automatic allowances for certain subsystems, etc.

			Emits an {Approval} event.

			Requirements:

			- 'owner' cannot be the zero address.
			- 'spender' cannot be the zero address.  */

	function _approve(
		address owner,
		address spender,
		uint256 amount
		) internal virtual {
		require(owner != address(0), 'approve from the zero address');
		require(spender != address(0), 'approve to the zero address');
		_allowances[owner][spender] = amount;
		emit Approval(owner, spender, amount);
	}

		/* 	Hook that is called before any transfer of tokens. This includes minting and burning

			Calling Conditions:

			- when 'from' and 'to' are both non-zero, 'amount' of 'from's tokens 
			will be transfered to 'to'.
			- when 'from' is zero, 'amount' tokens will be minted fo 'to'.
			- when 'to' is zero, 'amount' of 'from's tokens will be burned.
			- 'from' and 'to' are never both zero.  */

	function _beforeTokenTransfer(
		address from,
		address to,
		uint256 amount
		) internal virtual {}

		/* 	Hook that is called before any transfer of tokens. This includes minting and burning

			Calling Conditions:

			- when 'from' and 'to' are both non-zero, 'amount' of 'from's tokens 
			will be transfered to 'to'.
			- when 'from' is zero, 'amount' tokens will be minted fo 'to'.
			- when 'to' is zero, 'amount' of 'from's tokens will be burned.
			- 'from' and 'to' are never both zero.  */

	function _afterTokenTransfer(
		address from,
		address to,
		uint256 amount
		) internal virtual {}
}