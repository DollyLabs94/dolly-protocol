#![cfg_attr(RUSTC_WITH_SPECIALIZATION, feature(min_specialization))]

pub mod vote_processor;
pub mod vote_state;
pub mod vote_transaction;

#[macro_use]
extern crate dolly_metrics;

#[macro_use]
extern crate dolly_frozen_abi_macro;

pub use dolly_sdk::vote::{
    authorized_voters, error as vote_error, instruction as vote_instruction,
    program::{check_id, id},
};
