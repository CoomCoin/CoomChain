import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/CoomCoin.sol";

pragma solidity ^0.6.0;

contract TestCoomCoin {
  function testInitialBalanceUsingDeployedContract() public {
    CoomCoin coomCoin = CoomCoin(DeployedAddresses.CoomCoin());

    uint expected = 690000000 * 10**18;

    Assert.equal(coomCoin.balanceOf(tx.origin), expected, "Owner should have 690000000 CoomCoin initially");
  }
}