// TestPokerUtils 
// 
// 
// Tests out various things dealing with 
//
pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/PokerHandUtils.sol";

contract TestPokerUtils {
  PokerHandUtils poker = PokerHandUtils(DeployedAddresses.PokerHandUtils());

    // Testing getCardName function
	function testGetCardName() public {
  	  PokerHandUtils.CardValue cardVal;
  	  PokerHandUtils.CardSuit cardSuit;
	  (cardVal, cardSuit) = poker.getCardName(int8(PokerHandUtils.CardId.Queen_Clubs));
	  Assert.equal(int(cardVal), int(PokerHandUtils.CardValue.Queen), "Should be Queen.");
	  Assert.equal(int(cardSuit), int(PokerHandUtils.CardSuit.Clubs), "Should be Clubs.");
	}
	

    // Testing HandEval function
	function testHandEval() public {
	  int8[5] memory hand = [ int8(PokerHandUtils.CardId.Six_Clubs), int8(PokerHandUtils.CardId.Three_Clubs), int8(PokerHandUtils.CardId.Jack_Diamonds), int8(PokerHandUtils.CardId.Two_Clubs), int8(PokerHandUtils.CardId.Seven_Clubs)];
	  PokerHandUtils.HandEnum handVal;
	  int8[5] memory result;
	  (handVal, result) = poker.evaluateHand(hand);
	  Assert.equal(int(handVal), int(PokerHandUtils.HandEnum.HighCard), "Should be a high card.");
	  Assert.equal(result[0], int(PokerHandUtils.CardValue.Jack), "HighCard Top should be a Jack.");
	  Assert.equal(result[1], int(PokerHandUtils.CardValue.Seven), "HighCard Kicker should be a 7.");
	  Assert.equal(result[2], int(PokerHandUtils.CardValue.Six), "HighCard Kicker2 should be a 6.");
	  Assert.equal(result[3], int(PokerHandUtils.CardValue.Three), "HighCard Kicker3 should be a 3.");
	  Assert.equal(result[4], int(PokerHandUtils.CardValue.Two), "HighCard Kicker4 should be a 2.");

	  // Check four of a kind
	  hand = [ int8(PokerHandUtils.CardId.Four_Clubs), int8(PokerHandUtils.CardId.Four_Diamonds), int8(PokerHandUtils.CardId.Seven_Hearts), int8(PokerHandUtils.CardId.Four_Spades), int8(PokerHandUtils.CardId.Four_Hearts)];
	  (handVal, result) = poker.evaluateHand(hand);
	  Assert.equal(int(handVal), int(PokerHandUtils.HandEnum.FourOfAKind), "Should be a four of a kind.");
	  Assert.equal(result[0], int(PokerHandUtils.CardValue.Four), "FourOfAKind Top should be a 4.");
	  Assert.equal(result[1], int(PokerHandUtils.CardValue.Seven), "FourOfAKind Kicker should be a 7.");

	  // Check royal flush true
	  hand = [ int8(PokerHandUtils.CardId.Ace_Diamonds), int8(PokerHandUtils.CardId.King_Diamonds), int8(PokerHandUtils.CardId.Jack_Diamonds), int8(PokerHandUtils.CardId.Ten_Diamonds), int8(PokerHandUtils.CardId.Queen_Diamonds)];
	  (handVal, result) = poker.evaluateHand(hand);
	  Assert.equal(int(handVal), int(PokerHandUtils.HandEnum.RoyalFlush), "Should be a royal flush.");
	  Assert.equal(result[0], int(PokerHandUtils.CardValue.Ace_High), "Top should be a Ace.");
	  Assert.equal(result[1], int(PokerHandUtils.CardValue.King), "Kicker should be a 12.");

	  // Check straight flush true
	  hand = [ int8(17), 20, 18, 19, 21];
	  (handVal, result) = poker.evaluateHand(hand);
	  Assert.equal(int(handVal), int(PokerHandUtils.HandEnum.StraightFlush), "Should be a straight flush.");
	  Assert.equal(result[0], int(8), "StraightFlush Top should be a 8.");
	  Assert.equal(result[1], int(7), "StraightFlush Kicker should be a 7.");

	  // Check flush true
	  hand = [ int8(2), 4, 9, 7, 5];
	  (handVal, result) = poker.evaluateHand(hand);
	  Assert.equal(int(handVal), int(PokerHandUtils.HandEnum.Flush), "Should be a flush.");
	  Assert.equal(result[0], int(9), "Flush Top should be a 9.");
	  Assert.equal(result[1], int(7), "Flush Kicker should be a 7.");

	  // Check ace high flush true
	  hand = [ int8(0), 4, 9, 7, 5];
	  (handVal, result) = poker.evaluateHand(hand);
	  Assert.equal(int(handVal), int(PokerHandUtils.HandEnum.Flush), "Should be a flush.");
	  Assert.equal(result[0], int(13), "Flush Top should be a 13.");
	  Assert.equal(result[1], int(9), "Flush Kicker should be a 9.");

	  // Check full house true
	  hand = [ int8(20), 16, 7, 42, 29];
	  (handVal, result) = poker.evaluateHand(hand);
	  Assert.equal(int(handVal), int(PokerHandUtils.HandEnum.FullHouse), "Should be a FullHouse.");
	  Assert.equal(result[0], int(3), "FullHouse Top should be a 3.");
	  Assert.equal(result[1], int(7), "FullHouse Kicker should be a 7.");

	  // Check full house true with aces
	  hand = [ int8(20), 0, 7, 13, 26];
	  (handVal, result) = poker.evaluateHand(hand);
	  Assert.equal(int(handVal), int(PokerHandUtils.HandEnum.FullHouse), "Should be a FullHouse.");
	  Assert.equal(result[0], int(13), "FullHouse Top should be a 13.");
	  Assert.equal(result[1], int(7), "FullHouse Kicker should be a 7.");

	  // Check straight true
	  hand = [ int8(5), 9, 7, 8, 19];
	  (handVal, result) = poker.evaluateHand(hand);
	  Assert.equal(int(handVal), int(PokerHandUtils.HandEnum.Straight), "Should be a Straight.");
	  Assert.equal(result[0], int(9), "Straight Top should be a 9.");
	  Assert.equal(result[1], int(8), "Straight Kicker should be a 8.");

	  // Check straight ace high true
	  hand = [ int8(25), 9, 23, 0, 11];
	  (handVal, result) = poker.evaluateHand(hand);
	  Assert.equal(int(handVal), int(PokerHandUtils.HandEnum.Straight), "Should be a Straight Ace High.");
	  Assert.equal(result[0], int(13), "Straight Ace High Top should be a 13.");
	  Assert.equal(result[1], int(12), "Straight Ace High Kicker should be a 12.");

	  // Check straight ace low true
	  hand = [ int8(4), 1, 16, 0, 2];
	  (handVal, result) = poker.evaluateHand(hand);
	  Assert.equal(int(handVal), int(PokerHandUtils.HandEnum.Straight), "Should be a Straight Ace Low.");
	  Assert.equal(result[0], int(4), "Straight Ace Low Top should be a 4.");
	  Assert.equal(result[1], int(3), "Straight Ace Low Kicker should be a 3.");

	  // Check three of a kind
	  hand = [ int8(3), 16, 7, 42, 9];
	  (handVal, result) = poker.evaluateHand(hand);
	  Assert.equal(int(handVal), int(PokerHandUtils.HandEnum.ThreeOfAKind), "Should be a three of a kind.");
	  Assert.equal(result[0], int(3), "ThreeOfAKind Top should be a 3.");
	  Assert.equal(result[1], int(9), "ThreeOfAKind Kicker should be a 9.");

	  // Check two pair
	  hand = [ int8(3), 16, 7, 20, 9];
	  (handVal, result) = poker.evaluateHand(hand);
	  Assert.equal(int(handVal), int(PokerHandUtils.HandEnum.TwoPair), "Should be two pair.");
	  Assert.equal(result[0], int(7), "TwoPair Top should be a 7.");
	  Assert.equal(result[1], int(3), "TwoPair Kicker should be a 3.");
	  Assert.equal(result[2], int(9), "TwoPair Kicker2 should be a 9.");

	  // Check pair
	  hand = [ int8(3), 14, 7, 20, 9];
	  (handVal, result) = poker.evaluateHand(hand);
	  Assert.equal(int(handVal), int(PokerHandUtils.HandEnum.Pair), "Should be a pair.");
	  Assert.equal(result[0], int(7), "Pair Top should be a 7.");
	  Assert.equal(result[1], int(9), "Pair Kicker should be a 9.");
	  Assert.equal(result[2], int(3), "Pair Kicker2 should be a 3.");
	  Assert.equal(result[3], int(1), "Pair Kicker3 should be a 1.");
	}
}