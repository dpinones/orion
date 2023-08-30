use array::ArrayTrait;
use array::SpanTrait;
use option::OptionTrait;


use orion::operators::tensor::implementations::impl_tensor_u32::Tensor_u32;
use orion::operators::tensor::core::{Tensor, ExtraParams, TensorTrait, };
use orion::operators::tensor::linalg::matmul::helpers::{
    prepare_shape_for_matmul, adjust_output_shape_after_matmul
};

/// Cf: TensorTrait::matmul docstring
fn matmul(self: @Tensor<u32>, other: @Tensor<u32>) -> Tensor<u32> {
    let self_shape = *self.shape;
    let other_shape = *other.shape;
    let self_ndim = (self_shape).len();
    let other_ndim = (other_shape).len();

    assert(self_ndim <= 2 || other_ndim <= 2, 'supports only 1D and 2D matmul');

    //! Case: Both tensors are 1-dimensional
    if self_ndim == 1 && other_ndim == 1 {
        let dot = dot_product((*self).data, (*other).data);
        let mut result_shape = ArrayTrait::new();
        let mut result_data = ArrayTrait::new();
        result_shape.append(1);
        result_data.append(dot);
        return TensorTrait::new(result_shape.span(), result_data.span(), *self.extra);
    }

    let self_shape = prepare_shape_for_matmul(self_shape, true);
    let other_shape = prepare_shape_for_matmul(other_shape, false);

    let result = matrix_multiply(*self.data, self_shape, *other.data, other_shape);

    let result_shape = adjust_output_shape_after_matmul(result.shape, self_ndim, other_ndim);

    return TensorTrait::<u32>::new(result_shape, result.data, *self.extra);
}

/// Computes the dot product of two 1-dimensional u32 tensors.
///
/// # Arguments
/// * `vec1` - A span containing the data elements of the first vector as u32 elements.
/// * `vec2` - A span containing the data elements of the second vector as u32 elements.
///
/// # Panics
/// * Panics if the lengths of the vectors do not match.
/// * Panics if gas limit is exceeded during execution.
///
/// # Returns
/// * An u32 representing the dot product of the two vectors.
fn dot_product(mut vec1: Span<u32>, mut vec2: Span<u32>) -> u32 {
    assert(vec1.len() == vec2.len(), 'vector lengths do not match');

    let mut result: u32 = 0;

    loop {
        match vec1.pop_front() {
            Option::Some(vec1_item) => {
                let element_product = *vec1_item * *vec2.pop_front().unwrap();
                result += element_product;
            },
            Option::None(_) => {
                break;
            }
        };
    };

    return result;
}


/// Computes the matrix multiplication of two 2-dimensional u32 tensors.
///
/// # Arguments
/// * `mat1` - A Span containing the data elements of the first matrix as u32 elements.
/// * `mat1_shape` - A Span containing the shape of the first matrix as usize elements.
/// * `mat2` - A Span containing the data elements of the second matrix as u32 elements.
/// * `mat2_shape` - A Span containing the shape of the second matrix as usize elements.
///
/// # Panics
/// * Panics if the inner dimensions of the matrices do not match.
/// * Panics if gas limit is exceeded during execution.
///
/// # Returns
/// * Returns the restulting u32 tensor.
fn matrix_multiply(
    mat1: Span<u32>, mat1_shape: Span<usize>, mat2: Span<u32>, mat2_shape: Span<usize>
) -> Tensor<u32> {
    let m = *mat1_shape[0];
    let n = *mat1_shape[1];
    let p = *mat2_shape[1];

    let mut result_data = ArrayTrait::new();
    let mut result_shape = ArrayTrait::new();
    result_shape.append(m);
    result_shape.append(p);

    let mut i = 0_usize;
    loop {
        if i == m {
            break ();
        }

        let mut j = 0_usize;
        loop {
            if j == p {
                break ();
            }

            let mut sum: u32 = 0;
            let mut k = 0_usize;
            loop {
                if k == n {
                    break ();
                }

                let mat1_index = i * n + k;
                let mat2_index = k * p + j;
                sum += *mat1[mat1_index] * *mat2[mat2_index];

                k += 1;
            };

            result_data.append(sum);
            j += 1;
        };

        i += 1;
    };

    return TensorTrait::new(result_shape.span(), result_data.span(), Option::None(()));
}
