part of 'category_name_update_bloc.dart';

sealed class CategoryNameUpdateEvent extends Equatable {
  const CategoryNameUpdateEvent();

  @override
  List<Object> get props => [];
}

class GetCategoryData extends CategoryNameUpdateEvent {
  final String id;
  const GetCategoryData({required this.id});
}

class UpdateCategoryName extends CategoryNameUpdateEvent {
  final Map<String, dynamic>? formData;
  final String id;
  const UpdateCategoryName({required this.id, this.formData});
}

class AddCategorySparePart extends CategoryNameUpdateEvent {
  final Map<String, dynamic>? formData;
  const AddCategorySparePart({this.formData});
}
