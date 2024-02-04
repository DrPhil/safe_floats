//#region Safe float operations
@external(erlang, "js_floats", "multiply")
@external(javascript, "./js_floats.mjs", "multiply")
pub fn multiply(a: GleamFloat, b: GleamFloat) -> GleamFloat

@external(erlang, "js_floats", "divide")
@external(javascript, "./js_floats.mjs", "divide")
pub fn divide(a: GleamFloat, b: GleamFloat) -> GleamFloat

@external(erlang, "js_floats", "add")
@external(javascript, "./js_floats.mjs", "add")
pub fn add(a: GleamFloat, b: GleamFloat) -> GleamFloat

@external(erlang, "js_floats", "subtract")
@external(javascript, "./js_floats.mjs", "subtract")
pub fn subtract(a: GleamFloat, b: GleamFloat) -> GleamFloat

@external(erlang, "js_floats", "absolute_value")
@external(javascript, "./js_floats.mjs", "absolute_value")
pub fn absolute_value(a: GleamFloat) -> GleamFloat
//#endregion

//#region Extract value
@external(erlang, "js_floats", "as_finite")
@external(javascript, "./js_floats.mjs", "as_finite")
pub fn as_finite(a: GleamFloat) -> Result(Float, Nil)

@external(erlang, "js_floats", "is_infinite")
@external(javascript, "./js_floats.mjs", "is_infinite")
pub fn is_infinite(a: GleamFloat) -> Bool

@external(erlang, "js_floats", "is_nan")
@external(javascript, "./js_floats.mjs", "is_nan")
pub fn is_nan(a: GleamFloat) -> Bool
//#endregion

//#region Create values
@external(erlang, "js_floats", "from_finite")
@external(javascript, "./js_floats.mjs", "from_finite")
pub fn from_finite(a: Float) -> GleamFloat

@external(erlang, "js_floats", "infinity")
@external(javascript, "./js_floats.mjs", "infinity")
pub fn infinity() -> GleamFloat

@external(erlang, "js_floats", "negative_infinity")
@external(javascript, "./js_floats.mjs", "negative_infinity")
pub fn negative_infinity() -> GleamFloat
//#endregion

pub type GleamFloat

import gleam/io

pub fn main() {
  let x = from_finite(3.0e100)
  let y = from_finite(2.0e200)

  io.debug(x)
  io.debug(multiply(x, x))
  io.debug(divide(x, y))
  io.debug(multiply(y, y))

  let z = add(x, y)
  io.debug(as_finite(z))
  let w = multiply(z, z)
  io.debug(as_finite(w))
}
