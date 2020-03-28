pragma solidity ^0.5.0;

// Requirements...
// Add a new Proxy contract which will use .call() instead of .delegatecall().
// Write test cases for the new Proxy contract to test getMsgSender() and setVersion().
// Do you notice any differences between .call() and .delegatecall()?

contract ProxyCall {
    uint256 public version;
    address public owner;
    address public delegate; // contract to delegate calls to

    event LogResult(bytes result);

    constructor(address delegateAddress) public {
        owner = msg.sender;
        delegate = delegateAddress;
    }

    function() external {
        (bool success, bytes memory returnData) = delegate.call(msg.data);
        require(success, "external call failed");
        emit LogResult(returnData);
    }
}
