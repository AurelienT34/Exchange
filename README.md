# Projet de vente de cryptomonnaies 🇫🇷

Ce projet comporte deux parties :

 ## Partie 1 : Plateforme de Vente de Cryptomonnaies DEX (P2P)
 
La première partie de ce projet est une plateforme de vente de cryptomonnaies pair-à-pair (P2P). Elle permet aux utilisateurs d'acheter et de vendre des cryptomonnaies directement entre eux, sans passer par une plateforme d'échange centralisée.

## Fonctionnalités DEX (P2P)

- Connexion au portefeuille MetaMask
- Création d'une vente : Les utilisateurs peuvent créer une vente en spécifiant la cryptomonnaie, le prix et la quantité souhaitée.
- Liste des ventes : Les ventes disponibles sont affichées dans une liste, triées par prix croissant.
- Achat d'une cryptomonnaie : Les utilisateurs peuvent acheter une cryptomonnaie en sélectionnant une vente et en effectuant la transaction correspondante.
- Confirmation de la transaction : Une fois la transaction d'achat effectuée, la vente est confirmée et retirée de la liste des ventes.


## Partie 2 : Plateforme de Vente de Cryptomonnaies CEX

La seconde partie de ce projet est une plateforme centralisée qui propose un graphique montrant l'évolution du prix de l'ETH. Les utilisateurs peuvent ajouter des propositions d'achat et de vente, qui sont ensuite affichées dans le carnet d'ordres. Ces propositions peuvent être tradées en spot, offrant ainsi la possibilité d'acheter ou de vendre de l'ETH en temps réel.

Pour utiliser cette partie de la plateforme, les utilisateurs doivent déposer leurs ETH ou USDT sur le contrat du CEX. Ce dépôt est nécessaire pour pouvoir effectuer des transactions et profiter des fonctionnalités de trading offertes par la plateforme centralisée.

## Fonctionnalités CEX

- Connexion au portefeuille MetaMask
- Gestion du compte (solde ETH et stable coin)
- Ajout de propositions d'achat avec le prix et la quantité souhaités
- Ajout de propositions de vente avec le prix et la quantité souhaités
- Affichage des propositions d'achat et de vente dans le carnet d'ordres
- Affichage d'un graphique en temps réel de l'évolution du prix de l'ETH
- Retrait des ETH et du stable coin sur MetaMask


## Technologies utilisées

- Vue.js : framework JavaScript pour la construction de l'interface utilisateur
- ethers : bibliothèque JavaScript pour interagir avec Ethereum et MetaMask
- Web3.js : bibliothèque JavaScript pour interagir avec Ethereum et MetaMask
- Hardhat : environnement de développement Ethereum pour la compilation, le déploiement et les tests de contrats intelligents
- HTML/CSS : langages de base pour la structure et la présentation de l'application


Assurez-vous d'avoir MetaMask installé et configuré avec un compte Ethereum de test pour effectuer des transactions sur la blockchain.

PI : J'ai utilisé les bibliothèques ethers et web3.js pour observer les similitudes et les différences entre les deux.


# Cryptocurrency Marketplace Project 🏴󠁧󠁢󠁥󠁮󠁧󠁿

This project consists of two parts:

## Part 1: DEX (P2P) Cryptocurrency Trading Platform

The first part of this project is a peer-to-peer (P2P) cryptocurrency trading platform. It allows users to buy and sell cryptocurrencies directly with each other, without the need for a centralized exchange platform.

### DEX (P2P) Features

- MetaMask Wallet Connection
- Sale Creation: Users can create a sale by specifying the cryptocurrency, price, and desired quantity.
- Sale Listings: Available sales are displayed in a list, sorted in ascending order by price.
- Cryptocurrency Purchase: Users can purchase a cryptocurrency by selecting a sale and completing the corresponding transaction.
- Transaction Confirmation: Once the purchase transaction is completed, the sale is confirmed and removed from the list of sales.

## Part 2: CEX Cryptocurrency Trading Platform

The second part of this project is a centralized cryptocurrency trading platform. It features a chart displaying the price evolution of ETH (Ethereum). Users can add buy and sell proposals, which are then displayed in the order book. These proposals can be traded in spot, allowing users to buy or sell ETH in real-time.

To use this part of the platform, users need to deposit their ETH or USDT into the CEX contract. This deposit is necessary to perform transactions and take advantage of the trading features offered by the centralized platform.

### CEX Features

- MetaMask Wallet Connection
- Account Management (ETH and stablecoin balance)
- Addition of buy proposals with desired price and quantity
- Addition of sell proposals with desired price and quantity
- Display of buy and sell proposals in the order book
- Real-time chart showing the price evolution of ETH
- Withdrawal of ETH and stablecoin from MetaMask

## Technologies Used

- Vue.js: JavaScript framework for building the user interface
- ethers: JavaScript library for interacting with Ethereum and MetaMask
- Web3.js: JavaScript library for interacting with Ethereum and MetaMask
- Hardhat: Ethereum development environment for compiling, deploying, and testing smart contracts
- HTML/CSS: Basic languages for structuring and styling the application

Make sure you have MetaMask installed and configured with a test Ethereum account to perform transactions on the blockchain.

Note: I used the ethers and web3.js libraries to observe the similarities and differences between the two.


![image](https://github.com/AurelienT34/Solidity/assets/47206310/dd68fe87-3c39-412b-a9e2-534e9b525cdb)
![image](https://github.com/AurelienT34/Solidity/assets/47206310/c9380c2a-2f32-4049-80e3-8bcf3a21ee29)

# DEX
![image](https://github.com/AurelienT34/Solidity/assets/47206310/0992e850-d7ba-4983-8235-8e9c2135d500)

## Project Setup

```sh
npm install
```

### Compile and Hot-Reload for Development

```sh
npm run dev
```

### Compile and Minify for Production

```sh
npm run build
```

### Hardhat node

```sh
npx hardhat node
```
### hardhat compile contracts

```sh
npx hardhat compile
```

### Hardhat deploy on localhost

```sh
npx hardhat run scripts/deploy.js --network localhost
```
