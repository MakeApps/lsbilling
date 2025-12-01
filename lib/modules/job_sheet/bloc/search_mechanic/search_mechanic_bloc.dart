import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/models/mechanic_model.dart';
import 'package:local_shout_billing/config.dart' as app_instance;

part 'search_mechanic_event.dart';
part 'search_mechanic_state.dart';

class SearchMechanicBloc
    extends Bloc<SearchMechanicEvent, SearchMechanicState> {
  SearchMechanicBloc() : super(SearchMechanicState()) {
    on<SearchMechanic>(_onSearchMechanic);
  }

  // _onSearchMechanic(
  //     SearchMechanic event, Emitter<SearchMechanicState> emit) async {
  //   dynamic token = await app_instance.storage.read(key: "token");
  //   Map<String, Object> jsonData = {
  //     "token": token.toString(),
  //     "search": event.searchKeyword.toString()
  //   };
  //   final result =
  //       await app_instance.jobSheetRepository.searchMechanic(jsonData);
  //   if (result != null && result.isNotEmpty) {
  //     return emit(
  //       state.copyWith(
  //         status: MechanicStatus.success,
  //         mechanicList: result
  //             .map<MechanicModel>(
  //               (jsonData) => MechanicModel.fromJson(jsonData),
  //             )
  //             .toList(),
  //       ),
  //     );
  //   }
  // }
  _onSearchMechanic(
    SearchMechanic event,
    Emitter<SearchMechanicState> emit,
  ) async {
    try {
      // Show loading spinner in UI
      emit(state.copyWith(
        status: MechanicStatus.loading,
        mechanicList: [],
      ));

      dynamic token = await app_instance.storage.read(key: "token");

      Map<String, Object> jsonData = {
        "token": token.toString(),
        "search": event.searchKeyword.toString(),
      };

      final result =
          await app_instance.jobSheetRepository.searchMechanic(jsonData);

      if (result != null) {
        emit(
          state.copyWith(
            status: MechanicStatus.success,
            mechanicList: result
                .map<MechanicModel>(
                  (jsonData) => MechanicModel.fromJson(jsonData),
                )
                .toList(),
          ),
        );
      } else {
        emit(state.copyWith(
          status: MechanicStatus.success,
          mechanicList: [],
        ));
      }
    } catch (e, st) {
      log("Mechanic search error: $e\n$st");
      emit(state.copyWith(
        status: MechanicStatus.failure,
        mechanicList: [],
      ));
    }
  }
}
