#![cfg(feature = "test-bpf")]

use {
    dolly_program_test::*,
    dolly_sbf_rust_remaining_compute_units::process_instruction,
    dolly_sdk::{
        instruction::Instruction, pubkey::Pubkey, signature::Signer, transaction::Transaction,
    },
};

#[tokio::test]
async fn test_remaining_compute_units() {
    let program_id = Pubkey::new_unique();
    let program_test = ProgramTest::new(
        "dolly_sbf_rust_remaining_compute_units",
        program_id,
        processor!(process_instruction),
    );
    let (mut banks_client, payer, recent_blockhash) = program_test.start().await;

    let mut transaction = Transaction::new_with_payer(
        &[Instruction::new_with_bincode(program_id, &(), vec![])],
        Some(&payer.pubkey()),
    );
    transaction.sign(&[&payer], recent_blockhash);
    banks_client.process_transaction(transaction).await.unwrap();
}
