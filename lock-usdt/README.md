# LockUSDT Contract

This is a smart contract written in Solidity for locking and managing USDT (or any ERC-20 token). The contract allows users to deposit their tokens, check their balances, and withdraw their locked tokens.

## Features

- **Deposit USDT:** Users can deposit USDT tokens into the contract.
- **View Pending Balance:** Users can check their locked token balance.
- **Withdraw Tokens:** Users can withdraw their deposited tokens at any time.
- **Support for ERC-20 Tokens:** The contract can be used with any ERC-20 compatible token by passing its address during deployment.

---

## Contract Details

### Prerequisites
- Solidity version: `^0.8.13`
- ERC-20 Token Standard from OpenZeppelin

### Functions
1. **`deposit(uint256 _amount)`**
   - Deposits the specified `_amount` of tokens to the contract.
   - Requires approval for the contract to spend tokens on behalf of the user.

2. **`withdraw()`**
   - Withdraws all tokens locked by the user.

3. **`getPendingBalance(address user)`**
   - Returns the locked balance of the specified user.

---

## Installation

 Clone the repository:
   ```bash
   git clone https://github.com/your-username/lockusdt.git
   cd lockusdt
```
