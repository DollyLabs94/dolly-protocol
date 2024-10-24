#[cfg(not(target_os = "dolly"))]
use thiserror::Error;

#[derive(Error, Clone, Debug, Eq, PartialEq)]
#[cfg(not(target_os = "dolly"))]
pub enum InstructionError {
    #[error("decryption error")]
    Decryption,
    #[error("missing ciphertext")]
    MissingCiphertext,
    #[error("illegal amount bit length")]
    IllegalAmountBitLength,
    #[error("arithmetic overflow")]
    Overflow,
}
