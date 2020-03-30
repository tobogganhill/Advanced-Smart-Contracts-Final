pragma solidity 0.5.9;

contract GreetingV1 {
    string greeting;
    
    constructor() public {
        greeting = "Hello";
    }

    function getGreeting() public view returns (string memory) {
        return greeting;
    }

    function setGreeting(string memory _greeting) public {
        greeting = _greeting;
    }
}