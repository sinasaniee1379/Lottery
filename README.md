# Lottery Smart Contract

A decentralized **Lottery Smart Contract** built with **Solidity**, allowing participants to purchase tickets by selecting a number and compete for a share of the prize pool.

The contract manages ticket entries, tracks the total prize pool, selects a winning number, and distributes funds among all participants who selected the winning number.

## 🚀 Features

- **Ticket Purchase:** Users can participate by sending exactly 1 ETH and selecting a number between 0 and 4.
- **Number-Based Entries:** Each ticket is associated with a selected number, and multiple participants can choose the same number.
- **Prize Pool Management:** All ticket payments are accumulated in a shared prize pool.
- **Time-Based Lottery:** The lottery has a predefined end timestamp.
- **Winner Selection:** A random number is generated to determine the winning ticket number.
- **Multiple Winners:** If multiple participants select the winning number, the prize pool is distributed equally among them.
- **Owner Access Control:** Only the contract owner can close the lottery and update its end time.
- **Event Logging:** Important actions, including ticket purchases and prize distribution, emit blockchain events.

## ⚙️ How It Works

1. **Deployment:** The contract owner deploys the lottery with a future end timestamp.
2. **Participation:** Users call `enterLottery()` with a selected number (0–4) and send exactly 1 ETH.
3. **Ticket Registration:** The participant's address is stored in the mapping associated with their selected number.
4. **Lottery Closure:** After the specified end time, the owner calls `closeLottery()`.
5. **Winner Selection:** The contract generates a number based on block-related data and the provided salt.
6. **Prize Distribution:** If participants selected the winning number, the total prize pool is divided equally among them.

## 🛠️ Smart Contract Functions

| Function | Description |
|---|---|
| `constructor(uint256 _endTime)` | Initializes the lottery with an expiration timestamp. |
| `enterLottery(uint256 _number)` | Allows users to purchase a ticket by selecting a number from 0 to 4. |
| `closeLottery(uint256 _randomNumber)` | Closes the lottery and distributes the prize among winners. |
| `randomGenerator(uint256 _salt)` | Generates a number used for winner selection. |
| `updateLotteryEndTime(uint256 _endTime)` | Allows the owner to update the lottery's end timestamp. |

## 📡 Events

- `Entered(address user)` – Emitted whenever a participant successfully enters the lottery.
- `DistributeFunds(address[] Winners, uint WinningAmount)` – Emitted when the lottery distributes the prize among the winners.

## 🔐 Access Control

The contract implements an `onlyOwner` modifier to restrict administrative operations.

Only the deployer can:
- Close the lottery.
- Update the lottery's end timestamp.

## 💻 Technologies

- **Solidity** `^0.8.2`
- **Ethereum Virtual Machine (EVM)**
- **Smart Contracts**
- **Ethereum / EVM-compatible networks**

## ⚠️ Security Considerations & Limitations

This project is an educational implementation of a lottery smart contract and is not intended for production use without further security improvements.

- **Pseudo-Randomness:** The current random number generation mechanism relies on block-related data and a user-provided salt. This approach is not secure against manipulation and should not be used for lotteries involving real funds.
- **Winner Selection:** The current implementation uses a custom number-mapping mechanism that should be reviewed and corrected to ensure the intended probability distribution.
- **Reentrancy Protection:** Fund distribution uses low-level `call`. A reentrancy guard and safer withdrawal-based payment mechanism are recommended.
- **No-Winner Scenario:** If no participant selects the winning number, the prize pool remains in the contract.
- **Administrative Control:** The owner can modify the lottery's end timestamp.

For production deployments, a verifiable randomness solution such as **Chainlink VRF** and additional security mechanisms should be implemented.

## 📄 License

This project is licensed under the **GNU General Public License v3.0 (GPL-3.0)**.

---

**Developed with Solidity and a focus on decentralized application development.**
