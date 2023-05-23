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
//@dev a map from account and token type to corresponding balance
@storage_var
func account_bal(account_id: felt, token_type: felt) -> (balance: felt) {}

//@dev a map from token type to corr pool balance
@storage_var
func pool_balance(token_type: felt) -> (balance: felt) {}

// GETTER FUNCS
// @dev returns account balance for a given token
// @param account_id Account to be queried
// @param token_type Token to be queried

@view
func get_token_balance{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(account_id: felt, token_type: felt) -> (balance: felt) {
    return account_bal.read(account_id, token_type);
}


//@dev return the pool's balance
//@param token_type To get the pool's balance
@view
func get_token_balance{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(token_type: felt) -> (balance: felt) {
    return pool_balance.read(token_type);
}

//  EXTERNALS
//@dev set pool balance for a given token
//@param token_type Token whose balance is to be set
//@param amount Amount to be set as balance

@external
func set_pool_token_bal{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    token_type: felt, balance: felt
) {
    with_attr error_message("exceeds max allowed tokens") {
    assert_nn_le(balance, BALANCE_UPPER_BOUND - 1);
}
    pool_balance.write(token_type, balance);
    return ();
}





















