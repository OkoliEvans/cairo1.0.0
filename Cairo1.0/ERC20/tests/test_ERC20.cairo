#[contract]
mod ERC20_test {
    
    use starknet::ContractAddress;
    use starknet::contract_address_const;

    use Erc20::constructor;
    use Erc20::get_name;
    use Erc20::get_symbol;
    use Erc20::transfer;
    use Erc20::transfer_from;
    use Erc20::approve;
    use Erc20::increase_allowance;
    use Erc20::decrease_allowance;

    const NAME: felt252 = 'Mock_ERC20';
    const SYMBOL: felt252 = 'MK-2';

    #[test]
    #[available_gas(2000000)]
    fn constructor_test() {
        let decimal: u32 = 18_u32;
        let initial_supply: u256 = 1000000;
        let account: ContractAddress = contract_address_const::<1>();

    }

}