import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ercomerce_app/enum/status_enum.dart';
import 'package:ercomerce_app/models/product/product.model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const ProductState()) {
    on<OnUpdateStatus>(_onUpdateStatus);
    on<OnUpdateListProduct>(_onUpdateListProduct);
  }

  Future<void> _onUpdateStatus(OnUpdateStatus event, Emitter emit) async {
    StatusState productStatus = event.params.containsKey('productStatus')
        ? event.params['productStatus']
        : state.productState;
    emit(state.copyWith(
      status: productStatus,
    ));
  }

  Future<void> _onUpdateListProduct(
      OnUpdateListProduct event, Emitter emit) async {
    List<ProductModel> listProduct = event.params.containsKey('listProduct')
        ? event.params['listProduct']
        : state.listProduct;
    emit(state.copyWith(listProductArg: listProduct));
  }
}
