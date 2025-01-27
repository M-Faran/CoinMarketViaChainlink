// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Script.sol";
import "../src/CryptoPriceOracle.sol";

contract DeployCryptoPriceOracle is Script {
    function run() external {
        vm.startBroadcast();
        new CryptoPriceOracle();
        vm.stopBroadcast();
    }
}
