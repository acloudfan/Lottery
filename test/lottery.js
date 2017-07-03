var Lottery = artifacts.require("./Lottery.sol");

contract('lottery', function(accounts) {

  it("should assert true", function() {

    var lottery;
    return Lottery.deployed().then(function(result){
      lottery = result;
      return lottery.rand.call();
    }).then(function(result){
      // Test for randomness
      console.log("Random number test :", result.toNumber());
      // Now send some weis
      lottery.participate("one", {from: accounts[1], value: 100})
      lottery.participate("two", {from: accounts[2], value: 100})
      lottery.participate("three", {from: accounts[3], value: 100})
      lottery.participate("four", {from: accounts[3], value: 100})
      lottery.participate("five", {from: accounts[3], value: 100})

      lottery.drawLottery();

     return lottery.getWinnerName.call();

    }).then(function(result){
      console.log(web3.toAscii(result));
    })
  });
});
