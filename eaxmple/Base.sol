// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.17;

// 1.待生成的合约
// tips: 无需部署
contract Base {
    uint public x = 12345;

    function init() external{
        x = 1000;
    }
}

interface IBase {
    function init() external;
}