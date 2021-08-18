// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Sector7slums is ERC721, VRFConsumerBase, Ownable {
    using SafeMath for uint256;
    using Strings for string;

    bytes32 internal keyHash;
    uint256 internal fee;
    uint256 public randomResult;
    address public VRFCoordinator;
    // rinkeby: 0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B
    address public LinkToken;
    // rinkeby: 0x01BE23585060835E02B77ef475b0Cc51aA1e0709a

    struct Aerith {uint256 Strength; uint256 Magic;  uint256 Vitality; 
    uint256 Spirit; uint256 Luck; uint256 Speed; uint256 Level; string name;}

    Aerith[] public aeriths;

    mapping(bytes32 => string) requestToAerithName;
    mapping(bytes32 => address) requestToSender;
    mapping(bytes32 => uint256) requestToTokenId;
    mapping(uint256 => string) private _tokenURIs;

    constructor(address _VRFCoordinator, address _LinkToken, bytes32 _keyhash)
        VRFConsumerBase(_VRFCoordinator, _LinkToken)
        ERC721("Sector7slums", "s7s")
    {   
        VRFCoordinator = _VRFCoordinator;
        LinkToken = _LinkToken;
        keyHash = _keyhash;
        fee = 0.1 * 10**18; // 0.1 LINK
    }
    function requestNewRandomAerith(string memory aerith) public returns (bytes32) {
        require(LINK.balanceOf(address(this)) >= fee, "Not enough LINK - fill contract with faucet");
        bytes32 requestId = requestRandomness(keyHash, fee);
        requestToAerithName[requestId] = aerith;
        requestToSender[requestId] = _msgSender();
        return requestId;
    }
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        string memory _tokenURI = _tokenURIs[tokenId];
        string memory base = _baseURI();
        if (bytes(base).length == 0) {
            return _tokenURI;
        }
        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(base, _tokenURI));
        }
        return super.tokenURI(tokenId);
    }
    function setTokenURI(uint256 tokenId, string memory _tokenURI) public {
        baseTokenURI(tokenId, _tokenURI);
    }
    function baseTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        _tokenURIs[tokenId] = _tokenURI;
    }
    function fulfillRandomness(bytes32 requestId, uint256 randomNumber) internal override {
        uint256 newId = aeriths.length; uint256 Strength = (randomNumber % 999); uint256 Magic = ((randomNumber % 10000) / 100 ); uint256 Vitality = ((randomNumber % 1000000) / 10000 ); 
        uint256 Spirit = ((randomNumber % 100000000) / 1000000 ); uint256 Luck = ((randomNumber % 10000000000) / 100000000 ); uint256 Speed = ((randomNumber % 1000000000000) / 10000000000);
        uint256 Level = (randomNumber % 50); aeriths.push(Aerith(Strength, Magic, Vitality, Spirit, Luck, Speed, Level, requestToAerithName[requestId]));
        _safeMint(requestToSender[requestId], newId);
    }
    function getLevel(uint256 tokenId) public view returns (uint256) {
        return sqrt(aeriths[tokenId].Level);
    }
    function getNumberOfAeriths() public view returns (uint256) {
        return aeriths.length; 
    }
    function getAerithsOverView(uint256 tokenId) public view returns (string memory, uint256, uint256, uint256) {
        return (aeriths[tokenId].name, aeriths[tokenId].Strength + aeriths[tokenId].Magic + aeriths[tokenId].Vitality + 
        aeriths[tokenId].Spirit + aeriths[tokenId].Luck + aeriths[tokenId].Speed, getLevel(tokenId), aeriths[tokenId].Level);
    }
    function getAerithsStats(uint256 tokenId) public view returns (uint256, uint256, uint256, uint256, uint256, uint256, uint256) {
        return (aeriths[tokenId].Strength, aeriths[tokenId].Magic, aeriths[tokenId].Vitality, aeriths[tokenId].Spirit,
        aeriths[tokenId].Luck,  aeriths[tokenId].Speed,aeriths[tokenId].Level  );
    }
    function sqrt(uint256 x) internal pure returns (uint256 y) {
        uint256 z = (x + 1) / 2;
        y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
    }
}