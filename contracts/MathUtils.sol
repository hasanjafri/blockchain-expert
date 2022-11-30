pragma solidity >=0.4.22 <=0.8.17;

contract MathUtils {
    function floor(int256 value) public pure returns (int256) {
        int256 remainder = value % 10;
        return value - remainder;
    }

    function ceil(int256 value) public pure returns (int256) {
        int256 remainder = value % 10;
        if (remainder > 0) {
            return value + (10 - remainder);
        } else if (remainder == 0) {
            return value;
        }
        return value - 10 - remainder;
    }

    function average(int256[] memory values, bool down)
        public
        pure
        returns (int256)
    {
        if (values.length == 0) {
            return 0;
        }

        int256 sum;
        for (uint256 idx; idx < values.length; idx++) {
            sum += values[idx];
        }
        int256 avg = sum / int256(values.length);
        return down ? floor(avg) : ceil(avg);
    }
}
