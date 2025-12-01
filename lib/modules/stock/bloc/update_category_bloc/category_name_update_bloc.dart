import 'dart:async';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/models/stock_category_model.dart';
import 'package:local_shout_billing/network/repositories/jobs_sheet_repository.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
part 'category_name_update_event.dart';
part 'category_name_update_state.dart';

class CategoryNameUpdateBloc
    extends Bloc<CategoryNameUpdateEvent, CategoryNameUpdateState> {
  CategoryNameUpdateBloc() : super(const CategoryNameUpdateState()) {
    on<GetCategoryData>(_onGetCategoryData);
    on<UpdateCategoryName>(_onUpdateCategoryName);
    on<AddCategorySparePart>(_onAddCategorySparePart);
  }
  final JobSheetRepository jobSheetRepository = JobSheetRepository();
  FutureOr<void> _onGetCategoryData(
      GetCategoryData event, Emitter<CategoryNameUpdateState> emit) async {
    emit(
      state.copyWith(
        updateCategoryStatus: UpdateCategoryStatus.loading,
        updateCategoryList: StockCatergoryModel.empty,
      ),
    );
    dynamic jwtToken = await app_instance.storage.read(key: "token");

    Map<String, Object> jsonData = {
      "token": jwtToken.toString(),
      "id": event.id.toString()
    };
    final updateDetails =
        await app_instance.jobSheetRepository.getSparePartCategoryById(jsonData);

    if (updateDetails != null && updateDetails.isNotEmpty) {
      emit(
        state.copyWith(
          updateCategoryStatus: UpdateCategoryStatus.success,
          updateCategoryList: StockCatergoryModel.fromJson(updateDetails),
        ),
      );
    } else {
      emit(
        state.copyWith(
          updateCategoryStatus: UpdateCategoryStatus.failure,
          updateCategoryList: StockCatergoryModel.empty,
        ),
      );
    }
  }

  FutureOr<void> _onUpdateCategoryName(
      UpdateCategoryName event, Emitter<CategoryNameUpdateState> emit) async {
    emit(
      state.copyWith(
        updateCategoryStatus: UpdateCategoryStatus.loading,
      ),
    );
    dynamic jwtToken = await app_instance.storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": jwtToken.toString(),
      "formData": jsonEncode(event.formData)
    };
    // Call the repository to update the category name
    dynamic result =
        await app_instance.jobSheetRepository.updateSparePartCategory(
      jsonData,
      event.id.toString(),
    );
    if (result['status'] == "Success") {
      emit(
        state.copyWith(
          updateCategoryStatus: UpdateCategoryStatus.success,
          updateCategoryList: StockCatergoryModel.fromJson(result),
        ),
      );
    } else {
      emit(
        state.copyWith(
          updateCategoryStatus: UpdateCategoryStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _onAddCategorySparePart(
      AddCategorySparePart event, Emitter<CategoryNameUpdateState> emit) async {
    emit(
      state.copyWith(
        addCategoryStatus: AddCategoryStatus.loading,
      ),
    );
    dynamic jwtToken = await app_instance.storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": jwtToken.toString(),
      "formData": jsonEncode(event.formData)
    };
    dynamic result =
        await app_instance.jobSheetRepository.addSparePartCategory(jsonData);
    if (result['status'] == "Success") {
      emit(
        state.copyWith(
          addCategoryStatus: AddCategoryStatus.success,
        ),
      );
    } else {
      emit(
        state.copyWith(
          addCategoryStatus: AddCategoryStatus.failure,
        ),
      );
    }
  }
}
