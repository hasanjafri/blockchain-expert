pragma solidity >=0.4.22 <=0.8.17;

contract ShoppingList {
    mapping(address => User) users;

    struct User {
        mapping(string => List) lists;
        string[] listNames;
    }

    struct Item {
        string name;
        uint256 quantity;
    }

    struct List {
        string name;
        Item[] items;
    }

    function listExists(string memory name) internal view returns (bool) {
        // if name of accessed list is empty than list has not been created
        return bytes(users[msg.sender].lists[name].name).length != 0;
    }

    function createList(string memory name) public {
        require(!listExists(name), "a list with this name already exists");
        require(bytes(name).length > 0, "name cannot be empty");
        users[msg.sender].listNames.push(name);
        users[msg.sender].lists[name].name = name;
    }

    function getListNames() public view returns (string[] memory) {
        return users[msg.sender].listNames;
    }

    function getItemNames(string memory listName)
        public
        view
        returns (string[] memory)
    {
        require(listExists(listName), "no list with this name exists");
        string[] memory names = new string[](
            users[msg.sender].lists[listName].items.length
        );
        for (uint256 idx; idx < names.length; idx++) {
            names[idx] = users[msg.sender].lists[listName].items[idx].name;
        }
        return names;
    }

    function addItem(
        string memory listName,
        string memory itemName,
        uint256 quantity
    ) public {
        require(listExists(listName), "no list with this name exists");
        users[msg.sender].lists[listName].items.push(Item(itemName, quantity));
    }
}
