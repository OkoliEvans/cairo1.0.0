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
        total_supply::write(initial_supply);
        assert(!recipient.is_zero(), 'Address zero detected');
        balances::write(recipient, initial_supply);
        Transfer(contract_address_const::<0>(), recipient, initial_supply);
    }

    #[view]
    fn get_name() -> felt252 {
        name::read();
    }

    #[view]
    fn get_symbol() -> felt252 {
        symbol::read();
    }

    #[view]
    fn get_decimal() -> u32 {
        decimal::read();
    }

    #[view]
    fn get_total_supply() -> u256 {
        total_supply::read();
    }

    #[view]
    fn get_balance_of(user: ContractAddress) -> u256 {
        balances::read(user);
    }

    #[view]
    fn allowance(owner: ContractAddress, spender: ContractAddress) -> u256 {
        allowances::read(owner, spender);
    }

    

    





}
