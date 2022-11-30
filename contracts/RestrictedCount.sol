pragma solidity >=0.4.22 <=0.8.17;

contract RestrictedCount {
    // Write your code here
    address owner;
    int256 count;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "You are not the owner"
        );
        _;
    }

    modifier addCheck(int256 value) {
        require(count + value <= 100);
        require(count + value >= -100);
        _;
    }

    modifier subtractCheck(int256 value) {
        require(count - value >= -100);
        require(count - value <= 100);
        _;
    }

    function add(int256 value) public onlyOwner addCheck(value) {
        count += value;
    }

    function subtract(int256 value) public onlyOwner subtractCheck(value) {
        count -= value;
    }

    function getCount() public view onlyOwner returns (int256) {
        return count;
    }
}