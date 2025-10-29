# 🎴 Gambler Smart Contract

A simple **Ethereum smart contract** that simulates drawing random playing cards on the blockchain.  
Each draw is transparent, recorded on-chain, and linked to the user’s wallet address.

---

## 🧩 Overview

The **Gambler** contract allows users to draw random cards from a standard 52-card deck.  
Each draw generates a **random suit** (Hearts, Diamonds, Clubs, Spades) and a **random value** (Ace to King) using pseudo-randomness derived from blockchain data.

Every card drawn is permanently recorded, including:
- The card’s suit and value
- The timestamp of the draw
- The address of the user who drew it

---

## ⚙️ Features

✅ **Random Card Draws** – Each user can draw a random playing card.  
✅ **On-chain Storage** – All drawn cards are stored and publicly viewable.  
✅ **User History Tracking** – Keeps a record of each user’s draws.  
✅ **Transparency via Events** – Emits an event for every draw for verification.  
✅ **Human-Readable Output** – Provides functions to return readable suit and value names.

---

## 🧠 Smart Contract Details

### Enums
- **`Suit`** → Hearts, Diamonds, Clubs, Spades  
- **`Value`** → Ace through King  

### Struct
```solidity
struct Card {
    Suit suit;
    Value value;
    uint256 timestamp;
    address drawer;
}
````


![WhatsApp Image 2025-10-29 at 13 55 22_de6fcc9d](https://github.com/user-attachments/assets/84331858-ec54-499f-af68-d12df81af97c)




### Key Variables

* `Card[] public drawnCards` – Stores all drawn cards.
* `mapping(address => uint256[]) public userDraws` – Maps each user to their drawn card IDs.

---

## 🔑 Core Functions

| Function                           | Description                                                       |
| ---------------------------------- | ----------------------------------------------------------------- |
| `drawCard()`                       | Draws a new random card and records it on-chain.                  |
| `getCard(uint256 cardId)`          | Returns the suit, value, timestamp, and drawer address of a card. |
| `getTotalDraws()`                  | Returns the total number of cards drawn.                          |
| `getUserDrawHistory(address user)` | Returns the list of card IDs drawn by a user.                     |

---

## 🎲 Randomness

The function `_generateRandom(uint256 mod)` generates pseudo-random numbers using:

```solidity
keccak256(abi.encodePacked(
    block.timestamp,
    block.prevrandao,
    msg.sender,
    drawnCards.length
))
```

> ⚠️ Note: This is **not suitable for high-stakes gambling**, as block data can be partially predicted or influenced by miners.
> For real-world randomness, consider integrating **Chainlink VRF**.

---

## 🧾 Events

```solidity
event CardDrawn(
    address indexed drawer,
    Suit suit,
    Value value,
    uint256 cardId,
    uint256 timestamp
);
```

This event is emitted every time a card is drawn, allowing easy verification via transaction logs.

---

## 🚀 Deployment

### Prerequisites

* [Remix IDE](https://remix.ethereum.org) or Hardhat
* Solidity version `^0.8.0`
* Ethereum-compatible wallet (e.g., MetaMask)

### Steps

1. Compile the contract using Solidity `0.8.x`.
2. Deploy to any EVM-compatible network (e.g., Sepolia, Polygon, BSC testnet).
3. Interact using the public functions listed above.

---

## 🧰 Example Usage

```solidity
// Draw a card
uint256 cardId = gambler.drawCard();

// Fetch card details
(string memory suit, string memory value, uint256 time, address drawer) = gambler.getCard(cardId);
```

---

## 🪪 License

This project is licensed under the **MIT License**.
See the [LICENSE](LICENSE) file for more details.

---

## 👤 Author

**Aayush Thakur**
🧠 Solidity Developer & Blockchain Enthusiast
📧 Contact: *[your email or GitHub profile link]*

---

> 🎴 *"Every draw is luck — every card is on-chain truth."*

```

---

Would you like me to make this README more **GitHub-styled** (with badges, emojis, and better formatting for visuals)?
```
