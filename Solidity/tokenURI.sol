pragma solidity ^0.5.0;

import "../../GSN/Context.sol";
import "./ERC721.sol";
import "./IERC721Metadata.sol";
import "../../introspection/ERC165.sol";

contract ERC721Metadata is Context, ERC165, ERC721, IERC721Metadata {
    //...
    
    // Base Token URI
    string private _baseTokenURI;

    //...
    
    // **PROPOSED CHANGE**: 
    // - `external` to `public` (Allow 'super')
    // - Concat baseURI with tokenURI
    function tokenURI(uint256 tokenId) public view returns (string memory) { 
        return string(abi.encodePacked(_baseTokenURI, _tokenURI(tokenId)));
    }
    

    /**
     * @dev Internal returns an URI for a given token ID.
     * Throws if the token ID does not exist. May return an empty string.
     * @param tokenId uint256 ID of the token to query
     */
    function _tokenURI(uint256 tokenId) internal view returns (string memory) { 
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return _tokenURIs[tokenId];
    }
    
    /**
     * @dev Internal function to set the base token URI.
     * @param uri string base URI to assign
     */
    function _setBaseTokenURI(string memory uri) internal {
        _baseTokenURI = uri;
    }
}
