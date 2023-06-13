#[account_contract]
mod HelloAccount {
    use starknet::ContractAddress;
    use core::felt252;
    use array::ArrayTrait;
    use array::SpanTrait;

    #[external]
    fn validate_deploy (
        class_hash: felt252, contract_address_salt: felt252, public_key_: felt252
    ) -> felt252 {
        starknet::VALIDATED
    }

    #[external]
    fn validate_declare(class_hash: felt252) -> felt252 {
        starknet::VALIDATED
    }

    #[external]
    fn validate(
        contract_address: ContractAddress, entry_point_selector: felt252, calldata: Array::<felt252>
    ) -> felt252 {
        starknet::VALIDATED
    }

    #[external]
    #[raw_output]
    fn execute_(
        contract_address: ContractAddress, entry_point_selector: felt252, calldata: Array::<felt252>
    ) -> Span::<felt252> {
        starknet::call_contract_syscall(
            address: contract_address,
            entry_point_selector: entry_point_selector,
            calldata: calldata.span()
        ).unwrap_syscall()
    }


}