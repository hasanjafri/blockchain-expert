pragma solidity >=0.4.22 <=0.8.17;

contract EtherElection {
    mapping(address => bool) voted;
    mapping(address => uint256) candidates;
    uint8 numberOfCandidates;
    address owner;
    address winner;
    bool winnerWithdrew;

    constructor() {
        owner = msg.sender;
    }

    function enroll() public payable {
        // Write your code here
        require(msg.value == 1 ether, "You must submit exactly one ether");
        require(numberOfCandidates < 3, "Election has already started");
        require(candidates[msg.sender] == 0, "You have already enrolled");
        candidates[msg.sender] = 1;
        numberOfCandidates++;
    }

    function vote(address candidate) public payable {
        // Write your code here
        require(numberOfCandidates == 3, "Voting has not started yet");
        require(candidates[candidate] >= 1, "This address is not a valid candidate");
        require(winner == address(0), "This voting phase is complete");
        require(msg.value == 10000, "You must send exactly 10000 wei to vote");
        require(!voted[msg.sender], "You have already voted");
        voted[msg.sender] = true;
        candidates[candidate]++;
        if (candidates[candidate] == 6) {
            winner = candidate;
        }
    }

    function getWinner() public view returns (address) {
        // Write your code here
        require(winner != address(0), "Voting is not yet complete");
        return winner;
    }

    function claimReward() public {
        // Write your code here
        require(winner != address(0), "Voting is not yet complete");
        require(!winnerWithdrew, "Reward has already been collected");
        require(msg.sender == winner, "You are not the winner");
        winnerWithdrew = true;
        (bool sent, ) = payable(winner).call{value: 3 ether}("");
        require(sent, "claimReward failed");
    }

    function collectFees() public {
        // Write your code here
        require(winnerWithdrew, "Reward has not yet been collected");
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(payable(owner));
    }
}
