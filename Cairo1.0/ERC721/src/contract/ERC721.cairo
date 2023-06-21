#[contract]
mod ERC721 {
  use starknet::Zeroable;
  use starknet::get_caller_address;
  use starknet::ContractAddress;

  struct Storage {
    name: felt252,
    symbol: felt252,
    Owner: felt252,
    owners: LegacyMap::< u32, ContractAddress >,
    approvals: LegacyMap::< ContractAddress, u32>,
    balances: LegacyMap::<ContractAddress, u32>,
    tokenUri: LegacyMap::<u32, felt252>
  }

    #[event]
    fn Transfer(from: ContractAddress, to: ContractAddress, tokenId: u32) {}

    #[event]
    fn Approval(owner: ContractAddress, spender: ContractAddress, tokenId: u32){}

    #[constructor]
    fn constructor (
        name_: felt252,
        symbol_: felt252
    ) {
        let owner_ = get_caller_address();
        Owner::write(owner_);
        name::write(name_);
        symbol::write(symbol_);
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
    fn get_owner(tokenId: u32) -> felt252 {
        let owner = owners::read(tokenId);
        owner
    }

    #[external]
    fn set_uri(tokenId: u32, uri: felt252) {
        let owner = get_owner();
        let caller = get_caller_address();
        assert(caller == owner, 'Not authorized');
        tokenUri::write(tokenId, uri);
    }

    #[external]
    fn transfer( to: ContractAddress, tokenId: u32) -> bool {
        let owner = get_caller_address();
        assert(!to.is_zero(), 'ERC721: zero address');
        assert(!owner == to, 'Address parity');
        balances::write(owner, balances::read(owner) - 1);
        balances::write(to, balances::read(to) + 1);
        owners::write(to, tokenId);
        true
    }

    #[external]
    fn mint(to: ContractAddress) {
        
    }


}

