// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "openzeppelin-contracts/token/ERC20/ERC20.sol";

contract FixedRate is ERC20 {
    mapping(address => uint256) public stakedAmounts;

    constructor() ERC20("FixedRateToken", "FRT") {
        _mint(msg.sender, 1000e18);
    }

    function stake(uint _amount) public {
        _transfer(msg.sender, address(this), _amount);
        stakedAmounts[msg.sender] += _amount;
    }

    function unstake() public {

    }

    function claim() public {

    }
}

contract ContractTest is Test {
    FixedRate fixedRate;

    address owner = address(1);
    address alice = address(2);

    uint256 constant public aliceStakeAmount = 1e18;

    function setUp() public {
        vm.startPrank(owner);
        fixedRate = new FixedRate();
        deal(address(fixedRate), address(alice), 1e18);
        vm.stopPrank();
    }

    function testStakingTokensGetTransferedToContract() public {
        vm.startPrank(alice);
        assertEq(fixedRate.balanceOf(address(fixedRate)), 0);
        fixedRate.stake(aliceStakeAmount);
        assertEq(fixedRate.balanceOf(address(fixedRate)), aliceStakeAmount);
    }

    function testFixedRate() public {

        logBalances();

        vm.startPrank(alice);
        fixedRate.stake(1e18);

        logBalances();

    }

    function logBalances() internal {
        console.log("-----------------");
        console.log("balance of owner", fixedRate.balanceOf(address(owner)));
        console.log("balance of alice", fixedRate.balanceOf(address(alice)));
        console.log("balance of staking contract", fixedRate.balanceOf(address(fixedRate)));
        console.log("staked amount alice", fixedRate.stakedAmounts(address(alice)));
        console.log("-----------------");

    }
}