//+++++++++++++++++++++++++++++++++++++++++++++++++
// Andrew Starling | 100191710
// Advanced Smart Contracts | Final Assignment
//+++++++++++++++++++++++++++++++++++++++++++++++++

pragma solidity 0.5.9;

contract ProxyContract {
    // address of the deployed smart contract
    address public deployed;
    // owner of the proxy contract
    address public owner;
    
    constructor() public {
        // set the owner equal to the creator of this smart contract
        owner = msg.sender;
    }
    
    // function to update the address of the deployed smart contract
    function updateAddress(address _deployed) external {
        // update the variable to the new version of the deployed smart contract
        require(owner == msg.sender, 'must be owner to update address');
        deployed = _deployed;
    }
    
    // fallback function
    function() external {
        
        // make sure that the updateAddress function has been called with an address to a new version of the smart contract
        require (deployed != address(0), 'cannot be address 0');
        
        // copy to a local variable because assembly cannot access state variables
        address addr = deployed;
        
        assembly {
            
            // memory slot at position 0x40 contains the value for the next available free memory pointer
            let ptr := mload(0x40)
            
            // use calldatacopy to copy calldata of size calldatasize, starting from 0 of calldata to location at pointer
            calldatacopy(ptr, 0, calldatasize)
            
            // Parameters
            // ----------
            // gas --- gas needed to execute the function
            // addr --- address of the contract being called
            // ptr --- memory pointer where the data begins
            // calldatasize --- size of the data being passed
            // 0 --- data out / returned value from calling the contract
            //       Unused because we do not yet know the size of data out
            //       and therefore cannot assign it to a variable
            //       We can still access this information using returndata opcode later.
            // 0 --- size out. Unused because we didn’t get a chance to create a temp variable
            //       to store data out, since we didn’t know the size of it prior to calling
            //       the other contract. We can get this value using an alternative way by
            //       calling the returndatasize opcode later
            let result := delegatecall(gas, addr, ptr, calldatasize, 0, 0)
            
            // size of the returned data using the returndatasize opcode
            let size := returndatasize
            
            //  use the size of the returned data to copy over the contents of
            //  returned data to pointer variable with returndatacopy opcode
            returndatacopy(ptr, 0, size)
            
            // Returns data or throws an exception if there was a problem
            switch result
                // case 0 -- problem with the function call
                case 0 { revert(ptr, size) }
                default { return(ptr, size) }
        }
    }
}
















