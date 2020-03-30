pragma solidity 0.5.9;

contract GreetingV2 {
    string greeting;
    
    constructor() public {
        greeting = "Goodbye";
    }

    function getGreeting() public view returns (string memory) {
        return greeting;
    }

    function setGreeting(string memory _greeting) public {
        greeting = _greeting;
    }
}