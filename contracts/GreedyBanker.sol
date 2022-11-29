pragma solidity >=0.4.22 <=0.8.17;

contract GreedyBanker {
    uint256 constant fee = 1000 wei;
    mapping(address => uint256) balances;
    mapping(address => uint256) depositCount;
    uint256 feesCollected;
    address owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
        // Write your code here
        uint256 depositFee;
        if (depositCount[msg.sender] >= 1) {
            require(msg.value >= fee, "Not enough for fees");
            depositFee = fee;
        }

        balances[msg.sender] += msg.value - depositFee;
        feesCollected += depositFee;
        depositCount[msg.sender]++;
    }

    fallback() external payable {
        // Write your code here
        feesCollected += msg.value;
    }

    function withdraw(uint256 amount) external {
        // Write your code here
        require(balances[msg.sender] >= amount, "Not enough balance");
        balances[msg.sender] -= amount;
        (bool sent, ) = payable(msg.sender).call{value: amount}("");
        require(sent, "Withdrawal failed");
    }

    function collectFees() external {
        // Write your code here
        require(msg.sender == owner, "You are not the owner");
        uint256 feesToCollect = feesCollected;
        feesCollected = 0;
        (bool sent, ) = payable(owner).call{value: feesToCollect}("");
        require(sent, "collectFees failed");
    }

    function getBalance() public view returns (uint256) {
        // Write your code here
        return balances[msg.sender];
    }
}