// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "openzeppelin/token/ERC20/ERC20.sol";
import "openzeppelin/token/ERC20/extensions/ERC20Burnable.sol";
import "openzeppelin/access/Ownable.sol";

contract MyToken is ERC20, ERC20Burnable, Ownable {
    constructor (string memory _name, string memory _symbol) ERC20 (_name,_symbol) {
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
