/*
·▄▄▄▄  ▄▄▄ ..▄▄ · ▄▄▄▄▄▄▄▄  ▄• ▄▌ ▄▄· ▄▄▄▄▄▪         ▐ ▄ 
██▪ ██ ▀▄.▀·▐█ ▀. •██  ▀▄ █·█▪██▌▐█ ▌▪•██  ██ ▪     •█▌▐█
▐█· ▐█▌▐▀▀▪▄▄▀▀▀█▄ ▐█.▪▐▀▀▄ █▌▐█▌██ ▄▄ ▐█.▪▐█· ▄█▀▄ ▐█▐▐▌
██. ██ ▐█▄▄▌▐█▄▪▐█ ▐█▌·▐█•█▌▐█▄█▌▐███▌ ▐█▌·▐█▌▐█▌.▐▌██▐█▌
▀▀▀▀▀•  ▀▀▀  ▀▀▀▀  ▀▀▀ .▀  ▀ ▀▀▀ ·▀▀▀  ▀▀▀ ▀▀▀ ▀█▄▀▪▀▀ █▪
 */

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract DestructionLockerLiquidity is Ownable {
    using SafeERC20 for IERC20;

    uint256 public immutable UNLOCK_END_BLOCK;

    event Claim(IERC20 destructionToken, address to);


    /**
     * @notice Constructs the Destruction contract.
     */
    constructor(uint256 blockNumber) {
        UNLOCK_END_BLOCK = blockNumber;
    }

    /**
     * @notice claimSanManLiquidity
     * claimdestructionToken allows the destruction Team to send destruction Liquidity to the new delirum kingdom.
     * It is only callable once UNLOCK_END_BLOCK has passed.
     * Destruction Liquidity Policy: https://docs.destruction.farm/token-info/destruction-token/liquidity-lock-policy
     */

    function claimSanManLiquidity(IERC20 destructionLiquidity, address to) external onlyOwner {
        require(block.number > UNLOCK_END_BLOCK, "Destruction is still dreaming...");

        destructionLiquidity.safeTransfer(to, destructionLiquidity.balanceOf(address(this)));

        emit Claim(destructionLiquidity, to);
    }
}