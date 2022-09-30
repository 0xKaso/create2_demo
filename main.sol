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

// 3.工厂合约
// tips: 需要部署
contract Factory {
    uint private counter;

    function create(address MiddlewareAddress) external returns(address base){
        bytes memory bytecode = IMiddleware(MiddlewareAddress).createCode();
        bytes32 salt = keccak256(abi.encodePacked(counter++));

        assembly {
            base := create2(0, add(bytecode, 32), mload(bytecode), salt)
            if iszero(extcodesize(base)) {
                revert(0, 0)
            }
        }

        IBase(base).init();
        counter++;
    }
}

