// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Lottery {
    // Global States
    address owner;
    uint256 public pot;
    uint256 ticketPrice = 1 ether;
    uint256 public endTime;
    uint256 public MAX_VALID_NUMBER = 4;
    mapping(uint256 => address[]) public tickets;

    // Error
    error EndTimeReached();

    // modifire
    modifier onlyOwner{
        require(msg.sender == owner , "You do not have access");
        _;
    }

    // Event
    event Entered(address user);
    event DistributeFunds(address[] Winners , uint WinningAmount);

    constructor(uint256 _endTime){
        require(_endTime > block.timestamp, "End Time must be in the Future!!");

        owner = msg.sender;
        endTime = _endTime;
    }

    function enterLottery(uint256 _number) public  payable {
        require(_number <= MAX_VALID_NUMBER , "Number must be lower than or equal 4");
        require(msg.value == ticketPrice , "Ticket price is 1 ether");
        if (block.timestamp >= endTime) revert EndTimeReached();
        tickets[_number].push(msg.sender);
        pot += ticketPrice;

        emit Entered(msg.sender);
    }

    function closeLottery(uint _randomNumber) public  onlyOwner{
        require(block.timestamp > endTime , "Lottery has not ended");
        uint earnings;
        uint randomNumber = randomGenerator(_randomNumber);
        address[] memory winners = tickets[randomNumber];
        if(winners.length > 0){
            earnings = pot / winners.length;
            pot = 0;
            for(uint256 i=0 ; i< winners.length ; i++){
                (bool success , ) = payable(winners[i]).call{value:earnings}("");
                require(success);
            }
        }
        emit DistributeFunds(winners, earnings);


    }
    function randomGenerator(uint _salt) public view  returns(uint randomNumber){
        uint randNumber = uint(keccak256(abi.encodePacked(block.difficulty , block.timestamp , _salt)));
        if((randNumber%10) + 1 < 1) randomNumber=0;
        if((randNumber%10) + 1 > 2 && (randNumber%10) < 4 ) randomNumber=1;
        if((randNumber%10) + 1 > 4 && (randNumber%10) < 6 ) randomNumber=2;
        if((randNumber%10) + 1 > 6 && (randNumber%10) < 8 ) randomNumber=3;
        if((randNumber%10) + 1 > 8 && (randNumber%10) < 10 ) randomNumber=4;
    }
    function updateLotteryEndTime(uint _endTime) public onlyOwner{
        endTime = _endTime;
    }
}