# PokerHandUtils

Library of Solidity code to evaluate a 5 card poker hand.
Used as an exercise in non-trivial solidity development.
This is still a work in progress and can definitely be improved, optimized, and bugs may occur.

### Overview

Library for handling of poker hands consisting of cards numbered 0-51
Ace = 0, King = 12 in the suits Clubs, Diamonds, Hearts, Spades

Function: 	evaluateHand takes a list of 5 cards (0-51)

Returns:  	enum of Hand type and up to 5 values of the cards sorted to break ties

Notes: 		State of the art poker hand evals use data tables and hash to run fast.
			For in contract, wanted an old school analytic approach with low memory or external data
			Return list of cards for tie breaker is pretty basic and could be updated easily to a hash value

### Usage

int8[5] memory hand = [ int8(PokerHandUtils.CardId.Six_Clubs), int8(PokerHandUtils.CardId.Three_Clubs), int8(PokerHandUtils.CardId.Jack_Diamonds), int8(PokerHandUtils.CardId.Two_Clubs), int8(PokerHandUtils.CardId.Seven_Clubs)];
PokerHandUtils.HandEnum handVal;
int8[5] memory result;
(handVal, result) = poker.evaluateHand(hand);

Example returns (HandEnum.HighCard, [Jack, Eight, Six, Three, Two])

This project and uses [truffle](https://github.com/trufflesuite/truffle) Ethereum smart contracts development framework. In order to run it, install truffle first:

    npm install -g truffle

### Running tests

To run all of the smart contract tests use following command in your console:

    truffle test

## Contributions

All comments, ideas for improvements and pull requests are welcomed.

## License

MIT License

Copyright (c) 2018 Darwin 3D, LLC. (Jeff Lander jeffl@darwin3d.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.