// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

library TestHelpers {
    function generateString(uint256 length) internal pure returns (string memory) {
        bytes memory buffer = new bytes(length);
        for(uint256 i = 0; i < length; i++) {
            buffer[i] = bytes1(uint8(65 + (i % 26)));
        }
        return string(buffer);
    }
}
