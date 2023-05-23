%lang starknet

from starknet.cairo.commom.cairo_builtins import HashBuiltin
from starknet.cairo.commom.hash import hash2
from starknet.cairo.commom.alloc import alloc
from starknet.cairo.commom.math import (assert_le, assert_nn_le, unsigned_div_rem)
from starknet.cairo.commom.syscalls(get_caller_address, storage_read, storage_write)

//@dev the maximum amount of each token that belongs ot the AMM
const BALANCE_UPPER_BOUND = 2 ** 64;

const TOKEN_TYPE_A = 1;
const TOKEN_TYPE_B = 2;

// @dev Ensure user's balance are much smaller than the pool's balance
const POOL_UPPER_HAND = 2 ** 30;
const ACCOUNT_BALANCE_BOUND = 1073741; // (2 ** 30 / 1000)

//STORAGE VARIABLES






















