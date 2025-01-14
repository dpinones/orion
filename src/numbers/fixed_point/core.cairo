/// A struct representing a fixed point number.
#[derive(Serde, Copy, Drop)]
struct FixedType {
    mag: u32,
    sign: bool
}

/// A struct listing fixed point implementations.
#[derive(Serde, Copy, Drop)]
enum FixedImpl {
    FP8x23: (),
    FP16x16: ()
}

/// Trait
///
/// new - Constructs a new fixed point instance.
/// new_unscaled - Creates a new fixed point instance with the specified unscaled magnitude and sign.
/// from_felt - Creates a new fixed point instance from a felt252 value.
/// abs - Returns the absolute value of the fixed point number.
/// ceil - Returns the smallest integer greater than or equal to the fixed point number.
/// exp - Returns the value of e raised to the power of the fixed point number.
/// exp2 - Returns the value of 2 raised to the power of the fixed point number.
/// floor - Returns the largest integer less than or equal to the fixed point number.
/// ln - Returns the natural logarithm of the fixed point number.
/// log2 - Returns the base-2 logarithm of the fixed point number.
/// log10 - Returns the base-10 logarithm of the fixed point number.
/// pow - Returns the result of raising the fixed point number to the power of another fixed point number.
/// round - Rounds the fixed point number to the nearest whole number.
/// sqrt - Returns the square root of the fixed point number.
/// acos - Returns the  arccosine (inverse of cosine) of the fixed point number.
/// acos_fast - Returns the  arccosine (inverse of cosine) of the fixed point number faster with LUT.
/// asin - Returns the  arcsine (inverse of sine) of the fixed point number.
/// asin_fast - Returns the  arcsine (inverse of sine) of the fixed point number faster with LUT.
/// atan - Returns the arctangent (inverse of tangent) of the input fixed point number.
/// atan_fast - Returns the arctangent (inverse of tangent) of the input fixed point number faster with LUT.
/// cos - Returns the cosine of the fixed point number.
/// cos_fast - Returns the cosine of the fixed point number fast with LUT.
/// sin - Returns the sine of the fixed point number.
/// sin_fast - Returns the sine of the fixed point number faster with LUT.
/// tan - Returns the tangent of the fixed point number.
/// tan_fast - Returns the tangent of the fixed point number faster with LUT.
/// acosh - Returns the value of the inverse hyperbolic cosine of the fixed point number.
/// asinh - Returns the value of the inverse hyperbolic sine of the fixed point number.
/// atanh - Returns the value of the inverse hyperbolic tangent of the fixed point number.
/// cosh - Returns the value of the hyperbolic cosine of the fixed point number.
/// sinh - Returns the value of the hyperbolic sine of the fixed point number.
/// tanh - Returns the value of the hyperbolic tangent of the fixed point number.
/// 
trait FixedTrait {
    /// # FixedTrait::new
    /// 
    /// ```rust
    /// fn new(mag: u32, sign: bool) -> FixedType;
    /// ```
    /// 
    /// Constructs a new fixed point instance.
    ///
    /// ## Args
    /// 
    /// * `mag`(`u32`) - The magnitude of the fixed point.
    /// * `sign`(`bool`) - The sign of the fixed point, where `true` represents a negative number.
    ///
    /// ## Returns
    ///
    /// A new fixed point instance.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    ///
    /// fn new_fp_example() -> FixedType {
    ///     // We can call `new` function as follows. 
    ///     FixedTrait::new(65536, false)
    /// }
    /// >>> {mag: 65536, sign: false} // = 1 in FP16x16
    /// ```
    ///
    fn new(mag: u32, sign: bool) -> FixedType;
    /// # FixedTrait::new\_unscaled
    /// 
    /// ```rust
    ///     fn new_unscaled(mag: u32, sign: bool) -> FixedType;
    /// ```
    ///
    /// Creates a new fixed point instance with the specified unscaled magnitude and sign.
    /// 
    /// ## Args
    ///
    /// `mag`(`u32`) - The unscaled magnitude of the fixed point.
    /// `sign`(`bool`) - The sign of the fixed point, where `true` represents a negative number.
    ///
    /// ## Returns
    /// 
    /// A new fixed point instance.
    /// 
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn new_unscaled_example() -> FixedType {
    ///     // We can call `new_unscaled` function as follows. 
    ///     FixedTrait::new_unscaled(1, false)
    /// }
    /// >>> {mag: 65536, sign: false}
    /// ```
    ///
    fn new_unscaled(mag: u32, sign: bool) -> FixedType;
    /// # FixedTrait::from\_felt
    ///
    /// 
    /// ```rust
    /// fn from_felt(val: felt252) -> FixedType;
    /// ```
    /// 
    /// Creates a new fixed point instance from a felt252 value.
    ///
    /// ## Args
    /// 
    /// * `val`(`felt252`) - `felt252` value to convert in FixedType
    ///
    /// ## Returns 
    ///
    /// A new fixed point instance.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// fn from_felt_example() -> FixedType {
    ///     // We can call `from_felt` function as follows . 
    ///     FixedTrait::from_felt(190054);
    /// }
    /// >>> {mag: 190054, sign: false} // = 2.9
    /// ```
    ///
    fn from_felt(val: felt252) -> FixedType;
    /// # fp.abs
    /// 
    /// ```rust
    /// fn abs(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the absolute value of the fixed point number.
    ///
    /// ## Args
    /// 
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// The absolute value of the input fixed point number.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn abs_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::new_unscaled(1, true);
    /// 
    ///     // We can call `abs` function as follows.
    ///     fp.abs()
    /// }
    /// >>> {mag: 65536, sign: false} // = 1
    /// ```
    /// 
    fn abs(self: FixedType) -> FixedType;
    /// # fp.ceil
    /// 
    /// ```rust
    /// fn ceil(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the smallest integer greater than or equal to the fixed point number.
    ///
    /// ## Args
    ///
    /// *`self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// The smallest integer greater than or equal to the input fixed point number.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn ceil_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::from_felt(190054); // 2.9
    /// 
    ///     // We can call `ceil` function as follows.
    ///     fp.ceil()
    /// }
    /// >>> {mag: 196608, sign: false} // = 3
    /// ```
    ///
    fn ceil(self: FixedType) -> FixedType;
    /// # fp.exp
    /// 
    /// ```rust
    /// fn exp(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the value of e raised to the power of the fixed point number.
    ///
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// The natural exponent of the input fixed point number.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn exp_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::new_unscaled(2, false);
    /// 
    ///     // We can call `exp` function as follows.
    ///     fp.exp()
    /// }
    /// >>> {mag: 484249, sign: false} // = 7.389056317241236
    /// ``` 
    ///
    fn exp(self: FixedType) -> FixedType;
    /// # fp.exp2
    /// 
    /// ```rust
    /// fn exp2(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the value of 2 raised to the power of the fixed point number.
    ///
    /// ## Args
    /// 
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// The binary exponent of the input fixed point number.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn exp2_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::new_unscaled(2, false);
    /// 
    ///     // We can call `exp2` function as follows.
    ///     fp.exp2()
    /// }
    /// >>> {mag: 262143, sign: false} // = 3.99999957248
    /// ``` 
    ///
    fn exp2(self: FixedType) -> FixedType;
    /// # fp.floor
    /// 
    /// ```rust
    /// fn floor(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the largest integer less than or equal to the fixed point number.
    ///
    /// ## Args
    /// 
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// Returns the largest integer less than or equal to the input fixed point number.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn floor_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::from_felt(190054); // 2.9
    /// 
    ///     // We can call `floor` function as follows.
    ///     fp.floor()
    /// }
    /// >>> {mag: 131072, sign: false} // = 2
    /// ```
    /// 
    fn floor(self: FixedType) -> FixedType;
    /// # fp.ln
    ///
    /// 
    /// ```rust
    /// fn ln(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the natural logarithm of the fixed point number.
    /// 
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns 
    ///
    /// A fixed point representing the natural logarithm of the input number.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn ln_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::new_unscaled(1, false);
    /// 
    ///     // We can call `ln` function as follows.
    ///     fp.ln()
    /// }
    /// >>> {mag: 0, sign: false}
    /// ```
    ///
    fn ln(self: FixedType) -> FixedType;
    /// # fp.log2
    /// 
    /// ```rust
    /// fn log2(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the base-2 logarithm of the fixed point number.
    ///
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Panics
    ///
    /// * Panics if the input is negative.
    ///
    /// ## Returns
    ///
    /// A fixed point representing the binary logarithm of the input number.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn log2_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::new_unscaled(3, false);
    /// 
    ///     // We can call `log2` function as follows.
    ///     fp.log2()
    /// }
    /// >>> {mag: 103872, sign: false} // = 1.58496250072
    /// ```
    /// 
    fn log2(self: FixedType) -> FixedType;
    /// # fp.log10
    /// 
    /// ```rust
    /// fn log10(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the base-10 logarithm of the fixed point number.
    ///
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// A fixed point representing the base 10 logarithm of the input number.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn log10_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::new_unscaled(3, false);
    /// 
    ///     // We can call `log10` function as follows.
    ///     fp.log10()
    /// }
    /// >>> {mag: 31269, sign: false} // = 0.47712125472
    /// ```
    ///
    fn log10(self: FixedType) -> FixedType;
    /// # fp.pow
    /// 
    /// ```rust
    /// fn pow(self: FixedType, b: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the result of raising the fixed point number to the power of another fixed point number.
    ///
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point.
    /// * `b`(`FixedType`) - The exponent fixed point number.
    ///
    /// ## Returns
    ///
    /// A fixed point number representing the result of x^y.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn pow_fp_example() -> FixedType {
    ///     // We instantiate FixedTrait points here.
    ///     let a = FixedTrait::new_unscaled(3, false);
    ///     let b = FixedTrait::new_unscaled(4, false);
    /// 
    ///     // We can call `pow` function as follows.
    ///     a.pow(b)
    /// }
    /// >>> {mag: 5308416, sign: false} // = 81
    /// ```
    ///
    fn pow(self: FixedType, b: FixedType) -> FixedType;
    /// # fp.round
    /// 
    /// ```rust
    /// fn round(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Rounds the fixed point number to the nearest whole number.
    ///
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// A fixed point number representing the rounded value.
    ///
    /// ## Examples
    ///
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn round_fp_example() -> FixedType {
    ///     // We instantiate FixedTrait points here.
    ///     let a = FixedTrait::from_felt(190054); // 2.9
    /// 
    ///     // We can call `round` function as follows.
    ///     a.round()
    /// }
    /// >>> {mag: 196608, sign: false} // = 3
    /// ```
    /// 
    fn round(self: FixedType) -> FixedType;
    /// # fp.sqrt
    /// 
    /// ```rust
    /// fn sqrt(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the square root of the fixed point number.
    ///
    /// ## Args
    ///
    /// `self`(`FixedType`) - The input fixed point
    ///
    /// ## Panics
    ///
    /// * Panics if the input is negative.
    ///
    /// ## Returns
    /// 
    /// A fixed point number representing the square root of the input value.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn sqrt_fp_example() -> FixedType {
    ///     // We instantiate FixedTrait points here.
    ///     let a = FixedTrait::new_unscaled(9, false);
    /// 
    ///     // We can call `round` function as follows.
    ///     a.sqrt()
    /// }
    /// >>> {mag: 196608, sign: false} // = 3
    /// ```
    ///
    fn sqrt(self: FixedType) -> FixedType;
    /// # fp.acos
    /// 
    /// ```rust
    /// fn acos(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the  arccosine (inverse of cosine) of the fixed point number.
    ///
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// A fixed point number representing the acos  of the input value.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn acos_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::new_unscaled(1, true);
    /// 
    ///     // We can call `acos` function as follows.
    ///     fp.acos()
    /// }
    /// >>> {mag: 205887, sign: false} // = 3.14159265
    /// ``` 
    ///
    fn acos(self: FixedType) -> FixedType;
    /// # fp.acos_fast
    /// 
    /// ```rust
    /// fn acos_fast(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the  arccosine (inverse of cosine) of the fixed point number faster with LUT.
    ///
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// A fixed point number representing the acos  of the input value.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn acos_fast_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::new_unscaled(1, true);
    /// 
    ///     // We can call `acos_fast` function as follows.
    ///     fp.acos_fast()
    /// }
    /// >>> {mag: 205887, sign: false} // = 3.14159265
    /// ``` 
    ///
    fn acos_fast(self: FixedType) -> FixedType;
    /// # fp.asin
    /// 
    /// ```rust
    /// fn asin(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the  arcsine (inverse of sine) of the fixed point number.
    ///
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// A fixed point number representing the asin of the input value.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn asin_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::new_unscaled(1, false);
    /// 
    ///     // We can call `asin` function as follows.
    ///     fp.asin()
    /// }
    /// >>> {mag: 102943, sign: true} // = 1.57079633
    /// ``` 
    ///
    fn asin(self: FixedType) -> FixedType;
    /// # fp.asin_fast
    /// 
    /// ```rust
    /// fn asin_fast(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the  arcsine (inverse of sine) of the fixed point number faster with LUT.
    ///
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// A fixed point number representing the asin of the input value.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn asin_fast_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::new_unscaled(1, false);
    /// 
    ///     // We can call `asin_fast` function as follows.
    ///     fp.asin_fast()
    /// }
    /// >>> {mag: 102943, sign: true} // = 1.57079633
    /// ``` 
    ///
    fn asin_fast(self: FixedType) -> FixedType;
    /// # fp.atan
    /// 
    /// ```rust
    /// fn atan(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the arctangent (inverse of tangent) of the input fixed point number.
    ///
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// A fixed point number representing the arctangent (inverse of tangent) of the input value.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn atan_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::new_unscaled(2, false);
    /// 
    ///     // We can call `atan` function as follows.
    ///     fp.atan()
    /// }
    /// >>> {mag: 72558, sign: false} // = 1.10714872
    /// ``` 
    ///  
    fn atan(self: FixedType) -> FixedType;
    /// # fp.atan_fast
    /// 
    /// ```rust
    /// fn atan_fast(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the arctangent (inverse of tangent) of the input fixed point number faster with LUT.
    ///
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// A fixed point number representing the arctangent (inverse of tangent) of the input value.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn atan_fast_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::new_unscaled(2, false);
    /// 
    ///     // We can call `atan_fast` function as follows.
    ///     fp.atan_fast()
    /// }
    /// >>> {mag: 72558, sign: false} // = 1.10714872
    /// ``` 
    ///
    fn atan_fast(self: FixedType) -> FixedType;
    /// # fp.cos
    /// 
    /// ```rust
    /// fn cos(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the cosine of the fixed point number.
    ///
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// A fixed point number representing the cosine of the input value.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn cos_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::new_unscaled(2, false);
    /// 
    ///     // We can call `cos` function as follows.
    ///     fp.cos()
    /// }
    /// >>> {mag: 27273, sign: true} // = -0.41614684
    /// ``` 
    ///
    fn cos(self: FixedType) -> FixedType;
    /// # fp.cos_fast
    /// 
    /// ```rust
    /// fn cos_fast(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the cosine of the fixed point number fast with LUT.
    ///
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// A fixed point number representing the cosine of the input value.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn cos_fast_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::new_unscaled(2, false);
    /// 
    ///     // We can call `cos_fast` function as follows.
    ///     fp.cos_fast()
    /// }
    /// >>> {mag: 27273, sign: true} // = -0.41614684
    /// ``` 
    ///
    fn cos_fast(self: FixedType) -> FixedType;
    /// # fp.sin
    /// 
    /// ```rust
    /// fn sin(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the sine of the fixed point number.
    ///
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// A fixed point number representing the sin of the input value.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn sin_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::new_unscaled(2, false);
    /// 
    ///     // We can call `sin` function as follows.
    ///     fp.sin()
    /// }
    /// >>> {mag: 59592, sign: false} // = 0.90929743
    /// ``` 
    ///
    fn sin(self: FixedType) -> FixedType;
    /// # fp.sin_fast
    /// 
    /// ```rust
    /// fn sin_fast(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the sine of the fixed point number faster with LUT.
    ///
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// A fixed point number representing the sin of the input value.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn sin_fast_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::new_unscaled(2, false);
    /// 
    ///     // We can call `sin_fast` function as follows.
    ///     fp.sin_fast()
    /// }
    /// >>> {mag: 59592, sign: false} // = 0.90929743
    /// ``` 
    ///
    fn sin_fast(self: FixedType) -> FixedType;
    /// # fp.tan
    /// 
    /// ```rust
    /// fn tan(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the tangent of the fixed point number.
    ///
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// A fixed point number representing the tan of the input value.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn tan_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::new_unscaled(2, false);
    /// 
    ///     // We can call `tan` function as follows.
    ///     fp.tan()
    /// }
    /// >>> {mag: 143199, sign: true} // = -2.18503986
    /// ``` 
    ///
    fn tan(self: FixedType) -> FixedType;
    /// # fp.tan_fast
    /// 
    /// ```rust
    /// fn tan_fast(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the tangent of the fixed point number faster with LUT.
    ///
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// A fixed point number representing the tan of the input value.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn tan_fast_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::new_unscaled(2, false);
    /// 
    ///     // We can call `tan_fast` function as follows.
    ///     fp.tan_fast()
    /// }
    /// >>> {mag: 143199, sign: true} // = -2.18503986
    /// ``` 
    ///
    fn tan_fast(self: FixedType) -> FixedType;
    /// # fp.acosh
    /// 
    /// ```rust
    /// fn acosh(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the value of the inverse hyperbolic cosine of the fixed point number.
    ///
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// The inverse hyperbolic cosine of the input fixed point number.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn acosh_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::new_unscaled(2, false);
    /// 
    ///     // We can call `acosh` function as follows.
    ///     fp.acosh()
    /// }
    /// >>> {mag: 86308, sign: false} // = 1.3169579
    /// ``` 
    ///
    fn acosh(self: FixedType) -> FixedType;
    /// # fp.asinh
    /// 
    /// ```rust
    /// fn asinh(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the value of the inverse hyperbolic sine of the fixed point number.
    ///
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// The inverse hyperbolic sine of the input fixed point number.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn asinh_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::new_unscaled(2, false);
    /// 
    ///     // We can call `asinh` function as follows.
    ///     fp.asinh()
    /// }
    /// >>> {mag: 94610, sign: false} // = 1.44363548
    /// ``` 
    ///
    fn asinh(self: FixedType) -> FixedType;
    /// # fp.atanh
    /// 
    /// ```rust
    /// fn atanh(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the value of the inverse hyperbolic tangent of the fixed point number.
    ///
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// The inverse hyperbolic tangent of the input fixed point number.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn atanh_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::from_felt(32768); // 0.5
    /// 
    ///     // We can call `atanh` function as follows.
    ///     fp.atanh()
    /// }
    /// >>> {mag: 35999, sign: false} // = 0.54930614
    /// ``` 
    ///
    fn atanh(self: FixedType) -> FixedType;
    /// # fp.cosh
    /// 
    /// ```rust
    /// fn cosh(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the value of the hyperbolic cosine of the fixed point number.
    ///
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// The hyperbolic cosine of the input fixed point number.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn cosh_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::new_unscaled(2, false);
    /// 
    ///     // We can call `cosh` function as follows.
    ///     fp.cosh()
    /// }
    /// >>> {mag: 246559, sign: false} // = 3.76219569
    /// ``` 
    ///
    fn cosh(self: FixedType) -> FixedType;
    /// # fp.sinh
    /// 
    /// ```rust
    /// fn sinh(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the value of the hyperbolic sine of the fixed point number.
    ///
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// The hyperbolic sine of the input fixed point number.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn sinh_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::new_unscaled(2, false);
    /// 
    ///     // We can call `sinh` function as follows.
    ///     fp.sinh()
    /// }
    /// >>> {mag: 237690, sign: false} // = 3.62686041
    /// ``` 
    ///
    fn sinh(self: FixedType) -> FixedType;
    /// # fp.tanh
    /// 
    /// ```rust
    /// fn tanh(self: FixedType) -> FixedType;
    /// ```
    /// 
    /// Returns the value of the hyperbolic tangent of the fixed point number.
    ///
    /// ## Args
    ///
    /// * `self`(`FixedType`) - The input fixed point
    ///
    /// ## Returns
    ///
    /// The hyperbolic tangent of the input fixed point number.
    ///
    /// ## Examples
    /// 
    /// ```rust
    /// use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
    /// use orion::numbers::fixed_point::implementations::fp16x16::core::FP16x16Impl;
    /// 
    /// fn tanh_fp_example() -> FixedType {
    ///     // We instantiate fixed point here.
    ///     let fp = FixedTrait::new_unscaled(2, false);
    /// 
    ///     // We can call `tanh` function as follows.
    ///     fp.tanh()
    /// }
    /// >>> {mag: 63179, sign: false} // = 0.96402758
    /// ``` 
    ///
    fn tanh(self: FixedType) -> FixedType;

    fn ZERO() -> FixedType;
    fn ONE() -> FixedType;
}
