//! Example Rust-based SBF noop program

extern crate dolly_program;
use dolly_program::{account_info::AccountInfo, entrypoint::ProgramResult, pubkey::Pubkey};

dolly_program::entrypoint!(process_instruction);
#[allow(clippy::unnecessary_wraps)]
fn process_instruction(
    _program_id: &Pubkey,
    _accounts: &[AccountInfo],
    _instruction_data: &[u8],
) -> ProgramResult {
    Ok(())
}
