part of 'category_list_bloc.dart';

sealed class CategoryListEvent extends Equatable {
  const CategoryListEvent();

  @override
  List<Object> get props => [];
}

class FetchCategoryList extends CategoryListEvent {
  final CategoryListStatus? status;
  final String? searchKeyword;
  const FetchCategoryList({required this.status, this.searchKeyword});
}
