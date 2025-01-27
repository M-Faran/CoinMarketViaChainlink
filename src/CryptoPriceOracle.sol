// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract CryptoPriceOracle {
    // Mapping of token names to their Chainlink price feed addresses
    mapping(string => address) private priceFeeds;

    constructor() {
        // Initialize Chainlink price feed addresses (update as needed)
        priceFeeds["ETH/USD"] = 0x694AA1769357215DE4FAC081bf1f309aDC325306; // Sepolia ETH/USD
        priceFeeds["BTC/USD"] = 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43; // Sepolia BTC/USD
        priceFeeds["LINK/USD"] = 0xc59E3633BAAC79493d908e63626716e204A45EdF; // Sepolia LINK/USD
    }

    function getLatestPrice(string memory _asset) public view returns (int256) {
        require(priceFeeds[_asset] != address(0), "Price feed not available");

        AggregatorV3Interface priceFeed = AggregatorV3Interface(priceFeeds[_asset]);
        (, int256 price,,,) = priceFeed.latestRoundData();

        return price;
    }

    // Getter function to retrieve the price feed address for a given asset
    function getPriceFeed(string memory _asset) public view returns (address) {
        return priceFeeds[_asset];
    }
}
