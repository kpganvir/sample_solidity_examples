// This example code is designed to quickly deploy an example contract using Remix.
//SPDX-License-Identifier: Unlicense
pragma solidity >=0.5.0 <0.9.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
//import "https://github.com/smartcontractkit/chainlink/blob/master/evm-contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

contract PriceConsumerV3 {

         AggregatorV3Interface internal priceFeedJPYUSD;

         AggregatorV3Interface internal priceFeedETHUSD;

    /**
     * Network: Kovan
     * Aggregator: JPY/USD
     * Address: 0x9326BFA02ADD2366b30bacB125260Af641031331
     */
    constructor() public {
        priceFeedJPYUSD = AggregatorV3Interface(0x295b398c95cEB896aFA18F25d0c6431Fd17b1431);
        priceFeedETHUSD = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
    }

    /**
     * Returns the latest price
     */
    function getLatestPriceJPYUSD() public view returns (int) {
        (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = priceFeedJPYUSD.latestRoundData();
        return price;
    }

    function getLatestPriceETHUSD() public view returns (int) {
        (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = priceFeedETHUSD.latestRoundData();
        return price;
    }
}