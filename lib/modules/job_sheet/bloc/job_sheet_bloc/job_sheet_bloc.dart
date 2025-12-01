import 'dart:convert';
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/isar/admin_dashboard_isar/admin_dashboard_isar.dart';
import 'package:local_shout_billing/isar/estimate_isar/estimate_list_isar.dart';
import 'package:local_shout_billing/isar/estimate_isar/estimate_list_row.dart'
    as estimate_list_store;
import 'package:local_shout_billing/isar/invoice_isar/invoice_list_isar.dart';
import 'package:local_shout_billing/isar/invoice_isar/invoice_list_row.dart'
    as invoice_list_store;
import 'package:local_shout_billing/models/estimate_gst_count_model.dart';
import 'package:local_shout_billing/models/estimate_listing_model.dart';
import 'package:local_shout_billing/models/invoice_gst_count_model.dart';
import 'package:local_shout_billing/models/invoice_model.dart';
import 'package:local_shout_billing/models/servicing_date_model.dart';
import 'package:local_shout_billing/network/repositories/jobs_sheet_repository.dart';
import 'package:local_shout_billing/config.dart' as app_instance;

import '../../../../models/dashboard_model.dart';
import '../../../../models/estimate_model.dart';
import '../../../../models/invoice_listing_model.dart';

part 'job_sheet_event.dart';
part 'job_sheet_state.dart';

class JobSheetBloc extends Bloc<JobSheetEvent, JobSheetState> {
  JobSheetBloc() : super(const JobSheetState()) {
    on<FetchDashboard>(_onFetchDashboard);
    on<FetchInvoiceList>(_onFetchInvoiceList);
    on<CreateAddInvoice>(_onCreateAddInvoice);
    on<SearchInvoiceRecord>(_onSearchInvoiceRecord);
    on<DeleteInvoice>(_onDeleteInvoice);
    on<FetchEstimateList>(_onFetchEstimateList);
    on<AddEstimate>(_onAddEstimate);
    on<SearchEstimateRecord>(_onSearchEstimateRecord);
    on<GenerateEstimateJobSheet>(_onGenerateEstimateJobSheet);
    on<DeleteEstimate>(_onDeleteEstimate);
    on<ClearListingData>(_onClearListingData);
  }

  final JobSheetRepository jobSheetRepository = JobSheetRepository();
  estimate_list_store.EstimateListRowIsar estimateListStore =
      estimate_list_store.EstimateListRowIsar();
  invoice_list_store.InvoiceListRowIsar invoiceListStore =
      invoice_list_store.InvoiceListRowIsar();

