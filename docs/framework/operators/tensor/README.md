# Tensor

A Tensor represents a multi-dimensional array of elements.

A `Tensor` represents a multi-dimensional array of elements and is depicted as a struct containing both the tensor's shape, a flattened array of its data and extra parameters. The generic Tensor is defined as follows:

```rust
struct Tensor<T> {
    shape: Span<usize>,
    data: Span<T>
    extra: Option<ExtraParams>
}
```

`ExtraParams` is a struct containing additional parameters for the tensor.&#x20;

`fixed_point` extra param indicates the implementation of the fixed point to be used with the tensor, if fixed points are required in certain operations (e.g. `tensor.exp()`).

```rust
struct ExtraParams {
    fixed_point: Option<FixedImpl>
}
```

**ExtraParams**

<table><thead><tr><th width="132">Params</th><th width="211">dtype</th><th width="139">default</th><th>desciption</th></tr></thead><tbody><tr><td>fixed_point</td><td><code>Option&#x3C;FixedImpl></code></td><td><code>FP16x16()</code></td><td>Specifies the type of Fixed Point a Tensor can supports.</td></tr></tbody></table>

### Data types

Orion supports currently these tensor types.

| Data type                 | dtype               |
| ------------------------- | ------------------- |
| 32-bit integer (signed)   | `Tensor<i32>`       |
| 8-bit integer (signed)    | `Tensor<i8>`        |
| 32-bit integer (unsigned) | `Tensor<u32>`       |
| Fixed point (signed)      | `Tensor<FixedType>` |

***

### Tensor**Trait**

```rust
use orion::operators::tensor::core::TensorTrait;
```

`TensorTrait` defines the operations that can be performed on a Tensor.

| function | description |
| --- | --- |
| [`tensor.new`](tensor.new.md) | Returns a new tensor with the given shape and data. |
| [`tensor.reshape`](tensor.reshape.md) | Returns a new tensor with the specified target shape and the same data as the input tensor. |
| [`tensor.flatten`](tensor.flatten.md) | Flattens the input tensor into a 2D tensor. |
| [`tensor.transpose`](tensor.transpose.md) | Returns a new tensor with the axes rearranged according to the given permutation. |
| [`tensor.at`](tensor.at.md) | Retrieves the value at the specified indices of a Tensor. |
| [`tensor.ravel_index`](tensor.ravel\_index.md) | Converts a multi-dimensional index to a one-dimensional index. |
| [`tensor.unravel_index`](tensor.unravel\_index.md) | Converts a one-dimensional index to a multi-dimensional index. |
| [`tensor.equal`](tensor.equal.md) | Check if two tensors are equal element-wise. |
| [`tensor.greater`](tensor.greater.md) | Check if each element of the first tensor is greater than the corresponding element of the second tensor. |
| [`tensor.greater_equal`](tensor.greater\_equal.md) | Check if each element of the first tensor is greater than or equal to the corresponding element of the second tensor. |
| [`tensor.less`](tensor.less.md) | Check if each element of the first tensor is less than the corresponding element of the second tensor. |
| [`tensor.less_equal`](tensor.less\_equal.md) | Check if each element of the first tensor is less than or equal to the corresponding element of the second tensor. |
| [`tensor.or`](tensor.or.md) | Computes the logical OR of two tensors element-wise. |
| [`tensor.xor`](tensor.xor.md) | Computes the logical XOR of two tensors element-wise. |
| [`tensor.stride`](tensor.stride.md) | Computes the stride of each dimension in the tensor. |
| [`tensor.onehot`](tensor.onehot.md) | Produces one-hot tensor based on input. |
| [`tensor.min`](tensor.min.md) | Returns the minimum value in the tensor. |
| [`tensor.max`](tensor.max.md) | Returns the maximum value in the tensor. |
| [`tensor.reduce_sum`](tensor.reduce\_sum.md) | Reduces a tensor by summing its elements along a specified axis. |
| [`tensor.argmax`](tensor.argmax.md) | Returns the index of the maximum value along the specified axis. |
| [`tensor.argmin`](tensor.argmin.md) | Returns the index of the minimum value along the specified axis. |
| [`tensor.cumsum`](tensor.cumsum.md) | Performs cumulative sum of the input elements along the given axis. |
| [`tensor.matmul`](tensor.matmul.md) | Performs matrix product of two tensors. |
| [`tensor.exp`](tensor.exp.md) | Computes the exponential of all elements of the input tensor. |
| [`tensor.log`](tensor.log.md) | Computes the natural log of all elements of the input tensor. |
| [`tensor.abs`](tensor.abs.md) | Computes the absolute value of all elements in the input tensor. |
| [`tensor.ceil`](tensor.ceil.md) | Rounds up the value of each element in the input tensor. |
| [`tensor.sqrt`](tensor.sqrt.md) | Computes the square root of all elements of the input tensor. |
| [`tensor.sin`](tensor.sin.md) | Computes the sine of all elements of the input tensor. |
| [`tensor.cos`](tensor.cos.md) | Computes the cosine of all elements of the input tensor. |
| [`tensor.atan`](tensor.atan.md) | Computes the arctangent (inverse of tangent) of all elements of the input tensor. |
| [`tensor.asin`](tensor.asin.md) | Computes the arcsine (inverse of sine) of all elements of the input tensor. |
| [`tensor.acos`](tensor.acos.md) | Computes the arccosine (inverse of cosine) of all elements of the input tensor. |
| [`tensor.sinh`](tensor.sinh.md) | Computes the hyperbolic sine of all elements of the input tensor. |
| [`tensor.tanh`](tensor.tanh.md) | Computes the hyperbolic tangent of all elements of the input tensor. |
| [`tensor.cosh`](tensor.cosh.md) | Computes the hyperbolic cosine of all elements of the input tensor. |
| [`tensor.asinh`](tensor.asinh.md) | Computes the inverse hyperbolic sine of all elements of the input tensor. |
| [`tensor.acosh`](tensor.acosh.md) | Computes the inverse hyperbolic cosine of all elements of the input tensor. |

