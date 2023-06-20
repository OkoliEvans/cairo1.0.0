#[contract]
mod ERC721 {
  use starknet::Zeroable;
  use starknet::get_caller_address;
  use starknet::ContractAddress;

  struct Storage {
    name: felt252,
    symbol: felt252,
    Owner: felt252,
    balances: LegacyMap::< ContractAddress, u128>,
    owners: LegacyMap::< ContractAddress, u32 >,
    approvals: LegacyMap::< ContractAddress, u32>,
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

    


}

