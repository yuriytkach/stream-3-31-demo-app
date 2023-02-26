# Demo Project for Online Stream #3 and #4 (#31 and #32) - Smart contract deployment into test blockchain
Demo project for online stream #3 and #4 of blockchain course (#31 and #32 of total streams) about using Truffle to compile and deploy smart contracts
to Ganache - a testing in-memory blockchain.
Stream #4 added ability to compile smart-contract and create Java wrappers with web3j library.

## Access to Online Stream on YouTube

To get a link to online stream on YouTube please do the following:

- :moneybag: Make any donation to support my volunteering initiative to help Ukrainian Armed Forces by means described on [my website](https://www.yuriytkach.com/volunteer)
- :email: Write me an [email](mailto:me@yuriytkach.com) indicating donation amount and time
- :tv: I will reply with the link to the stream on YouTube.

Thank you in advance for your support! Слава Україні! :ukraine:

## Running the Demo
Follow the guides provided below to install Truffle with nodejs.

Then compile contracts using:

```shell
truffle compile
```

Then run develop blockchain ganache using:
```shell
truffle develop
```

Inside the truffle prompt run `migrate` command to deploy your smart contracts:

```shell
truffle(develop)> migrate
```

The output should be similar to the following:

```text
Starting migrations...
======================
> Network name:    'develop'
> Network id:      5777
> Block gas limit: 6721975 (0x6691b7)


1_deploy_contracts.js
=====================

   Replacing 'FundraiserFactory'
   -----------------------------
   > transaction hash:    0x990b453dc625e42fe22ffc5be9a590cd17ff69de3534351ba8e4a5c0fcbcd6fd
   > Blocks: 0            Seconds: 0
   > contract address:    0x73270D0B84511cb30dEfAB0AB1AbbBCC91328D42
   > block number:        1
   > block timestamp:     1677408127
   > account:             0x4489287Eb3823d05a1DaF86bD61EF4899588aB99
   > balance:             99.995544085375
   > gas used:            1320271 (0x14254f)
   > gas price:           3.375 gwei
   > value sent:          0 ETH
   > total cost:          0.004455914625 ETH

   > Saving artifacts
   -------------------------------------
   > Total cost:      0.004455914625 ETH

Summary
=======
> Total deployments:   1
> Final cost:          0.004455914625 ETH
```

Take a note of the `contract address` of the `FundraiserFactory` contract. Use it to call method to create `Fundraiser`.
For this use can use the online IDE [Remix](https://remix.ethereum.org/).

### Compile Java Wrappers
To compine Java code wrappers for smart contracts and create jar with them use:

```shell
./gradlew jar
```

### Reference Documentation
For further reference, please consider the following sections:

* [Truffle Installation Guide](https://trufflesuite.com/docs/truffle/how-to/install/)
* [Truffle Quickstart Guide](https://trufflesuite.com/docs/truffle/quickstart/)
* [Truffle Tutorial for Simple DApp](https://trufflesuite.com/guides/pet-shop/)
* [Ganache](https://trufflesuite.com/docs/ganache/)
* [Ethereum Official Documentation](https://ethereum.org/uk/developers/docs/intro-to-ethereum/)
* [Web3j Quickstart](https://docs.web3j.io/4.8.7/quickstart/)
