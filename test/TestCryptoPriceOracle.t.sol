// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "../src/CryptoPriceOracle.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract CryptoPriceOracleTest is Test {
    CryptoPriceOracle oracle;

    // Sepolia Chainlink price feed addresses (mocked for testing)
    address constant ETH_USD_FEED = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
    address constant BTC_USD_FEED = 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43;
    address constant LINK_USD_FEED = 0xc59E3633BAAC79493d908e63626716e204A45EdF;

    function setUp() public {
        oracle = new CryptoPriceOracle(); // Deploy contract

        // Mock the Chainlink `latestRoundData()` response for ETH/USD
        vm.mockCall(
            ETH_USD_FEED, // Target contract (Chainlink aggregator)
            abi.encodeWithSelector(AggregatorV3Interface.latestRoundData.selector),
            abi.encode(0, 2000 * 1e8, 0, 0, 0) // Mock return data: (roundId, price, startedAt, updatedAt, answeredInRound)
        );

        // Mock the Chainlink `latestRoundData()` response for BTC/USD
        vm.mockCall(
            BTC_USD_FEED,
            abi.encodeWithSelector(AggregatorV3Interface.latestRoundData.selector),
            abi.encode(0, 40000 * 1e8, 0, 0, 0)
        );

        // Mock the Chainlink `latestRoundData()` response for LINK/USD
        vm.mockCall(
            LINK_USD_FEED,
            abi.encodeWithSelector(AggregatorV3Interface.latestRoundData.selector),
            abi.encode(0, 15 * 1e8, 0, 0, 0)
        );
    }

    function testPriceFeedInitialization() public view {
        // Check that the price feeds were set correctly
        assertEq(address(oracle.getPriceFeed("ETH/USD")), ETH_USD_FEED);
        assertEq(address(oracle.getPriceFeed("BTC/USD")), BTC_USD_FEED);
        assertEq(address(oracle.getPriceFeed("LINK/USD")), LINK_USD_FEED);
    }

    function testMockedGetLatestPrice_ETH() public view {
        int256 price = oracle.getLatestPrice("ETH/USD");
        assertEq(price, 2000 * 1e8); // Ensure mocked value is returned
    }

    function testMockedGetLatestPrice_BTC() public view {
        int256 price = oracle.getLatestPrice("BTC/USD");
        assertEq(price, 40000 * 1e8);
    }

    function testMockedGetLatestPrice_LINK() public view {
        int256 price = oracle.getLatestPrice("LINK/USD");
        assertEq(price, 15 * 1e8);
    }

    function testGetLatestPriceInvalidAsset() public {
        vm.expectRevert("Price feed not available");
        oracle.getLatestPrice("DOGE/USD");
    }
}