  Future<void> _onFetchEstimateList(
      FetchEstimateList event, Emitter<JobSheetState> emit) async {
    if (state.hasReachedMax! && event.timestamp != null) {
      return;
    }
    emit(
      state.copyWith(
        status: (event.status == JobSheetStatus.success)
            ? JobSheetStatus.success
            : JobSheetStatus.loading,
        selectedGstFilter: event.gstFilter,
      ),
    );
    bool isConnected = await app_instance.networkCheck.isInternetConnected();
    if (isConnected) {
      try {
        dynamic token = await app_instance.storage.read(key: "token");

        Map<String, String> jsonData = {
          'token': token.toString(),
          'timestamp': event.timestamp.toString(),
          'direction': event.direction ?? 'down',
          'search': event.searchKeyword ?? '',
          'gst_bill': event.gstFilter ?? "",
        };

        final result = await jobSheetRepository.getEstimate(jsonData);

        if (result != null && result.isNotEmpty) {
          EstimateGstCountModel estimateCountModel =
              EstimateGstCountModel.fromJson(result);

          List<EstimateListingModel> estimateList =
              estimateCountModel.estimateList;

          final bool hasReachedMax = estimateList.length < 10;

          if (event.timestamp != null &&
              event.timestamp.toString().isNotEmpty) {
            estimateList = List.from(state.estimateListing)
              ..addAll(estimateList);
          }

          // Save the new invoice list to the Isar database
          for (EstimateListingModel value in estimateList) {
            EstimateListIsar saveEstimateList = EstimateListIsar();
            saveEstimateList.id = value.id;
            saveEstimateList.createdAtTime = value.createdAtTime;
            saveEstimateList.deletedAt = value.deletedAt;
            saveEstimateList.address = value.address;
            saveEstimateList.email = value.email;
            saveEstimateList.estimateTotal = value.estimateTotal;
            saveEstimateList.flag = value.flag;
            saveEstimateList.kms = value.kms;
            saveEstimateList.fullname = value.fullname;
            saveEstimateList.manufacturers = value.manufacturers;
            saveEstimateList.mobileNumber = value.mobileNumber;
            saveEstimateList.tempDate = value.tempDate;
            saveEstimateList.timestamp = value.timestamp.toString();
            saveEstimateList.updateAt = value.updateAt;
            await estimateListStore.saveEstimateListing(saveEstimateList);
          }
          return emit(
            state.copyWith(
              status: JobSheetStatus.success,
              estimateListing: estimateList,
              allEstimateCount: estimateCountModel.allEstimateCount,
              gstEstimateCount: estimateCountModel.gstEstimateCount,
              nonGstEstimateCount: estimateCountModel.nonGstEstimateCount,
              lastTimestamp:
                  estimateList.isNotEmpty ? estimateList.last.timestamp : null,
              hasReachedMax: hasReachedMax,
              selectedGstFilter: event.gstFilter,
            ),
          );
        } else {
          if (event.timestamp != null &&
              event.timestamp.toString().isNotEmpty) {
            emit(
              state.copyWith(
                status: JobSheetStatus.success,
                selectedGstFilter: event.gstFilter,
                hasReachedMax: true,
              ),
            );
          } else {
            emit(
              state.copyWith(
                status: JobSheetStatus.failure,
                estimateListing: [],
                selectedGstFilter: event.gstFilter,
                hasReachedMax: true,
              ),
            );
          }
        }
      } catch (e) {
        emit(
          state.copyWith(
            status: JobSheetStatus.failure,
            selectedGstFilter: event.gstFilter,
            estimateListing: [],
          ),
        );
      }
    } else {
      if (state.estimateListing.length == 10) {
        Fluttertoast.showToast(
          msg: "Please check your internet connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
      List<EstimateListIsar> offlineEstimateFetch =
          await estimateListStore.getSavedEstimate(offset: 0, limit: 10);
      List<EstimateListingModel> estimateList =
          offlineEstimateFetch.map((offlineEstimateFetch) {
        return EstimateListingModel(
          id: offlineEstimateFetch.id,
          estimateNumber: offlineEstimateFetch.estimateNumber,
          estimateTotal: offlineEstimateFetch.estimateTotal,
          email: offlineEstimateFetch.email,
          flag: offlineEstimateFetch.flag,
          kms: offlineEstimateFetch.kms,
          fullname: offlineEstimateFetch.fullname,
          mobileNumber: offlineEstimateFetch.mobileNumber,
          manufacturers: offlineEstimateFetch.manufacturers,
          address: offlineEstimateFetch.address,
          updateAt: offlineEstimateFetch.updateAt,
          createdAtTime: offlineEstimateFetch.createdAtTime,
          tempDate: offlineEstimateFetch.tempDate,
          timestamp: int.parse(
            offlineEstimateFetch.timestamp.toString(),
          ),
        );
      }).toList();
      if (estimateList.isNotEmpty ||
          event.timestamp == null ||
          event.timestamp.toString().isEmpty) {
        return emit(
          state.copyWith(
            status: JobSheetStatus.success,
            estimateListing: estimateList,
            hasReachedMax: estimateList.length < 10,
            selectedGstFilter: event.gstFilter,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: JobSheetStatus.failure,
            estimateListing: [],
            hasReachedMax: true,
            selectedGstFilter: event.gstFilter,
          ),
        );
      }
    }
  }

//fetch invoiceList
  _onFetchInvoiceList(
      FetchInvoiceList event, Emitter<JobSheetState> emit) async {
    if (state.hasReachedMax! && event.timestamp != null) {
      return;
    }
    emit(
      state.copyWith(
          status: (event.status == JobSheetStatus.success)
              ? JobSheetStatus.success
              : JobSheetStatus.loading,
          selectedGstFilter: event.gstFilter),
    );
    // if network is online.
    bool isConnected = await app_instance.networkCheck.isInternetConnected();
    if (isConnected) {
      try {
        dynamic token = await app_instance.storage.read(key: "token");

        Map<String, String> jsonData = {
          'token': token!.toString(),
          'timestamp': event.timestamp.toString(),
          'direction': event.direction ?? 'down',
          'search': event.searchKeyword ?? '',
          'fromDate': event.fromDate ?? "",
          'toDate': event.toDate ?? "",
          'paymentStatus': event.paymentStatus ?? "",
          'gst_bill': event.gstFilter ?? "",
        };

        final result = await jobSheetRepository.getInvoice(jsonData);

        if (result != null && result.isNotEmpty) {
          InvoiceGstCountModel invoiceGstCountModel =
              InvoiceGstCountModel.fromJson(result);

          List<InvoiceListingModel> invoiceList =
              invoiceGstCountModel.invoiceList;

          final bool hasReachedMax = invoiceList.length < 10;

          // if (event.timestamp != null &&
          //     event.timestamp.toString().isNotEmpty) {
          //   invoiceList = List.from(state.invoiceListing)..addAll(invoiceList);
          // }
          if (event.timestamp != null &&
              event.timestamp.toString().isNotEmpty) {
            final mergedList = [
              ...state.invoiceListing,
              ...invoiceList,
            ];

            final filterdInvocie = <String>{};
            invoiceList = mergedList
                .where((e) => filterdInvocie.add(e.id.toString()))
                .toList();
          }

          // Save the new invoice list to the Isar database
          for (InvoiceListingModel value in invoiceList) {
            InvoiceListIsar saveInvoiceList = InvoiceListIsar();
            saveInvoiceList.id = value.id;
            saveInvoiceList.createdAtTime = value.createdAtTime;
            saveInvoiceList.deletedAt = value.deletedAt;
            saveInvoiceList.address = value.address;
            saveInvoiceList.email = value.email;
            saveInvoiceList.invoiceTotal = value.invoiceTotal;
            saveInvoiceList.flag = value.flag;
            saveInvoiceList.invoiceNumber = value.invoiceNumber;
            saveInvoiceList.fullname = value.fullname;
            saveInvoiceList.manufacturers = value.manufacturers;
            saveInvoiceList.mobileNumber = value.mobileNumber;
            saveInvoiceList.tempDate = value.tempDate;
            saveInvoiceList.timestamp = value.timestamp;
            saveInvoiceList.updateAt = value.updateAt;
            saveInvoiceList.afterDiscountAmount = value.afterDiscountAmount;
            saveInvoiceList.afterPayTotalAmount = value.afterPayTotalAmount;
            saveInvoiceList.paidAmount = value.paidAmount;
            await invoiceListStore.saveInvoiceListing(saveInvoiceList);
          }
          return emit(
            state.copyWith(
                status: JobSheetStatus.success,
                invoiceListing: invoiceList,
                hasReachedMax: hasReachedMax,
                allInvoiceCount: invoiceGstCountModel.allInvoiceCount,
                gstInvoiceCount: invoiceGstCountModel.gstInvoiceCount,
                nonGstInvoiceCount: invoiceGstCountModel.gstNonGstInvoiceCount,
                selectedGstFilter: event.gstFilter,
                lastTimestamp:
                    invoiceList.isNotEmpty ? invoiceList.last.timestamp : null),
          );
        } else {
          if (event.timestamp != null &&
              event.timestamp.toString().isNotEmpty) {
            emit(
              state.copyWith(
                status: JobSheetStatus.success,
                selectedGstFilter: event.gstFilter,
                hasReachedMax: true,
              ),
            );
          } else {
            emit(
              state.copyWith(
                status: JobSheetStatus.failure,
                invoiceListing: [],
                selectedGstFilter: event.gstFilter,
                hasReachedMax: true,
              ),
            );
          }
        }
      } catch (e) {
        emit(
          state.copyWith(
            status: JobSheetStatus.failure,
            invoiceListing: [],
            selectedGstFilter: event.gstFilter,
          ),
        );
      }
    } else {
      if (state.invoiceListing.length == 10) {
        Fluttertoast.showToast(
          msg: "Please check your internet connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
      List<InvoiceListIsar> offlineInvocieFetch =
          await invoiceListStore.getSavedInvoice(offset: 0, limit: 10);
      List<InvoiceListingModel> invoiceList =
          offlineInvocieFetch.map((offlineInvocieFetch) {
        return InvoiceListingModel(
          id: offlineInvocieFetch.id,
          address: offlineInvocieFetch.address,
          flag: offlineInvocieFetch.flag,
          fullname: offlineInvocieFetch.fullname,
          manufacturers: offlineInvocieFetch.manufacturers,
          mobileNumber: offlineInvocieFetch.mobileNumber,
          invoiceNumber: offlineInvocieFetch.invoiceNumber,
          invoiceTotal: offlineInvocieFetch.invoiceTotal,
          afterDiscountAmount: offlineInvocieFetch.afterDiscountAmount,
          afterPayTotalAmount: offlineInvocieFetch.afterPayTotalAmount,
          paidAmount: offlineInvocieFetch.paidAmount,
          updateAt: offlineInvocieFetch.updateAt,
          createdAtTime: offlineInvocieFetch.createdAtTime,
          deletedAt: offlineInvocieFetch.deletedAt,
          tempDate: offlineInvocieFetch.tempDate,
          timestamp: offlineInvocieFetch.timestamp,
          email: offlineInvocieFetch.email,
        );
      }).toList();
      if (invoiceList.isNotEmpty) {
        return emit(
          state.copyWith(
              status: JobSheetStatus.success,
              invoiceListing: invoiceList,
              selectedGstFilter: event.gstFilter,
              hasReachedMax: invoiceList.length < 10),
        );
      } else {
        emit(
          state.copyWith(
              status: JobSheetStatus.failure,
              invoiceListing: [],
              selectedGstFilter: event.gstFilter,
              hasReachedMax: true),
        );
      }
    }
  }

  _onFetchDashboard(FetchDashboard event, Emitter<JobSheetState> emit) async {
    emit(
      state.copyWith(
          status: (event.status == JobSheetStatus.success)
              ? JobSheetStatus.success
              : JobSheetStatus.loading),
    );
    // if network is online.
    bool isConnected = await app_instance.networkCheck.isInternetConnected();
    if (isConnected) {
      dynamic token = await app_instance.storage.read(key: "token");
      Map<String, String> jsonData = {
        'token': token.toString(),
        'fromDate': event.fromDate != null ? event.fromDate.toString() : "",
        'toDate': event.toDate != null ? event.toDate.toString() : "",
      };
      final result = await jobSheetRepository.dashboardData(jsonData);
      if (result != null && result.isNotEmpty) {
        DashboardModel dashboardModelData = DashboardModel.fromJson(result);
        // save dashboard to isar db.
        DashboardIsar saveDashBoardData = DashboardIsar();
        saveDashBoardData.id = 1;
        saveDashBoardData.delivered = dashboardModelData.delivered ?? 0;
        saveDashBoardData.newEntries = dashboardModelData.newEntries ?? 0;
        saveDashBoardData.totalCustomer = dashboardModelData.newEntries ?? 0;
        saveDashBoardData.totalEstimate = dashboardModelData.totalEstimate ?? 0;
        saveDashBoardData.totalInvoice = dashboardModelData.totalInvoice ?? 0;
        saveDashBoardData.totalLabour = dashboardModelData.totalLabour ?? 0;
        saveDashBoardData.totalMechanic = dashboardModelData.totalMechanic ?? 0;
        saveDashBoardData.totalProduct = dashboardModelData.totalProduct ?? 0;
        saveDashBoardData.totalRepair = dashboardModelData.totalRepair ?? 0;
        saveDashBoardData.totalSparePart = saveDashBoardData.totalSparePart;
        saveDashBoardData.totalVehicle = saveDashBoardData.totalVehicle;
        saveDashBoardData.userCount = saveDashBoardData.userCount;
        saveDashBoardData.customerCountFilter =
            saveDashBoardData.customerCountFilter;
        saveDashBoardData.estimateCountFilter =
            saveDashBoardData.estimateCountFilter;
        saveDashBoardData.invoiceCountFilter =
            saveDashBoardData.invoiceCountFilter;
        saveDashBoardData.jobcardCountFilter =
            saveDashBoardData.jobcardCountFilter;
        saveDashBoardData.totalOutstanding = saveDashBoardData.totalOutstanding;
        saveDashBoardData.totalRevenue = saveDashBoardData.totalRevenue;

        await app_instance.dashboardDataStore
            .saveDashboardResponse(saveDashBoardData);

        return emit(
          state.copyWith(
              status: JobSheetStatus.success,
              dashboardModel: dashboardModelData),
        );
      } else {
        return emit(
          state.copyWith(
            status: JobSheetStatus.failure,
          ),
        );
      }
    } else {
      dynamic getDashboardDataFromLocally =
          await app_instance.dashboardDataStore.getDashboardData();
      DashboardModel dashboardData = DashboardModel(
        delivered: getDashboardDataFromLocally!.delivered,
        newEntries: getDashboardDataFromLocally.newEntries,
        totalCustomer: getDashboardDataFromLocally.totalCustomer,
        totalEstimate: getDashboardDataFromLocally.totalEstimate,
        totalInvoice: getDashboardDataFromLocally.totalInvoice,
        totalLabour: getDashboardDataFromLocally.totalLabour,
        totalMechanic: getDashboardDataFromLocally.totalMechanic,
        totalProduct: getDashboardDataFromLocally.totalProduct,
        totalRepair: getDashboardDataFromLocally.totalRepair,
        totalSparePart: getDashboardDataFromLocally.totalSparePart,
        totalVehicle: getDashboardDataFromLocally.totalVehicle,
        userCount: getDashboardDataFromLocally.userCount,
        customerCountFilter: getDashboardDataFromLocally.customerCountFilter,
        estimateCountFilter: getDashboardDataFromLocally.estimateCountFilter,
        invoiceCountFilter: getDashboardDataFromLocally.invoiceCountFilter,
        jobcardCountFilter: getDashboardDataFromLocally.jobcardCountFilter,
        totalOutstanding: getDashboardDataFromLocally.totalOutstanding,
        totalRevenue: getDashboardDataFromLocally.totalRevenue,
      );
      return emit(
        state.copyWith(
            status: JobSheetStatus.success, dashboardModel: dashboardData),
      );
    }
  }

//delete Estimate
  _onDeleteEstimate(DeleteEstimate event, Emitter<JobSheetState> emit) async {
    emit(
      state.copyWith(status: JobSheetStatus.deleting),
    );
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": token.toString(),
      "id": event.id.toString(),
    };

    final result =
        await app_instance.jobSheetRepository.deleteEstimate(jsonData);

    if (result['status'] == "Success") {
      // state.jobSheetList
      //     .removeWhere((element) => element.id.toString() == event.id);
      emit(
        state.copyWith(
            status: JobSheetStatus.deleteSuccess,
            estimateListing: state.estimateListing),
      );
    }
  }

//delete invocie
  FutureOr<void> _onDeleteInvoice(
      DeleteInvoice event, Emitter<JobSheetState> emit) async {
    emit(
      state.copyWith(status: JobSheetStatus.updating),
    );
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": token.toString(),
      "id": event.id.toString()
    };
    final result =
        await app_instance.jobSheetRepository.deleteInvoice(jsonData);
    if (result['status'] == "Success") {
      emit(
        state.copyWith(
            status: JobSheetStatus.success,
            invoiceListing: state.invoiceListing),
      );
    }
  }

//search invocie
  _onSearchInvoiceRecord(
      SearchInvoiceRecord event, Emitter<JobSheetState> emit) async {
    emit(
      state.copyWith(status: JobSheetStatus.updating),
    );
    final result = await app_instance.jobSheetRepository
        .searchInvoiceList(event.searchKeyword);
    if (result != null && result.isNotEmpty) {
      return emit(
        state.copyWith(
          status: JobSheetStatus.success,
          invoiceListing: result
              .map<InvoiceListingModel>(
                (jsonData) => InvoiceListingModel.fromJson(jsonData),
              )
              .toList(),
        ),
      );
    } else {
      return emit(
        state.copyWith(
          status: JobSheetStatus.failure,
        ),
      );
    }
  }

//search estimate
  _onSearchEstimateRecord(
      SearchEstimateRecord event, Emitter<JobSheetState> emit) async {
    emit(
      state.copyWith(status: JobSheetStatus.updating),
    );
    final result = await app_instance.jobSheetRepository
        .searchEstimateDetails(event.searchKeyword);
    if (result != null && result.isNotEmpty) {
      return emit(
        state.copyWith(
          status: JobSheetStatus.success,
          estimateListing: result
              .map<EstimateListingModel>(
                (jsonData) => EstimateListingModel.fromJson(jsonData),
              )
              .toList(),
        ),
      );
    } else {
      return emit(
        state.copyWith(
          status: JobSheetStatus.failure,
        ),
      );
    }
  }

  Future<void> _onAddEstimate(
      AddEstimate event, Emitter<JobSheetState> emit) async {
    emit(
      state.copyWith(status: JobSheetStatus.sending),
    );
    // create job sheet api call
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, dynamic> jsonData = {
      "token": token.toString(),
      "formData": jsonEncode(event.formData),
    };
    dynamic response = await jobSheetRepository.addEstimate(jsonData);
    if (response['last_id'].runtimeType != Null) {
      emit(
        state.copyWith(
            status: JobSheetStatus.estimateSuccess,
            currentEstimateId: response['last_id']),
      );
    } else {
      emit(
        state.copyWith(status: JobSheetStatus.submitFailure),
      );
    }
  }

//add invoice - Create new invoice
  FutureOr<void> _onCreateAddInvoice(
      CreateAddInvoice event, Emitter<JobSheetState> emit) async {
    emit(
      state.copyWith(status: JobSheetStatus.sending),
    );
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, dynamic> jsonData = {
      "token": token.toString(),
      "formData": jsonEncode(event.formData),
    };
    dynamic response = await jobSheetRepository.createAddInvoice(jsonData);
    if (response['last_id'].runtimeType != Null) {
      emit(
        state.copyWith(
          status: JobSheetStatus.invoiceSuccess,
          currentInvoiceId: response['last_id'],
        ),
      );
    } else {
      emit(
        state.copyWith(status: JobSheetStatus.submitFailure),
      );
    }
  }

  // Add Estimate by jobsheet
  Future<void> _onGenerateEstimateJobSheet(
      GenerateEstimateJobSheet event, Emitter<JobSheetState> emit) async {
    emit(
      state.copyWith(status: JobSheetStatus.sending),
    );
    // create job sheet api call
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, dynamic> jsonData = {
      "token": token.toString(),
      "formData": jsonEncode(event.formData),
      "id": event.id.toString()
    };
    dynamic response = await jobSheetRepository.addEstimate(jsonData);
    if (response['id'].runtimeType != Null) {
      emit(
        state.copyWith(
          status: JobSheetStatus.submitSuccess,
        ),
      );
    } else {
      emit(
        state.copyWith(status: JobSheetStatus.submitFailure),
      );
    }
  }

  _onClearListingData(ClearListingData event, Emitter<JobSheetState> emit) {
    emit(
      state.copyWith(
          status: JobSheetStatus.initial,
          currentEstimateId: 0,
          currentInvoiceId: 0,
          dashboardModel: DashboardModel.empty,
          estimateListing: [],
          // estimateModel: ,
          hasReachedMax: false,
          invoiceListing: [],
          loadShow: false,
          page: 0,
          totalPages: 0),
    );
  }
}
