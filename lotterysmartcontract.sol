// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Lottery {

    address public manager;    //address of the manager creating the smart contract
    address [] public players;
    constructor ()
    {
          manager=msg.sender;
    }
    function Enter() public payable {
          require(msg.value > .01 ether)   ; 
          //require is used for validation and ether will automatic convert to appropriate amount of wei
         players.push(msg.sender);
    } 

    function pickWinner() public payable onlymanagercancall {
         uint index = random() % players.length;
         payable(players[index]).transfer(address(this).balance);//paying onto the address of the winner index
         players = new address[](0);
    
    }
    modifier onlymanagercancall () //modifiers are used to reduce amount of code which will be likely to repeated 
    {
                        require(msg.sender == manager);
                        _;
    }

    function random() private view returns (uint256){
       return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp , players)));    }

    function getPlayers () public view returns (address[] memory) {
           return players;
    }

}