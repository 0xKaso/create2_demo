// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.17;

import "./Base.sol";

// 2.中间件，仅用于生成creationCode用，作为引用Base库的主体
// tips: 需要部署
contract Middleware {
    bytes public createCode;

    constructor() {
        _initCreateCode();
    }

    function _initCreateCode() internal {
        createCode = type(Base).creationCode;
    }
}

// 2.中间件，作为Factory合约调用中间价用
interface IMiddleware{
    function createCode() external view returns(bytes memory);
}