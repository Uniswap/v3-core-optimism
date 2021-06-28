// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.7.6;

import '../interfaces/pool/IUniswapV3PoolDerivedState.sol';

contract TestSnapshotCumulativesInside {
    function getGasCostOfSnapshotCumulativesInside(
        address pool,
        int24 tickLower,
        int24 tickUpper
    ) external view returns (uint256) {
        uint256 gasBefore = gasleft();
        IUniswapV3PoolDerivedState(pool).snapshotCumulativesInside(tickLower, tickUpper);
        return gasBefore - gasleft();
    }
}
