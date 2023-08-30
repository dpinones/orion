use core::debug::PrintTrait;
use array::ArrayTrait;
use array::SpanTrait;
use option::OptionTrait;

use orion::operators::tensor::implementations::impl_tensor_u32::Tensor_u32;
use orion::operators::tensor::core::{Tensor, TensorTrait, ravel_index};
use orion::operators::tensor::helpers::{reduce_output_shape, combine_indices};


/// Helper function that finds the index of the maximum value in a flat tensor.
///
/// # Arguments
/// * `input` - The input tensor.
/// * `axis` - The axis along which to find the maximum value.
/// * `keepdims` - Whether to keep the reduced dimension or not.
/// * `select_last_index` - Whether to select last occurrence of the max value along the axis.
///
/// # Panics
/// * Panics if gas limit is exceeded during execution.
///
/// # Returns
/// * A usize value representing the index of the maximum value along the specified axis.
fn find_argmax_1D<
    T,
    impl TPartialOrd: PartialOrd<T>,
    impl TPartialEq: PartialEq<T>,
    impl TCopy: Copy<T>,
    impl TDrop: Drop<T>,
>(
    mut input: Tensor<T>, axis: usize, keepdims: bool, select_last_index: bool
) -> Tensor<usize> {
    let mut output_data = ArrayTrait::<usize>::new();

    let mut max = match input.data.pop_front() {
        Option::Some(item) => *item,
        Option::None(_) => {
            return TensorTrait::<usize>::new(
                reduce_output_shape(input.shape, axis, keepdims), output_data.span(), input.extra
            );
        }
    };
    let mut max_index = 0;
    let mut count = 0;

    loop {
        match input.data.pop_front() {
            Option::Some(item) => {
                count += 1;

                if *item > max {
                    max = *item;
                    max_index = count;
                } else {
                    if select_last_index && item == @max {
                        max_index = count;
                    }
                };
            },
            Option::None(_) => {
                break;
            }
        };
    };

    output_data.append(max_index);

    return TensorTrait::<usize>::new(
        reduce_output_shape(input.shape, axis, keepdims), output_data.span(), input.extra
    );
}


/// Recursive helper function that finds the index of the maximum value along a specific axis.
///
/// # Arguments
/// * `input` - The input tensor.
/// * `output_indices` - A span of output indices.
/// * `axis` - The axis along which to find the maximum value.
/// * `axis_index` - The current index along the specified axis.
/// * `max_value` - The current maximum value found along the axis.
/// * `argmax` - The current index of the maximum value along the axis.
/// * `select_last_index` - Whether to select last occurrence of the max value along the axis.
///
/// # Panics
/// * Panics if gas limit is exceeded during execution.
///
/// # Returns
/// * A usize value representing the index of the maximum value along the specified axis.
fn find_argmax<
    T,
    impl TPartialOrd: PartialOrd<T>,
    impl TPartialEq: PartialEq<T>,
    impl TCopy: Copy<T>,
    impl TDrop: Drop<T>,
>(
    input: @Tensor<T>,
    output_indices: Span<usize>,
    axis: usize,
    axis_index: usize,
    max_value: T,
    argmax: usize,
    select_last_index: bool
) -> usize {
    if axis_index == *(*input.shape)[axis] {
        return argmax;
    }

    let input_indices = combine_indices(output_indices, axis_index, axis);
    let input_index = ravel_index(*input.shape, input_indices);
    let ele = *(*input.data)[input_index];

    let (new_max_value, new_argmax) = if ele > max_value {
        (ele, axis_index)
    } else {
        if select_last_index && ele == max_value {
            (ele, axis_index)
        } else {
            (max_value, argmax)
        }
    };

    return find_argmax(
        input,
        output_indices,
        axis,
        axis_index + 1_usize,
        new_max_value,
        new_argmax,
        select_last_index
    );
}
