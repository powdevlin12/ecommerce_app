part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  final Map<String, dynamic> params;
  const CategoryEvent({required this.params});

  @override
  List<Object> get props => [params];
}

class OnUpdateStatusCategory extends CategoryEvent {
  const OnUpdateStatusCategory({required super.params});
}

class OnUpdateListCategory extends CategoryEvent {
  const OnUpdateListCategory({required super.params});
}
