pragma solidity >=0.4.22 <=0.8.17;

contract TimedAuction {
    address highestBidder;
    uint256 highestBid;

    mapping(address => uint256) oldBids;
    uint256 totalWithdrableBids;
    // need this in case users try to tamper with the contract
    // by sending funds without using the bid() function

    address owner;
    uint256 startTime;

    event Bid(address indexed sender, uint256 amount, uint256 timestamp);

    constructor() {
        owner = msg.sender;
        startTime = block.timestamp;
    }

    function bid() external payable {
        require(block.timestamp - startTime < 5 minutes, "auction is over");
        require(msg.value > highestBid, "bid is too low");

        oldBids[highestBidder] += highestBid;
        totalWithdrableBids += highestBid;

        highestBidder = msg.sender;
        highestBid = msg.value;
        emit Bid(msg.sender, msg.value, block.timestamp);
    }

    function withdraw() public {
        uint256 amount = oldBids[msg.sender];
        oldBids[msg.sender] = 0;
        totalWithdrableBids -= amount;

        (bool sent, ) = payable(msg.sender).call{value: amount}("");
        require(sent, "transfer failed");
    }

    function claim() public {
        require(msg.sender == owner);
        require(
            block.timestamp - startTime >= 5 minutes,
            "auction has not completed yet"
        );
        require(
            totalWithdrableBids == 0,
            "not all users have claimed their bids yet"
        );
        selfdestruct(payable(owner));
    }

    function getHighestBidder() public view returns (address) {
        return highestBidder;
    }
}
