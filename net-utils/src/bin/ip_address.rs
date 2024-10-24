use clap::{Arg, Command};

fn main() {
    dolly_logger::setup();
    let matches = Command::new("dolly-ip-address")
        .version(dolly_version::version!())
        .arg(
            Arg::new("host_port")
                .index(1)
                .required(true)
                .help("Host:port to connect to"),
        )
        .get_matches();

    let host_port = matches.value_of("host_port").unwrap();
    let addr = dolly_net_utils::parse_host_port(host_port)
        .unwrap_or_else(|_| panic!("failed to parse {host_port}"));

    match dolly_net_utils::get_public_ip_addr(&addr) {
        Ok(ip) => println!("{ip}"),
        Err(err) => {
            eprintln!("{addr}: {err}");
            std::process::exit(1)
        }
    }
}
