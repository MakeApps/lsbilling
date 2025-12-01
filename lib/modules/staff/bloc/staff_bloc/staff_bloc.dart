import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/models/staff_model.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
part 'staff_event.dart';
part 'staff_state.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  StaffBloc() : super(const StaffState()) {
    on<FetchStaffList>(_onFetchStaffList);
    on<DeleteStaffRecord>(_onDeleteStaffRecord);
    on<CreateStaff>(_onCreateStaff);
  }

  FutureOr<void> _onFetchStaffList(
      FetchStaffList event, Emitter<StaffState> emit) async {
    if (state.hasReachedMax! &&
        event.createStaffStatus == CreateStaffStatus.success) {
      return;
    }
    emit(
      state.copyWith(
        staffStatus: (event.createStaffStatus == CreateStaffStatus.success)
            ? CreateStaffStatus.success
            : CreateStaffStatus.loading,
      ),
    );
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, String> jsonData = {
      'token': token.toString(),
      'direction': 'down',
      'timestamp': event.timestamp.toString(),
      'search': event.searchKeyword ?? "",
    };

    final result = await app_instance.jobSheetRepository.getStaffList(jsonData);

    if (result != null) {
      List<StaffModel> staffListing = result
          .map<StaffModel>(
            (jsonData) => StaffModel.fromJson(jsonData),
          )
          .toList();

      final bool hasReachedMax = staffListing.length < 10;

      if (event.timestamp != null && event.timestamp.toString().isNotEmpty) {
        staffListing = List.from(state.staffList)..addAll(staffListing);
      }
      return emit(
        state.copyWith(
          staffStatus: CreateStaffStatus.success,
          staffList: staffListing,
          hasReachedMax: hasReachedMax,
          lastTimestamp:
              staffListing.isNotEmpty ? staffListing.last.timestamp : null,
        ),
      );
    } else {
      if (event.searchKeyword.toString().isNotEmpty) {
        emit(state.copyWith(
          staffStatus: CreateStaffStatus.failure,
          staffList: [],
          hasReachedMax: true,
        ));
      }
    }
  }

  FutureOr<void> _onDeleteStaffRecord(
      DeleteStaffRecord event, Emitter<StaffState> emit) async {
    emit(
      state.copyWith(staffStatus: CreateStaffStatus.deleting),
    );
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": token.toString(),
      "id": event.id.toString(),
    };
    final result =
        await app_instance.jobSheetRepository.deleteStaffRecord(jsonData);
    if (result['status'] == "Success") {
      emit(
        state.copyWith(
          staffStatus: CreateStaffStatus.delete,
          staffList: state.staffList,
        ),
      );
    }
  }

  // FutureOr<void> _onCreateStaff(
  //     CreateStaff event, Emitter<StaffState> emit) async {
  //   emit(
  //     state.copyWith(staffStatus: CreateStaffStatus.creating),
  //   );
  //   dynamic jwtToken = await app_instance.storage.read(key: "token");
  //   Map<String, Object> jsonData = {
  //     "token": jwtToken.toString(),
  //     "formData": jsonEncode(event.formData),
  //   };
  //   dynamic response =
  //       await app_instance.jobSheetRepository.createAddStaff(jsonData);
  // if (response['status'] == "Success") {
  //   emit(
  //     state.copyWith(staffStatus: CreateStaffStatus.created),
  //   );
  // }
  // }
  FutureOr<void> _onCreateStaff(
    CreateStaff event,
    Emitter<StaffState> emit,
  ) async {
    emit(
      state.copyWith(staffStatus: CreateStaffStatus.creating),
    );

    dynamic jwtToken = await app_instance.storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": jwtToken.toString(),
      "formData": jsonEncode(event.formData),
    };

    dynamic response =
        await app_instance.jobSheetRepository.createAddStaff(jsonData);

    if (response['status'] == "Success") {
      emit(
        state.copyWith(staffStatus: CreateStaffStatus.created),
      );
    } else if (response['status'] == "error") {
      String errorMessage = response['message'] ?? "Something went wrong";
      Map<String, List<String>> fieldErrors = {};

      if (response['args'] != null && response['args'].isNotEmpty) {
        final errors = Map<String, dynamic>.from(response['args'][0]);
        errors.forEach((key, value) {
          fieldErrors[key] = List<String>.from(value);
        });
      }

      emit(
        state.copyWith(
          staffStatus: CreateStaffStatus.error,
          errorMessage: errorMessage,
          fieldErrors: fieldErrors,
        ),
      );
    }
  }
}