### Arithmetic Operations

`Tensor` implements arithmetic traits. This allows you to perform basic arithmetic operations using the associated operators. (`+`, `-`, `*`, `/` ). Tensors arithmetic operations supports broadcasting.

Two tensors are “broadcastable” if the following rules hold:

* Each tensor has at least one dimension.
* When iterating over the dimension sizes, starting at the trailing dimension, the dimension sizes must either be equal, one of them is 1, or one of them does not exist.

#### Examples

Element-wise add.

```rust
use array::{ArrayTrait, SpanTrait};

use orion::operators::tensor::core::{TensorTrait, Tensor, ExtraParams};
use orion::operators::tensor::implementations::impl_tensor_u32::{Tensor_u32, u32TensorAdd};


fn element_wise_add_example() -> Tensor<u32> {
    // We instantiate two 3D Tensors here.
    let tensor_1 = TensorTrait::new(
        shape: array![2, 2, 2].span(),
        data: array![0, 1, 2, 3, 4, 5, 6, 7].span(),
        extra: Option::None(())
    );
    let tensor_2 = TensorTrait::new(
        shape: array![2, 2, 2].span(),
        data: array![0, 1, 2, 3, 4, 5, 6, 7].span(),
        extra: Option::None(())
    );

    // We can add two tensors as follows.
    return tensor_1 + tensor_2;
}
>>> [[[0,2],[4,6]],[[8,10],[12,14]]]
```

Add two tensors of different shapes but compatible in broadcasting.

```rust
use array::{ArrayTrait, SpanTrait};

use orion::operators::tensor::core::{TensorTrait, Tensor, ExtraParams};
use orion::operators::tensor::implementations::impl_tensor_u32::{Tensor_u32, u32TensorAdd};


fn broadcasting_add_example() -> Tensor<u32> {
    // We instantiate two 3D Tensors here.
    let tensor_1 = TensorTrait::new(
        shape: array![2, 2, 2].span(),
        data: array![0, 1, 2, 3, 4, 5, 6, 7].span(),
        extra: Option::None(())
    );
    let tensor_2 = TensorTrait::new(
        shape: array![1, 2, 1].span(),
        data: array![10, 100].span(),
        extra: Option::None(())
    );

    // We can add two tensors as follows.
    return tensor_1 + tensor_2;
}
>>> [[[10,11],[102,103]],[[14,15],[106,107]]]
```