part of 'category_name_update_bloc.dart';

enum UpdateCategoryStatus {
  initial,
  loading,
  success,
  searching,
  failure,
}

enum AddCategoryStatus {
  initial,
  loading,
  success,
  searching,
  failure,
}

class CategoryNameUpdateState extends Equatable {
  final UpdateCategoryStatus? updateCategoryStatus;
  final StockCatergoryModel updateCategoryList;
  final AddCategoryStatus? addCategoryStatus;

  const CategoryNameUpdateState({
    this.updateCategoryStatus = UpdateCategoryStatus.initial,
    this.updateCategoryList = StockCatergoryModel.empty,
    this.addCategoryStatus = AddCategoryStatus.initial,
  });

  @override
  List<Object> get props => [
        updateCategoryStatus!,
        updateCategoryList,
        addCategoryStatus!,
      ];

  CategoryNameUpdateState copyWith({
    UpdateCategoryStatus? updateCategoryStatus,
    StockCatergoryModel? updateCategoryList,
    AddCategoryStatus? addCategoryStatus,
  }) {
    return CategoryNameUpdateState(
      updateCategoryStatus: updateCategoryStatus ?? this.updateCategoryStatus,
      updateCategoryList: updateCategoryList ?? this.updateCategoryList,
      addCategoryStatus: addCategoryStatus ?? this.addCategoryStatus,
    );
  }
}
