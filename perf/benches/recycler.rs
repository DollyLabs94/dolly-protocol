#![feature(test)]

extern crate test;

use {
    dolly_perf::{packet::PacketBatchRecycler, recycler::Recycler},
    test::Bencher,
};

#[bench]
fn bench_recycler(bencher: &mut Bencher) {
    dolly_logger::setup();

    let recycler: PacketBatchRecycler = Recycler::default();

    for _ in 0..1000 {
        let _packet = recycler.allocate("");
    }

    bencher.iter(move || {
        let _packet = recycler.allocate("");
    });
}
