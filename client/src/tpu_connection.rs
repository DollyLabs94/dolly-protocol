#[deprecated(
    since = "1.15.0",
    note = "Please use `dolly_connection_cache::client_connection::ClientConnection` instead."
)]
pub use dolly_connection_cache::client_connection::ClientConnection as TpuConnection;
pub use dolly_connection_cache::client_connection::ClientStats;
