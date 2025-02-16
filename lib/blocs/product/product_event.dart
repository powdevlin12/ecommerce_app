part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  final Map<String, dynamic> params;
  const ProductEvent({required this.params});

  @override
  List<Object> get props => [params];
}

class OnUpdateStatus extends ProductEvent {
  const OnUpdateStatus({required super.params});
}

class OnUpdateListProduct extends ProductEvent {
  const OnUpdateListProduct({required super.params});
}
