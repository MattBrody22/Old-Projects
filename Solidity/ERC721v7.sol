//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
interface ERC165 {
	function supportsInterface(bytes4 interfaceID) external view returns(bool);
}
interface ERC721 is ERC165 {
	event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
	event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
	event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

	function balanceOf(address _owner) external view returns(uint256);
	function ownerOf(uint256 _tokenId) external view returns(address);
	function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes calldata _data) external;
	function safeTransferFrom(address _from, address _to, uint256 _tokenId) external;
	function transferFrom(address _from, address _to, uint256 _tokenId) external;
	function approve(address _approved, uint256 _tokenId) external;
	function setApprovedForAll(address _operator, bool _approved) external;
	function isApprovedForAll(address _owner, address _operator) external view returns(bool);
}
interface ERC721TokenReceiver {
	function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes calldata _data) external returns(bytes4);
}
interface ERC721Metadata is ERC721 {
	function name() external view returns(string memory);
	function symbol() external view returns (string memory);
	function tokenURI(uint256 tokenId) external view returns(string memory);
}
abstract contract Context {
	function _msgSender() internal view virtual returns(address) {
		return msg.sender;
	}
	function _msgData() internal view virtual returns(bytes calldata) {
		return msg.data;
	}
}
abstract contract Ownable is Context {
	address private _owner;
	event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
	constructor() {
		_setOwner(_msgSender());
	}
	function owner() public view virtual returns(address) {
		return _owner;
	}
	modifier onlyOwner() {
		require(owner() == _msgSender(), 'Error: not the owner');
		_;
	}
	function renounceOwnership() public virtual onlyOwner {
		_setOwner(address(0));
	}
	function transferOwnership(address newOwner) public virtual onlyOwner {
		require(newOwner != address(0), 'Error: new owner is zero address');
		_setOwner(newOwner);
	}
	function _setOwner(address newOwner) private {
		address oldOwner = _owner;
		_owner = newOwner;
		emit OwnershipTransferred(oldOwner, newOwner);
	}
}
contract ERC721v7 is ERC165, ERC721, ERC721TokenReceiver, ERC721Metadata, Context, Ownable {
	string private _name = 'Long Island Ladies';
	string private _symbol = 'LIL';
	string private _baseTokenURI = 'https://ipfs.io/ipfs/';

	mapping(uint256 => string) private _tokenURIs;
	mapping(uint256 => address) private _owners;
	mapping(uint256 => address) private _tokenApprovals;
	mapping(address => uint256) private _balances;
	mapping(address => mapping(address => bool)) _operatorApprovals;

	constructor() {}

	function supportsInterface(bytes4 interfaceID) public view virtual override(ERC165) returns(bool) {
		return supportsInterface(interfaceID);
	}
	function balanceOf(address _owner) public view virtual override returns(uint256) {
		return _balances[_owner];
	}
	function ownerOf(uint256 _tokenId) public view virtual override returns(address) {
		address _owner = _owners[_tokenId];
		return _owner;
	}
	function safeTransferFrom(address _from, address _to, uint256 _tokenId) public virtual override {
		transferFrom(_from, _to, _tokenId);
	}
	function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes calldata _data) public virtual override {
		safeTransferFrom(_from, _to, _tokenId, _data);
	}
	function transferFrom(address _from, address _to, uint256 _tokenId) public virtual override {
		require(ownerOf(_tokenId) == _from, 'Error: only owner can transfer');
		require(_to != address(0), 'Error: Tranfering to none existing address');
		approve(address(0), _tokenId);
		_balances[_from] -= 1;
		_balances[_to] += 1;
		_owners[_tokenId] = _to;
		emit Transfer(_from, _to, _tokenId);
	}
	function approve(address _to, uint256 _tokenId) public virtual override {
		address _owner = ownerOf(_tokenId);
		require(_to != _owner, 'Error: you are already approved');
		require(_msgSender() == _owner || isApprovedForAll(_owner, _msgSender()), 'Error: not approved');
		_tokenApprovals[_tokenId] = _to;
		emit Approval(ownerOf(_tokenId), _to, _tokenId);
	}
	function setApprovedForAll(address _operator, bool _approved) public virtual override {
		require(_operator != _msgSender(), 'Error: caller is approved');
		_operatorApprovals[_msgSender()][_operator] = _approved;
		emit ApprovalForAll(_msgSender(), _operator, _approved);
	}
	function isApprovedForAll(address _owner, address _operator) public view virtual override returns(bool) {
		return _operatorApprovals[_owner][_operator];
	}
	function onERC721Received(address, address, uint256, bytes calldata) external pure override returns(bytes4) {
		return bytes4(keccak256("onERC721Received(address,address,uint256,bytes calldata)"));
	}
	function name() public view virtual override returns(string memory) {
		return _name;
	}
	function symbol() public view virtual override returns(string memory) {
		return _symbol;
	}
	function tokenURI(uint256 _tokenId) public view override returns (string memory) { 
        return string(abi.encodePacked(_baseTokenURI, _tokenURI(_tokenId)));
    }
    function _tokenURI(uint256 _tokenId) internal view returns (string memory) { 
        return _tokenURIs[_tokenId];
    }
    function _setBaseTokenURI(string memory uri) internal {
        _baseTokenURI = uri;
    }
    function mint(address _to, uint256 _tokenId) internal virtual {
        require(_to != address(0), 'Error: address does not exist');
        _balances[_to] += 1;
        _owners[_tokenId] = _to;
        emit Transfer(address(0), _to, _tokenId);
    }
	function burn(uint256 _tokenId) internal {
		  address _owner = ownerOf(_tokenId);
        approve(address(0), _tokenId);
        _balances[_owner] -= 1;
        delete _owners[_tokenId];
        emit Transfer(_owner, address(0), _tokenId);
    }
}