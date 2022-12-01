pragma solidity >=0.4.22 <=0.8.17;

interface Comparable {
    // Write your code here
    function greaterThan(Comparable other) external view returns (bool);

    function lessThan(Comparable other) external view returns (bool);

    function equalTo(Comparable other) external view returns (bool);

    function getValue() external view returns (int256);
}

contract Vector is Comparable {
    int256 a;
    int256 b;

    constructor(int256 _a, int256 _b) {
        a = _a;
        b = _b;
    }

    function getValue() public view override returns (int256) {
        return a + b;
    }

    function greaterThan(Comparable other) external view override returns (bool) {
        return getValue() > other.getValue();
    }

    function lessThan(Comparable other) external view override returns (bool) {
        return getValue() < other.getValue();
    }

    function equalTo(Comparable other) external view override returns (bool) {
        return getValue() == other.getValue();
    }
}
