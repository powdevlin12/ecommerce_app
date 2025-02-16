part of 'product_bloc.dart';

class ProductState extends Equatable {
  final StatusState productState;
  final List<ProductModel> listProduct;

  const ProductState(
      {this.productState = StatusState.init, this.listProduct = const []});

  @override
  List<Object> get props => [productState, listProduct];

  ProductState copyWith(
      {StatusState? status, List<ProductModel>? listProductArg}) {
    return ProductState(
        productState: status ?? productState,
        listProduct: listProductArg ?? listProduct);
  }
}
