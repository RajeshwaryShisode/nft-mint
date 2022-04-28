// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";


contract NFT is ERC721URIStorage {
  using Counters for Counters.Counter;

  Counters.Counter private currentTokenId;

  Counters.Counter private _tokenIds;

  /// @dev Base token URI used as a prefix by tokenURI().
  string public baseTokenURI;

  constructor() ERC721("IntuitGEDNFT", "INTUNFT") {
    baseTokenURI = "";
  }

  function mintTo(address recipient) public returns (uint256) {
    currentTokenId.increment();
    uint256 newItemId = currentTokenId.current();
    _safeMint(recipient, newItemId);
    return newItemId;
  }

  /// @dev Returns an URI for a given token ID
  function _baseURI() internal view virtual override returns (string memory) {
    return baseTokenURI;
  }

  /// @dev Sets the base token URI prefix.
  function setBaseTokenURI(string memory _baseTokenURI) public {
    baseTokenURI = _baseTokenURI;
  }


    function createNFT(address recipient, string memory tokenURI) public returns (uint256)
      {
          _tokenIds.increment();
          uint256 newItemId = _tokenIds.current();
          _safeMint(recipient, newItemId);
          _setTokenURI(newItemId, tokenURI);
          return newItemId;
      }
}