use core::option::OptionTrait;
use orion::operators::tensor::core::Tensor;
use orion::operators::nn::core::NNTrait;
use orion::operators::nn::functional::relu::relu_fp::core::relu_fp;
use orion::operators::nn::functional::sigmoid::sigmoid_fp::core::sigmoid_fp;
use orion::operators::nn::functional::softmax::softmax_fp::softmax_fp;
use orion::operators::nn::functional::logsoftmax::logsoftmax_fp::logsoftmax_fp;
use orion::operators::nn::functional::softsign::softsign_fp::core::softsign_fp;
use orion::operators::nn::functional::softplus::softplus_fp::core::softplus_fp;
use orion::operators::nn::functional::linear::linear_fp::linear_fp;
use orion::operators::nn::functional::leaky_relu::leaky_relu_fp::core::leaky_relu_fp;
use orion::numbers::fixed_point::core::FixedType;


impl NN_fp of NNTrait<FixedType> {
    fn relu(tensor: @Tensor<FixedType>) -> Tensor<FixedType> {
        relu_fp(tensor).unwrap()
    }

    fn sigmoid(tensor: @Tensor<FixedType>) -> Tensor<FixedType> {
        sigmoid_fp(tensor).unwrap()
    }

    fn softmax(tensor: @Tensor<FixedType>, axis: usize) -> Tensor<FixedType> {
        softmax_fp(tensor, axis)
    }

    fn logsoftmax(tensor: @Tensor<FixedType>, axis: usize) -> Tensor<FixedType> {
        logsoftmax_fp(tensor, axis)
    }

    fn softsign(tensor: @Tensor<FixedType>) -> Tensor<FixedType> {
        softsign_fp(tensor).unwrap()
    }

    fn softplus(tensor: @Tensor<FixedType>) -> Tensor<FixedType> {
        softplus_fp(tensor).unwrap()
    }

    fn linear(
        inputs: Tensor<FixedType>, weights: Tensor<FixedType>, bias: Tensor<FixedType>
    ) -> Tensor<FixedType> {
        linear_fp(inputs, weights, bias)
    }

    fn leaky_relu(inputs: @Tensor<FixedType>, alpha: @FixedType) -> Tensor<FixedType> {
        leaky_relu_fp(inputs, alpha).unwrap()
    }
}
