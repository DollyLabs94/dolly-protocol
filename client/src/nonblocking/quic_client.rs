#[deprecated(
    since = "1.15.0",
    note = "Please use `dolly_quic_client::nonblocking::quic_client::QuicClientConnection` instead."
)]
pub use dolly_quic_client::nonblocking::quic_client::QuicClientConnection as QuicTpuConnection;
pub use dolly_quic_client::nonblocking::quic_client::{
    QuicClient, QuicClientCertificate, QuicLazyInitializedEndpoint,
};
