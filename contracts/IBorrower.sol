pragma solidity ^0.6.0;

import "@openzeppelin/contracts-ethereum-package/contracts/access/Ownable.sol";

interface IBorrower {
    function executeOnFlashMint(uint256 amount) external;
}