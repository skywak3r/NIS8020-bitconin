pragma solidity ^0.4.0;

//设立一个彩票池子，任何使用者可通过向彩票池子注入定额资金。
//如果一个人注入资金后一段时间没有其他人注入资金，则所有资金自动转给最后注入资金者。
//如果有其他用户注入资金，则游戏继续滚动执行。

contract Pool{
    address  lastPlayer;   //record lastPlayer
    uint timestamp = block.timestamp;
    function addReward(address _player) payable { //add reward to the contract
        this.transfer(msg.value);
        lastPlayer = msg.sender;
    }

    function checkWinner() public view returns(bool){ // check the timestamp
        if(timestamp- block.timestamp > 60){ //Max timeInterval is 1 minutes
            lastPlayer.transfer(this.balance);
            return false;
        }
        else{
            timestamp = block.timestamp;
            return true;
        }
    }
    
    function play(address _player) returns(bool){ //use this function to play
        if (checkWinner()){ // if don't have winner, then add reward.
            addReward(_player);
        }
        else{
            return true;    
        }
    }

    function getBalance()view returns(uint){
        return this.balance;
    }
    
    function ()payable{
    }
}
#git
