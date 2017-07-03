pragma solidity ^0.4.4;

/**
 *
 */
contract Lottery {

  // constant: Participant MUST pay 100 wei to participate
  uint  constant  AMOUNT = 100;
  // Percentage kept in the contract as commision
  uint  constant  COMM_PCT = 10;

  // struct for managing the participants
  struct Participant {
    address participantAddress;
    bytes32 participantName;
  }
  // List of participants
  Participant[] participants;

  // Owner address
  address   owner;

  // Winner paid off
  bool  winnerPaid = false;
  uint  winnerIndex;

  // Restricts execution by owner only
  modifier  ownerOnly {
    if(msg.sender == owner){
      _;
    } else {
      throw;
    }
  }

  function Lottery(){
    owner = msg.sender;
  }

  /**
   * Participants pay to this function
   * Participant can pay multiple times
   **/
  function  participate(bytes32 name) payable {
    if(msg.value != AMOUNT) throw;
    Participant memory part = Participant({participantAddress: msg.sender, participantName: name});
    participants.push(part);
  }

  // Return the count of participants
  function  getParticipantCount() returns(uint) {
    return  participants.length;
  }

  /**
   * Externally trigerred draw function
   **/
  function  drawLottery()  ownerOnly {
    // If lottery withdrawn then just throw
    if(winnerPaid) throw;

    if(participants.length == 0) throw;

    // Generate the random number
    winnerIndex = rand();

    // send the ethers to winner
    // In real implementation - use withdrawal pattern

    // send all ethers to winer

    winnerPaid = true;
  }

  function getWinnerName() returns(bytes32) {
    if(!winnerPaid) throw;

    return participants[winnerIndex].participantName;
  }

  /**
   * Generates a pseudo-random number 
   * Ideally this function should be private
   **/
  function  rand() returns(uint num){
    uint min = 0 ;
    uint max = participants.length - 1;
    bytes32  seed = block.blockhash(block.number - 3);
    num = (uint(sha3(seed)) % (min+max)) - min;
  }
}
