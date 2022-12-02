pragma solidity >=0.4.22 <=0.8.17;

interface Driveable {
    // Write your code here
    function startEngine() external;

    function stopEngine() external;

    function fuelUp(uint256 litres) external;

    function drive(uint256 kilometers) external;

    function kilometersRemaining() external view returns (uint256);
}

abstract contract GasVehicle is Driveable {
    // Write your code here
    uint256 litresRemaining;
    bool started;

    modifier sufficientTankSize(uint256 litres) {
        require(litresRemaining + litres <= getFuelCapacity(), "Insufficient fuel");
        _;
    }

    modifier sufficientKilometersRemaining(uint256 kilometers) {
        require(kilometersRemaining() >= litresRemaining, "Insufficient kilometers");
        _;
    }

    modifier notStarted() {
        require(!started, "Vehicle already started");
        _;
    }

    modifier isStarted() {
        require(started, "Vehicle is not started");
        _;
    }

    function startEngine() external override notStarted {
        started = true;
    }

    function stopEngine() external override isStarted {
        started = false;
    }

    function fuelUp(uint256 litres) external override sufficientTankSize(litres) notStarted {
        litresRemaining += litres;
    }

    function drive(uint256 kilometers) external override isStarted sufficientKilometersRemaining(kilometers) {
        litresRemaining -= kilometers / getKilometersPerLitre();
    }

    function kilometersRemaining() public view override returns (uint256) {
        return litresRemaining * getKilometersPerLitre();
    }

    function getKilometersPerLitre() public view virtual returns (uint256);

    function getFuelCapacity() public view virtual returns (uint256);
}

contract Car is GasVehicle {
    // Write your code here
    uint256 fuelTankSize;
    uint256 kilometersPerLitre;

    constructor(uint256 _fuelTankSize, uint256 _kilometersPerLitre) {
        fuelTankSize = _fuelTankSize;
        kilometersPerLitre = _kilometersPerLitre;
    }

    function getKilometersPerLitre() public view override returns (uint256) {
        return kilometersPerLitre;
    }

    function getFuelCapacity() public view override returns (uint256) {
        return fuelTankSize;
    }
}
