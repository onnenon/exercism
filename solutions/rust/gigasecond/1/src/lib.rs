use time::{Duration, PrimitiveDateTime};

pub fn after(start: PrimitiveDateTime) -> PrimitiveDateTime {
    start + Duration::seconds(1_000_000_000)
}
