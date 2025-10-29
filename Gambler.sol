// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Gambler {
    // Card suits and values
    enum Suit { Hearts, Diamonds, Clubs, Spades }
    enum Value { Ace, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King }
    
    struct Card {
        Suit suit;
        Value value;
        uint256 timestamp;
        address drawer;
    }
    
    // Store all drawn cards
    Card[] public drawnCards;
    
    // Mapping to track user's draws
    mapping(address => uint256[]) public userDraws;
    
    // Events for transparency
    event CardDrawn(
        address indexed drawer,
        Suit suit,
        Value value,
        uint256 cardId,
        uint256 timestamp
    );
    
    // Draw a random card
    function drawCard() public returns (uint256) {
        // Generate pseudo-random numbers for suit and value
        uint256 randomSuit = _generateRandom(4);
        uint256 randomValue = _generateRandom(13);
        
        // Create the card
        Card memory newCard = Card({
            suit: Suit(randomSuit),
            value: Value(randomValue),
            timestamp: block.timestamp,
            drawer: msg.sender
        });
        
        // Store the card
        drawnCards.push(newCard);
        uint256 cardId = drawnCards.length - 1;
        
        // Track user's draw
        userDraws[msg.sender].push(cardId);
        
        // Emit event for verification
        emit CardDrawn(
            msg.sender,
            newCard.suit,
            newCard.value,
            cardId,
            block.timestamp
        );
        
        return cardId;
    }
    
    // Internal function to generate pseudo-random number
    function _generateRandom(uint256 mod) private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(
            block.timestamp,
            block.prevrandao,
            msg.sender,
            drawnCards.length
        ))) % mod;
    }
    
    // Get card details
    function getCard(uint256 cardId) public view returns (
        string memory suitName,
        string memory valueName,
        uint256 timestamp,
        address drawer
    ) {
        require(cardId < drawnCards.length, "Card does not exist");
        
        Card memory card = drawnCards[cardId];
        
        return (
            _getSuitName(card.suit),
            _getValueName(card.value),
            card.timestamp,
            card.drawer
        );
    }
    
    // Get total cards drawn
    function getTotalDraws() public view returns (uint256) {
        return drawnCards.length;
    }
    
    // Get user's draw history
    function getUserDrawHistory(address user) public view returns (uint256[] memory) {
        return userDraws[user];
    }
    
    // Helper function to get suit name
    function _getSuitName(Suit suit) private pure returns (string memory) {
        if (suit == Suit.Hearts) return "Hearts";
        if (suit == Suit.Diamonds) return "Diamonds";
        if (suit == Suit.Clubs) return "Clubs";
        return "Spades";
    }
    
    // Helper function to get value name
    function _getValueName(Value value) private pure returns (string memory) {
        if (value == Value.Ace) return "Ace";
        if (value == Value.Two) return "2";
        if (value == Value.Three) return "3";
        if (value == Value.Four) return "4";
        if (value == Value.Five) return "5";
        if (value == Value.Six) return "6";
        if (value == Value.Seven) return "7";
        if (value == Value.Eight) return "8";
        if (value == Value.Nine) return "9";
        if (value == Value.Ten) return "10";
        if (value == Value.Jack) return "Jack";
        if (value == Value.Queen) return "Queen";
        return "King";
    }
}
