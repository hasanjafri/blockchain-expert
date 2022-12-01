pragma solidity >=0.4.22 <=0.8.17;

contract Item {
    string _name;
    uint256 _price;

    constructor(string memory name, uint price) {
        _name = name;
        _price = price;
    }
    
    // Write your code here
    function getName() public view returns (string memory) {
        return _name;
    }

    function getPrice() public view virtual returns (uint256) {
        return _price;
    }
}

contract TaxedItem is Item {
    // Write your code here
    uint256 _tax;

    constructor(string memory name, uint256 price, uint256 tax) Item(name, price) {
        _tax = tax;
    }

    function getPrice() public view override returns (uint256) {
        return _price + _tax;
    }
}
