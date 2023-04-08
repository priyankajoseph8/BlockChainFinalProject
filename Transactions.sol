//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.7;

contract Transactions {

    //Address --> Contract -- deposit
    function deposit() external payable {
    }

    //Contract --> Address  -- withdrawal
    function withdraw(address payable _to, uint _amount) external {
        _to.transfer(_amount);
    }

    function getBalance() external view returns(uint) {
        return address(this).balance;
    }

    function getAddress() external view returns(address) {
        return address(this);
    }
    struct User {
        string fullname;
        string email;
        string username;
        string password;
    }

    mapping(address => User) public users;

    function storeUser(
        string memory _fullname,
        string memory _email,
        string memory _username,
        string memory _password
    ) public {
        User memory newUser = User({
            fullname: _fullname,
            email: _email,
            username: _username,
            password: _password
        });

        users[msg.sender] = newUser;
    }
 
struct Bet {
        uint256 amount;
        uint16 team;
    }

    address public owner;
    mapping(address => Bet) public bets;
    address[] public bettors;

    constructor() {
        owner = msg.sender;
    }

    function placeBet(uint16 team) external payable {
        require(team == 1 || team == 2, "Invalid team number");
        require(msg.value > 0, "Bet amount should be greater than 0");
        
        if (bets[msg.sender].amount == 0) {
            bettors.push(msg.sender);
        }

        bets[msg.sender] = Bet({
            amount: msg.value,
            team: team
        });
    }

    function distributeWinnings(uint16 winningTeam) external {
        require(msg.sender == owner, "Only the owner can distribute winnings");
        require(winningTeam == 1 || winningTeam == 2, "Invalid winning team number");

        uint256 winningAmount = 0;
        uint256 totalAmount = 0;

        for (uint256 i = 0; i < bettors.length; i++) {
            address bettor = bettors[i];
            Bet storage bet = bets[bettor];

            if (bet.team == winningTeam) {
                winningAmount += bet.amount;
            }
            totalAmount += bet.amount;
        }

        for (uint256 i = 0; i < bettors.length; i++) {
            address bettor = bettors[i];
            Bet storage bet = bets[bettor];

            if (bet.team == winningTeam) {
                uint256 payout = (bet.amount * totalAmount) / winningAmount;
                payable(bettor).transfer(payout);
            }
        }

        // Reset bet data
        for (uint256 i = 0; i < bettors.length; i++) {
            delete bets[bettors[i]];
        }
        delete bettors;
    }

    function getBetDetails(address user) external view returns (uint256, uint16) {
        return (bets[user].amount, bets[user].team);
    }

}
