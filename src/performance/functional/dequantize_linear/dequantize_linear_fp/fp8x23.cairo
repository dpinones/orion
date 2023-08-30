use core::traits::Into;
use array::ArrayTrait;
use array::SpanTrait;
use option::OptionTrait;

use orion::numbers::signed_integer::i8::{i8, i8_to_fp8x23};
use orion::numbers::fixed_point::implementations::fp8x23::core::{FP8x23Sub, FP8x23Mul};
use orion::operators::tensor::core::{Tensor, TensorTrait};
use orion::operators::tensor::core::FixedType;
use orion::operators::tensor::implementations::impl_tensor_fp::{
    Tensor_fp, FixedTypeTensorSub, FixedTypeTensorMul
};
use orion::operators::tensor::implementations::impl_tensor_i8::TensorI8IntoTensorFP;
use orion::operators::tensor::helpers::check_compatibility;
use orion::utils::saturate;

/// Cf: PerfomanceTrait::dequantize_linear docstring
fn dequantize_linear(
    x: @Tensor<i8>, x_scale: @Tensor<FixedType>, x_zero_point: @Tensor<FixedType>
) -> Tensor::<FixedType> {
    if (*x_scale.data).len() == 1 && (*x_zero_point.data).len() == 1 {
        dequantize_element_wise(*x, *x_scale.data[0], *x_zero_point.data[0])
    } else {
        check_compatibility(*x.shape, *x_scale.shape);
        check_compatibility(*x.shape, *x_zero_point.shape);
        check_compatibility(*x_scale.shape, *x_zero_point.shape);
        dequantize_per_axis(@(*x).into(), x_scale, x_zero_point)
    }
}

fn dequantize_per_axis(
    x: @Tensor<FixedType>, x_scale: @Tensor<FixedType>, x_zero_point: @Tensor<FixedType>
) -> Tensor::<FixedType> {
    let mut result_data = ArrayTrait::<FixedType>::new();

    (*x - *x_zero_point) * *x_scale
}

fn dequantize_element_wise(
    mut x: Tensor::<i8>, x_scale: FixedType, x_zero_point: FixedType
) -> Tensor::<FixedType> {
    let mut result_data = ArrayTrait::<FixedType>::new();

    loop {
        match x.data.pop_front() {
            Option::Some(item) => {
                let dequantized = dequantize(*item, x_scale, x_zero_point);
                result_data.append(dequantized);
            },
            Option::None(_) => {
                break;
            }
        };
    };

    return TensorTrait::new(x.shape, result_data.span(), x.extra);
}

fn dequantize(x: i8, x_scale: FixedType, x_zero_point: FixedType) -> FixedType {
    (i8_to_fp8x23(x) - x_zero_point) * x_scale
}
