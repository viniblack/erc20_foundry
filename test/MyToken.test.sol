// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "forge-std/Test.sol";
import "../src/MyToken.sol";

contract MyTokenTest is Test {
    MyToken _token;

    // hardhat getSigner() -> vm.addr()
    address _alice = vm.addr(0x1);
    address _bob = vm.addr(0x2);

    // hardhat beforeEach -> setUp
    function setUp() public {
        _token = new MyToken("MyToken", "MTK");
    }

    function testName() external {
        assertEq("MyToken", _token.name());
    }

    function testSymbol() external {
        assertEq("MTK", _token.symbol());
    }

    function testMint() public {
        _token.mint(_alice, 2e18);
        assertEq(_token.totalSupply(), _token.balanceOf(_alice));
    }

    function testBurn() public {
        _token.mint(_alice, 10e18);
        assertEq(_token.balanceOf(_alice), 10e18);

        // startPrank(): Define o msg.sender para todas as chamadas subsequentes até que seja chamado o stopPrank()
        vm.startPrank(_alice);
        _token.approve(_alice, 8e18);
        _token.burnFrom(_alice, 8e18);

        assertEq(_token.totalSupply(), 2e18);
        assertEq(_token.balanceOf(_alice), 2e18);
        vm.stopPrank();
    }

    function testApprove() public {
        assertTrue(_token.approve(_alice, 1e18));
        assertEq(_token.allowance(address(this), _alice), 1e18);
    }

    function testIncreaseAllowance() external {
        assertEq(_token.allowance(address(this), _alice), 0);
        assertTrue(_token.increaseAllowance(_alice, 2e18));
        assertEq(_token.allowance(address(this), _alice), 2e18);
    }

    function testDescreaseAllowance() external {
        testApprove();
        assertTrue(_token.decreaseAllowance(_alice, 0.5e18));
        assertEq(_token.allowance(address(this), _alice), 0.5e18);
    }

    function testTransfer() external {
        testMint();
        vm.startPrank(_alice);
        _token.transfer(_bob, 0.5e18);
        assertEq(_token.balanceOf(_bob), 0.5e18);
        assertEq(_token.balanceOf(_alice), 1.5e18);
        vm.stopPrank();
    }

    function testTransferFrom() external {
        testMint();

        // prank(): Define o msg.sender para a próxima chamada
        vm.prank(_alice);
        _token.approve(address(this), 1e18);
        assertTrue(_token.transferFrom(_alice, _bob, 0.7e18));
        assertEq(_token.allowance(_alice, address(this)), 1e18 - 0.7e18);
        assertEq(_token.balanceOf(_alice), 2e18 - 0.7e18);
        assertEq(_token.balanceOf(_bob), 0.7e18);
    }

    function testFailMintToZero() external {
        _token.mint(address(0), 1e18);
    }

    function testFailBurnFromZero() external {
        _token.burnFrom(address(0), 1e18);
    }

    function testFailBurnInsufficientBalance() external {
        testMint();
        vm.prank(_alice);
        _token.burnFrom(_alice, 3e18);
    }

    function testFailApproveToZeroAddress() external {
        _token.approve(address(0), 1e18);
    }

    function testFailApproveFromZeroAddress() external {
        vm.prank(address(0));
        _token.approve(_alice, 1e18);
    }

    function testFailTransferToZeroAddress() external {
        testMint();
        vm.prank(_alice);
        _token.transfer(address(0), 1e18);
    }

    function testFailTransferFromZeroAddress() external {
        testBurn();
        vm.prank(address(0));
        _token.transfer(_alice, 1e18);
    }

    function testFailTransferInsufficientBalance() external {
        testMint();
        vm.prank(_alice);
        _token.transfer(_bob, 3e18);
    }

    function testFailTransferFromInsufficientApprove() external {
        testMint();
        vm.prank(_alice);
        _token.approve(address(this), 1e18);
        _token.transferFrom(_alice, _bob, 2e18);
    }

    function testFailTransferFromInsufficientBalance() external {
        testMint();
        vm.prank(_alice);
        _token.approve(address(this), type(uint).max);

        _token.transferFrom(_alice, _bob, 3e18);
    }

    /*****************************/
    /*      Fuzz Testing         */
    /*****************************/

    function testFuzzMint(address to, uint256 amount) external {
        vm.assume(to != address(0));
        _token.mint(to, amount);
        assertEq(_token.totalSupply(), _token.balanceOf(to));
    }

    function testFuzzBurn(uint256 mintAmount, uint256 burnAmount) external {
        vm.assume(address(this) != address(0)); // from address must not zero
        burnAmount = bound(burnAmount, 0, mintAmount); // if burnAmount > mintAmount then bound burnAmount to 0 to mintAmount
        _token.mint(address(this), mintAmount);

        _token.approve(address(this), burnAmount);

        _token.burnFrom(address(this), burnAmount);
        assertEq(_token.totalSupply(), mintAmount - burnAmount);
        assertEq(_token.balanceOf(address(this)), mintAmount - burnAmount);
    }

    function testFuzzApprove(address to, uint256 amount) external {
        vm.assume(to != address(0));
        assertTrue(_token.approve(to, amount));
        assertEq(_token.allowance(address(this), to), amount);
    }

    function testFuzzTransfer(address to, uint256 amount) external {
        vm.assume(to != address(0));
        vm.assume(to != address(this));
        _token.mint(address(this), amount);

        assertTrue(_token.transfer(to, amount));
        assertEq(_token.balanceOf(address(this)), 0);
        assertEq(_token.balanceOf(to), amount);
    }

    function testFuzzTransferFrom(
        address from,
        address to,
        uint256 approval,
        uint256 amount
    ) external {
        vm.assume(from != address(0));
        vm.assume(to != address(0));

        amount = bound(amount, 0, approval);
        _token.mint(from, amount);

        vm.prank(from);
        assertTrue(_token.approve(address(this), approval));

        assertTrue(_token.transferFrom(from, to, amount));
        assertEq(_token.totalSupply(), amount);

        if (approval == type(uint256).max) {
            assertEq(_token.allowance(from, address(this)), approval);
        } else {
            assertEq(_token.allowance(from, address(this)), approval - amount);
        }

        if (from == to) {
            assertEq(_token.balanceOf(from), amount);
        } else {
            assertEq(_token.balanceOf(from), 0);
            assertEq(_token.balanceOf(to), amount);
        }
    }

    function testFailFuzzBurnInsufficientBalance(
        address to,
        uint256 mintAmount,
        uint256 burnAmount
    ) external {
        burnAmount = bound(burnAmount, mintAmount + 1, type(uint256).max);

        _token.mint(to, mintAmount);
        _token.burnFrom(to, burnAmount);
    }

    function testFailTransferInsufficientBalance(
        address to,
        uint256 mintAmount,
        uint256 sendAmount
    ) external {
        sendAmount = bound(sendAmount, mintAmount + 1, type(uint256).max);

        _token.mint(address(this), mintAmount);
        _token.transfer(to, sendAmount);
    }

    function testFailFuzzTransferFromInsufficientApprove(
        address from,
        address to,
        uint256 approval,
        uint256 amount
    ) external {
        amount = bound(amount, approval + 1, type(uint256).max);

        _token.mint(from, amount);
        vm.prank(from);
        _token.approve(address(this), approval);
        _token.transferFrom(from, to, amount);
    }

    function testFailFuzzTransferFromInsufficientBalance(
        address from,
        address to,
        uint256 mintAmount,
        uint256 sentAmount
    ) external {
        sentAmount = bound(sentAmount, mintAmount + 1, type(uint256).max);

        _token.mint(from, mintAmount);
        vm.prank(from);
        _token.approve(address(this), type(uint256).max);

        _token.transferFrom(from, to, sentAmount);
    }

    /*****************************/
    /*     Invariant Testing     */
    /*****************************/

    /*****************************/
    /*    Differential Testing   */
    /*****************************/
}
