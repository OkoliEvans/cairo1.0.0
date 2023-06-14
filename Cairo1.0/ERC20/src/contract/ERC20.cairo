#[contract]
mod Erc20 {
    use starknet::Zeroable;
    use starknet::get_caller_address;
    use starknet::ContractAddress;
    use starknet::contract_address_const;
    use starknet::contract_address::ContractAddressZeroable;

    struct Storage {
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
        name::read()
    }

    #[view]
    fn get_symbol() -> felt252 {
        symbol::read()
    }

    #[view]
    fn get_decimal() -> u32 {
        decimal::read()
    }

    #[view]
    fn get_total_supply() -> u256 {
        total_supply::read()
    }

    #[view]
    fn get_balance_of(user: ContractAddress) -> u256 {
        balances::read(user)
    }

    #[view]
    fn allowance(owner: ContractAddress, spender: ContractAddress) -> u256 {
        allowances::read((owner, spender))
    }

    #[external]
    fn transfer(recipient: ContractAddress, amount: u256) {
        let sender = get_caller_address();
        transfer_helper(sender, recipient, amount);
    }

    #[external]
    fn transfer_from(sender:ContractAddress, recipient:ContractAddress, amount: u256) {
        let caller = get_caller_address();
        spend_allowance(sender, caller, amount);
        transfer_helper(sender, recipient, amount);
    }

    #[external]
    fn approve(spender: ContractAddress, amount: u256) {
        let caller = get_caller_address();
        approve_helper(caller, spender, amount);
    }

    #[external]
    fn increase_allowance(spender:ContractAddress, amount_added: u256) {
        let caller = get_caller_address();
        approve_helper(caller, spender, allowances::read((caller, spender)) + amount_added);
    }

    #[external]
    fn decrease_allowance(spender:ContractAddress, amount_sub: u256) {
        let caller = get_caller_address();
        approve_helper(caller, spender, allowances::read((caller, spender)) - amount_sub);
    }

    fn transfer_helper(sender:ContractAddress, recipient: ContractAddress, amount: u256) {
        assert(!recipient.is_zero(), 'Transfer: recipient is addr 0');
        assert(!sender.is_zero(), 'Transfer: sender is addr 0');
        assert(amount > 0, 'Transfer: amount is 0');
        balances::write(sender, balances::read(sender) - amount );
        balances::write(recipient, balances::read(recipient) + amount );
        Transfer( sender, recipient, amount);
    }

    fn approve_helper(owner: ContractAddress, spender:ContractAddress, amount: u256) {
        assert(!spender.is_zero(), 'Approve: spender is address 0');
        allowances::write((owner, spender), amount);
        Approval(owner, spender, amount);
    }

    fn spend_allowance(owner:ContractAddress, spender:ContractAddress, amount: u256) {
        let current_allowance = allowances::read((owner, spender));
        let ONES_MASK = 0xffffffffffffffffffffffffffffffff_u128;
        let is_unlimited_allowance = current_allowance.low == ONES_MASK & current_allowance.high == ONES_MASK;
        if !is_unlimited_allowance {
            approve_helper(owner, spender, current_allowance - amount);
        }
    }

}
