pragma solidity >=0.4.22 <=0.8.17;

contract Employee {
    // Write your code here
    enum Department {
        Gardening,
        Clothing,
        Tools
    }

    string firstName;
    string lastName;
    uint256 hourlyPay;
    Department department;

    constructor(
        string memory _firstName,
        string memory _lastName,
        uint256 _hourlyPay,
        Department _department
    ) {
        firstName = _firstName;
        lastName = _lastName;
        hourlyPay = _hourlyPay;
        department = _department;
    }

    function getWeeklyPay(uint256 hoursWorked) public view returns (uint256) {
        if (hoursWorked <= 40) {
            return hourlyPay * hoursWorked;
        }
        uint256 overtimeHours = hoursWorked - 40;
        return 40 * hourlyPay + (overtimeHours * 2 * hourlyPay);
    }

    function getFirstName() public view returns (string memory) {
        return firstName;
    }
}

contract Manager is Employee {
    // Write tour code here
    Employee[] subordinates;

    constructor(
        string memory _firstName,
        string memory _lastName,
        uint256 _hourlyPay,
        Department _department
    ) Employee(_firstName, _lastName, _hourlyPay, _department) {}

    function addSubordinate(
        string memory _firstName,
        string memory _lastName,
        uint256 _hourlyPay,
        Department _department
    ) public {
        Employee employee = new Employee(_firstName, _lastName, _hourlyPay, _department);
        subordinates.push(employee);
    }

    function getSubordinates() public view returns (string[] memory) {
        string[] memory names = new string[](subordinates.length);
        for (uint256 idx; idx < subordinates.length; idx++) {
            names[idx] = subordinates[idx].getFirstName();
        }
        return names;
    }
}