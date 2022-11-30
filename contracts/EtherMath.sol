pragma solidity >=0.4.22 <=0.8.17;

contract EtherMath {
    address owner;
    uint256 challengeReward;
    int256[] challenge;
    int256 challengeSum;
    address[] challengers;
    mapping(address => uint256) winners;

    constructor() {
        owner = msg.sender;
    }

    function verifySolution(int256[] memory solution)
        internal
        view
        returns (bool)
    {
        int256 solutionSum;

        for (uint256 idx; idx < solution.length; idx++) {
            bool numberExists;
            for (uint256 j; j < challenge.length; j++) {
                if (challenge[j] == solution[idx]) {
                    numberExists = true;
                }
            }

            if (!numberExists) {
                return false;
            }
            solutionSum += solution[idx];
        }

        return solutionSum == challengeSum;
    }

    function userSubmittedSolution(address user) internal view returns (bool) {
        for (uint256 idx; idx < challengers.length; idx++) {
            address currentUser = challengers[idx];
            if (currentUser == user) {
                return true;
            }
        }
        return false;
    }

    function submitChallenge(int256[] memory array, int256 targetSum)
        public
        payable
    {
        // Write your code here
        require(msg.sender == owner, "Only the owner may set challenges");
        require(challengeReward == 0, "Previous challenge has not been solved yet");
        require(msg.value > 0, "Reward must be a non-zero ether value");
        challengeReward = msg.value;
        challenge = array;
        challengeSum = targetSum;
    }

    function submitSolution(int256[] memory solution) public {
        // Write your code here
        require(
            !userSubmittedSolution(msg.sender),
            "you have already submitted a solution"
        );
        require(challengeReward != 0, "New challenge is not set yet");

        challengers.push(msg.sender);
        
        if (verifySolution(solution)) {
            winners[msg.sender] += challengeReward;
            challengeReward = 0;
            challengeSum = 0;
            delete challenge;
            delete challengers;
        }
    }

    function claimRewards() public {
        // Write your code here
        require(winners[msg.sender] > 0, "You have already claimed your reward");
        uint256 rewardsToCollect = winners[msg.sender];
        winners[msg.sender] = 0;
        (bool sent, ) = payable(msg.sender).call{value: rewardsToCollect}("");
        require(sent, "claimRewards failed");
    }
}
