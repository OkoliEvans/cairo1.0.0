    
    use result::ResultTrait;
    use array::ArrayTrait;
    use traits::Into;

    const NAME: felt252 = 'Mock_ERC20';
    const SYMBOL: felt252 = 'MK-2';
    const ACCOUNT: felt252 = 101010;
    

  
    fn __set__up() -> felt252{
        let mut calldata = ArrayTrait::new();
        let initial_supply: u256 = u256 { low: 0, high: 1000000 };
        calldata.append(NAME);
        calldata.append(SYMBOL);
        calldata.append(18);
        calldata.append(initial_supply.high.into());
        calldata.append(initial_supply.low.into());
        calldata.append(ACCOUNT);

        let address = deploy_contract('ERC20', @calldata).unwrap();
        return address;
    }

    #[test]
    fn test_constructor() {
        let deployment_address = __set__up();
        let name = call(deployment_address, 'get_name', @ArrayTrait::new()).unwrap();
        let symbol = call(deployment_address, 'get_symbol', @ArrayTrait::new()).unwrap();
        let total_supply = call(deployment_address, 'get_total_supply', @ArrayTrait::new()).unwrap();
        assert(*name.at(0_u32) == 'Mock_ERC20', 'invalid name');
        assert(*symbol.at(0_u32) == 'MK-2', 'invalid symbol');
        assert(*total_supply.at(0_u32) == 1000000, 'total supply err.');
    }

    #[test]
    fn test_transfer() {
        let deployment_address = __set__up();
        let mut calldata = ArrayTrait::new();
        let amount: u256 = u256 { low: 0, high: 20000 };
        calldata.append(ACCOUNT);
        calldata.append(amount.high.into());
        calldata.append(amount.low.into());

        invoke(deployment_address, 'transfer', @calldata).unwrap();

    }



