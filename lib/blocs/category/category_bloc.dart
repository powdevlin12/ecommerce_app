import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ercomerce_app/enum/status_enum.dart';
import 'package:ercomerce_app/models/product/category.model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(const CategoryState()) {
    on<OnUpdateStatusCategory>(_onUpdateStatus);
    on<OnUpdateListCategory>(_onUpdateListCategory);
  }

  Future<void> _onUpdateStatus(
      OnUpdateStatusCategory event, Emitter emit) async {
    StatusState categoryState = event.params.containsKey('categoryState')
        ? event.params['categoryState']
        : state.categoryState;
    emit(state.copyWith(
      status: categoryState,
    ));
  }

  Future<void> _onUpdateListCategory(
      OnUpdateListCategory event, Emitter emit) async {
    List<CategoryModel> listCategory =
        event.params.containsKey('listCategoryArg')
            ? event.params['listCategoryArg']
            : state.listCategory;
    emit(state.copyWith(listCategoryArg: listCategory));
  }
}
