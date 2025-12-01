part of 'category_list_bloc.dart';

enum CategoryListStatus {
  initial,
  loading,
  success,
  searching,
  failure,
}

class CategoryListState extends Equatable {
  final CategoryListStatus? categoryListStatus;
  final List<StockCatergoryModel> categoryItems;

  const CategoryListState({
    this.categoryListStatus = CategoryListStatus.initial,
    this.categoryItems = const <StockCatergoryModel>[],
  });

  @override
  List<Object> get props => [
        categoryListStatus!,
        categoryItems,
      ];

  CategoryListState copyWith({
    CategoryListStatus? categoryListStatus,
    List<StockCatergoryModel>? categoryItems,
  }) {
    return CategoryListState(
      categoryListStatus: categoryListStatus ?? this.categoryListStatus,
      categoryItems: categoryItems ?? this.categoryItems,
    );
  }
}
