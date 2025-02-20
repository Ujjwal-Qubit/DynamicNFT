pragma solidity ^0.8.0;

contract DynamicNFT {
    string public name = "AI Generated Art";
    string public symbol = "AIGA";
    uint256 public totalSupply;
    
    mapping(uint256 => address) public ownerOf;
    mapping(uint256 => string) private tokenURIs;
    mapping(uint256 => bool) public exists;
    mapping(address => uint256) public balanceOf;
    
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event MetadataUpdated(uint256 indexed tokenId, string newTokenURI);
    
    function mint(address to, string memory _tokenURI) public {
        require(to != address(0), "Invalid address");
        uint256 tokenId = totalSupply + 1;
        totalSupply++;
        ownerOf[tokenId] = to;
        balanceOf[to]++;
        tokenURIs[tokenId] = _tokenURI;
        exists[tokenId] = true;
        
        emit Transfer(address(0), to, tokenId);
    }
    
    function tokenURI(uint256 tokenId) public view returns (string memory) {
        require(exists[tokenId], "Token does not exist");
        return tokenURIs[tokenId];
    }
    
    function updateMetadata(uint256 tokenId, string memory newTokenURI) public {
        require(ownerOf[tokenId] == msg.sender, "Not the owner");
        require(exists[tokenId], "Token does not exist");
        
        tokenURIs[tokenId] = newTokenURI;
        emit MetadataUpdated(tokenId, newTokenURI);
    }
}
