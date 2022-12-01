pragma solidity >=0.4.22 <=0.8.17;

library Array {
    // Write your code here
    function indexOf(int256[] memory numbers, int256 target) public pure returns (int256) {
        for (uint256 idx; idx < numbers.length; idx++) {
            if (numbers[idx] == target) {
                return int256(idx);
            }
        }

        return -1;
    }

    function count(int256[] memory numbers, int256 target) public pure returns (uint256) {
        uint256 targetCount;

        for (uint256 idx; idx < numbers.length; idx++) {
            if (numbers[idx] == target) {
                targetCount++;
            }
        }

        return targetCount;
    }

    function sum(int256[] memory numbers) public pure returns (int256) {
        int256 arraySum;

        for (uint256 idx; idx < numbers.length; idx++) {
            arraySum += numbers[idx];
        }

        return arraySum;
    }
}
