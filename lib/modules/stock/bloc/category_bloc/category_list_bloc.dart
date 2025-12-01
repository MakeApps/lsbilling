import 'package:equatable/equatable.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/models/stock_category_model.dart';
import 'package:local_shout_billing/network/repositories/jobs_sheet_repository.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
part 'category_list_event.dart';
part 'category_list_state.dart';

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  CategoryListBloc() : super(const CategoryListState()) {
    on<FetchCategoryList>(_onFetchCategoryList);
  }
  final JobSheetRepository jobSheetRepository = JobSheetRepository();
  Future<void> _onFetchCategoryList(
    FetchCategoryList event,
    Emitter<CategoryListState> emit,
  ) async {
    emit(
      state.copyWith(
        categoryListStatus: (event.status == CategoryListStatus.success)
            ? CategoryListStatus.success
            : CategoryListStatus.loading,
      ),
    );
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, String> jsonData = {
      'token': token.toString(),
      'search': event.searchKeyword ?? "",
    };
    final result = await jobSheetRepository.getSparePartCategory(jsonData);

    if (result != null) {
      if (result is List<dynamic>) {
        final List<dynamic> list = result;
        final items = list
            .map(
              (e) => StockCatergoryModel.fromJson(e as Map<String, dynamic>),
            )
            .toList();
        emit(
          state.copyWith(
            categoryListStatus: CategoryListStatus.success,
            categoryItems: items,
          ),
        );
      } else if (result is Map<String, dynamic>) {
        if (result['status'] == 'Success' &&
            result['message'] == 'No categories found') {
          emit(
            state.copyWith(
              categoryListStatus: CategoryListStatus.success,
              categoryItems: [],
            ),
          );
        } else {
          emit(
            state.copyWith(
              categoryListStatus: CategoryListStatus.failure,
            ),
          );
        }
      }
    } else {
      // Handle null result (e.g., network error)
      emit(
        state.copyWith(
          categoryListStatus: CategoryListStatus.failure,
        ),
      );
    }
  }
}
