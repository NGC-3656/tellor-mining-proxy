# Tellor Staked Miner Proxy
Implements Chi Gas Token for cheaper submissions.

# Background
The Staked Miner Proxy can be used to submit transactions for a reduced cost by using CHI gas tokens. You will need a "trigger" account which is an Ethereum owned account you use to submit mining solutions to the miner proxy contract.

The normal flow for submitting solutions to Tellor looks like:
```
Staked Wallet -- submitMiningSolution() --> Tellor
```
Here the **Staked Wallet** holds 500 TRB and it send `submitMiningSolution` transactions to the Tellor contract (0x0ba4...).

The Stake Miner Proxy flow looks like this:
```
Trigger Wallet -- submitMiningSolution() --> Stake Miner Proxy --> Tellor
```
The **Trigger Wallet** does not hold any TRB. Instead, the **Stake Miner Proxy** contract has to have 500 TRB staked. The trigger wallet sends `submitMiningSolution` transactions to the proxy and the proxy sends the to Tellor contract.

The 500 TRB stake must be deposited into the proxy contract and then staked, the flow for this looks like:
```
1. Trigger Wallet --Transfers 500 TRB--> Staked Miner Proxy
2. Trigger Wallet --depositStake()--> Staked Miner Proxy --> Tellor
```
The trigger wallet needs to transfer the 500 TRB for staking to the proxy. Then the trigger wallet must call the `depositStake` function on the proxy in order to stake the proxy so it can mine Tellor.


# Usage
Follow these steps to set up a Tellor Staked Miner Proxy:

1. Create a new Ethereum owned account and call it "Trigger Wallet"
2. Deploy this Proxy Contract using the `truffle deploy`
3. After deployment, transfer 500 TRB into the Proxy Contract
4. After the contract balance is 500 TRB, use the Trigger Wallet to execute the `depositStake` method on the Proxy Contract
5. At this point you're staked and can mine, instead of submitting solutions to Tellor's contract, submit them to this Proxy Contract

If you want to have multiple staked miners, you need 1 trigger wallet and 1 proxy contract for each miner you setup
