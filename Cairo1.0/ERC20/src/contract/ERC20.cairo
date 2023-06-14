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

    #[event]
    fn Transfer(from: ContractAddress, to: ContractAddress, value: u256){}

    #[event]
    fn Approval(owner:ContractAddress, spender:ContractAddress, value:u256){}

    #[constructor]
    fn constructor(
        name_: felt252,
        symbol_: felt252,
        decimal_: u32,
        initial_supply: u256,
        recipient: ContractAddress
    ) {
        name::write(name_);
        symbol::write(symbol_);
        decimal::write(decimal_);
        assert(!recipient.is_zero(), 'Address zero detected');
        total_supply::write(initial_supply);
        balances::write(recipient, initial_supply);
        Transfer(contract_address_const::<0>(), recipient, initial_supply);
    }

    




}
