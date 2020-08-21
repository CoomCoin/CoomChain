pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/SafeERC20.sol";

// @title FlashCondomWrappedCoom
contract FlashCoom is ERC20 {

    using SafeERC20 for ERC20;

    // ERC20-Detailed
    string public name = "FlashCoom"; 
    string public symbol = "fCoom";
    uint8  public decimals = 18;

    // underlying coom contract
    ERC20 public underlying = ERC20(0x2f3e054D233c93C59140c0905227c7C607c70cbb); 

    event Approval(address indexed src, address indexed guy, uint256 wad);
    event Transfer(address indexed src, address indexed dst, uint256 wad);
    event Deposit(address indexed dst, uint256 wad);
    event Withdrawal(address indexed src, uint256 wad);
    event FlashMint(address indexed src, uint256 wad);

    function deposit(uint256 wad) public {
        underlying.safeTransferFrom(msg.sender, address(this), wad);
        _mint(msg.sender, wad);
        emit Deposit(msg.sender, wad);
    }

    function withdraw(uint256 wad) public {
        _burn(msg.sender, wad); // reverts if `msg.sender` does not have enough fCOOM
        underlying.safeTransfer(msg.sender, wad);
        emit Withdrawal(msg.sender, wad);
    }

    // Allows anyone to mint unbacked fCOOM as long as it gets burned by the end of the transaction.
    function flashMint(uint256 amount) public {
        _mint(msg.sender, amount);
        IBorrower(msg.sender).executeOnFlashMint(amount);
        _burn(msg.sender, amount); // reverts if `msg.sender` does not have enough units of the FMT
        assert(underlying.balanceOf(address(this)) >= totalSupply());
        emit FlashMint(msg.sender, amount);
    }
}