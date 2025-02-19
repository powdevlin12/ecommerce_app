part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final StatusState categoryState;
  final List<CategoryModel> listCategory;

  const CategoryState(
      {this.categoryState = StatusState.init, this.listCategory = const []});

  @override
  List<Object> get props => [categoryState, listCategory];

  CategoryState copyWith(
      {StatusState? status, List<CategoryModel>? listCategoryArg}) {
    return CategoryState(
        categoryState: status ?? categoryState,
        listCategory: listCategoryArg ?? listCategory);
  }
}
