#[contract]
mod Erc20 {
    use starknet::Zeroable;
    use starknet::get_contract_address;
    use starknet::ContractAddress;
    use starknet::contract_address_const;
    use starknet::contract_address::ContractAddressZeroable;

    struct storage {
        name: felt252,
        symbol: felt252,
        decimal: u32,
        total_supply: u256,
        balances: LegacyMap::<ContractAddress, u256>,
        allowances: LegacyMap::<(ContractAddress,ContractAddress), u256>,
    }

    


}
