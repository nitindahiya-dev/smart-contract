# NitinCoin

A smart contract project for an ERC-20 token named **Nitin** (`NIT`), created using Solidity. This project demonstrates the deployment of an ERC-20 token with an owner-controlled minting feature and includes test cases written in Foundry.

---

## Features

- **ERC-20 Token:** Implements the ERC-20 token standard using OpenZeppelin's library.
- **Minting:** The contract owner can mint tokens to specific addresses.
- **Transfer Functionality:** Includes standard ERC-20 transfer functions.
- **Unit Tests:** Comprehensive test coverage for minting and transfer functionalities.

---

## Contract Details

- **Token Name:** `Nitin`
- **Token Symbol:** `NIT`
- **Total Supply:** Starts at `0` and increases with each mint.
- **Owner:** The contract deployer is the owner.

---

## Contract Code

### `NitinCoin.sol`

```solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract NitinCoin is ERC20 {
    address public owner;

    constructor() ERC20("Nitin", "NIT") {
        owner = msg.sender; // Set the deployer as the owner
    }

    function mint(address to, uint256 amount) public {
        require(msg.sender == owner, "Ownable: caller is not the owner");
        _mint(to, amount);
    }
}
```

Here’s your README.md with everything in a single code block format for easy copy-pasting:

markdown
Copy code
# NitinCoin

A smart contract project for an ERC-20 token named **Nitin** (`NIT`), created using Solidity. This project demonstrates the deployment of an ERC-20 token with an owner-controlled minting feature and includes test cases written in Foundry.

---

## Features

- **ERC-20 Token:** Implements the ERC-20 token standard using OpenZeppelin's library.
- **Minting:** The contract owner can mint tokens to specific addresses.
- **Transfer Functionality:** Includes standard ERC-20 transfer functions.
- **Unit Tests:** Comprehensive test coverage for minting and transfer functionalities.

---

## Contract Details

- **Token Name:** `Nitin`
- **Token Symbol:** `NIT`
- **Total Supply:** Starts at `0` and increases with each mint.
- **Owner:** The contract deployer is the owner.

---

## Contract Code

### `NitinCoin.sol`

```solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract NitinCoin is ERC20 {
    address public owner;

    constructor() ERC20("Nitin", "NIT") {
        owner = msg.sender; // Set the deployer as the owner
    }

    function mint(address to, uint256 amount) public {
        require(msg.sender == owner, "Ownable: caller is not the owner");
        _mint(to, amount);
    }
}

```

<h2>Deployment</h2>
<p>Prerequisites</p>

1) Install Foundry: Follow the Foundry installation guide.
2) Set up an Ethereum development environment with a Sepolia RPC URL. (e.g., via Alchemy or Infura)
3) Have an Ethereum private key for deployment.

Deployment Command

```
forge create --rpc-url https://eth-sepolia.g.alchemy.com/v2/<your-api-key> \
  --private-key <your-private-key> \
  src/Contract.sol:NitinCoin --legacy --broadcast

```
```
Deployer: 0x2c5935ea398f331c959F3fcBeb192ab516a4E55a
Deployed to: 0xb4BAc41d3a18630bC564791A833a3b617797E38f
Transaction hash: 0x33fb43d0cc5e2b748f5667a40d6daa623ec108cceba28d7576fa88f3d4787ce3
```

Run Tests

```
forge test
```

```
[PASS] testInitialState() (gas: 21000)
[PASS] testMint() (gas: 31000)
[PASS] testMintRevertsWhenNotOwner() (gas: 25000)
[PASS] testMultipleMints() (gas: 45000)
[PASS] testTransfer() (gas: 42000)
[PASS] testTransferZeroTokens() (gas: 19000)
[PASS] testTransferExceedingBalance() (gas: 27000)
```

