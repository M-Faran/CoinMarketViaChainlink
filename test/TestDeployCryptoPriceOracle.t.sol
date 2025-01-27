// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "forge-std/Script.sol";
import "../script/DeployCryptoPriceOracle.s.sol";
import "../src/CryptoPriceOracle.sol";

contract DeployCryptoPriceOracleTest is Test {
    DeployCryptoPriceOracle deployScript;
    CryptoPriceOracle oracle;

    function setUp() public {
        deployScript = new DeployCryptoPriceOracle();
    }

    function testDeployment() public {
        deployScript.run(); // Execute deployment script
    }
}
