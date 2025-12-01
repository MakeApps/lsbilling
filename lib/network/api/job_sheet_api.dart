import 'dart:convert';
import 'package:local_shout_billing/config.dart' as app_instance;
import 'package:local_shout_billing/config.dart';
import 'package:local_shout_billing/isar/admin_profile_information/profile_information_isar.dart';
import 'package:local_shout_billing/isar/staff_updated_profile/staff_updated_profile_isar.dart';
import 'package:local_shout_billing/isar/update_profile_data/update_profile_data_isar.dart';
import 'package:local_shout_billing/network/api/api.dart';

class JobSheetApi extends Api {
  Future<dynamic> getServicVehicle(Map<String, String> jsonData) async {
    try {
      final serviceVehicle = await requestGET(
              path: '/get-job-sheets-due-date', parameters: jsonData)
          .timeout(const Duration(seconds: 30));
      return serviceVehicle['Jobsheet'];
    } catch (e, _) {
      print(e);
    }
  }

  Future<dynamic> getEstimate(Map<String, String> jsonData) async {
    try {
      final estimateList =
          await requestGET(path: '/get-estimates', parameters: jsonData)
              .timeout(const Duration(seconds: 30));
      return estimateList;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> getInvoice(Map<String, String> jsonData) async {
    try {
      final invoiceList =
          await requestGET(path: '/get-invoices', parameters: jsonData)
              .timeout(const Duration(seconds: 30));
      return invoiceList;
    } catch (e, _) {
      print(e);
      return null;
    }
  }

//add estimate
  Future<dynamic> addEstimate(jsonData) async {
    try {
      final apiResponse =
          await requestPOST(path: '/create_estimate', parameters: jsonData);
      return apiResponse;
    } catch (e, _) {
      print(e);
    }
  }

//add invoice
  Future<dynamic> createAddInvoice(jsonData) async {
    try {
      final apiResponse =
          await requestPOST(path: '/create_invoice', parameters: jsonData);
      return apiResponse;
    } catch (e, _) {
      print(e);
    }
  }

//add estimate by job sheet
  Future<dynamic> addEstimateByJobSheet(jsonData, String id) async {
    try {
      final apiResponse =
          await requestPOST(path: '/add_estimate/$id', parameters: jsonData);
      return apiResponse;
    } catch (e, _) {
      print(e);
    }
  }

  //update invoice
  Future<dynamic> generateInvoice(jsonData, String id) async {
    try {
      final apiResponse =
          await requestPOST(path: '/add_invoice/$id', parameters: jsonData);
      return apiResponse;
    } catch (e, _) {
      print(e);
    }
  }

//delete estimate///
  Future<dynamic> deleteEstimate(jsonData) async {
    try {
      final result = await requestDELETE(
          path: '/delete_estimate/${jsonData['id']}', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is---------$er");
    }
  }

  //delete invoice

  Future<dynamic> deleteInvoice(jsonData) async {
    try {
      final result = await requestDELETE(
          path: '/delete_invoice/${jsonData['id']}', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is---------$er");
    }
  }

  Future<dynamic> searchMechanic(jsonData) async {
    try {
      final apiResponse =
          await requestGET(path: '/get-mechanics', parameters: jsonData);
      return apiResponse['mechanics'];
    } catch (er, _) {
      print(er);
    }
  }

  Future<dynamic> searchProduct(jsonData) async {
    try {
      final apiResponse =
          await requestGET(path: '/get-products', parameters: jsonData);
      return apiResponse['products'];
    } catch (er, _) {
      print(er);
    }
  }

  Future<dynamic> searchSparePart(jsonData) async {
    try {
      final apiResponse =
          await requestGET(path: '/get-spare-parts', parameters: jsonData);
      return apiResponse['spare_parts'];
    } catch (er, _) {
      print(er);
    }
  }

  Future<dynamic> searchLabour(jsonData) async {
    try {
      final apiResponse =
          await requestGET(path: '/get-labours', parameters: jsonData);
      return apiResponse['labours'];
    } catch (er, _) {
      print(er);
    }
  }

  //update profile
  Future<dynamic> getUpdatedProfile(jsonData) async {
    try {
      final result = await requestGET(
          path: '/get_company/${jsonData['id']}', parameters: jsonData);
      UpdateProfileData updateData = UpdateProfileData();
      updateData.id = 1;
      updateData.updateProfileInfo = jsonEncode(result);
      await app_instance.updateDataStore.saveUpdatedProfileData(updateData);
      return result['company'];
    } catch (er) {
      print("Error is---------$er");
    }
  }

  //get Estimate Details by estimate
  Future<dynamic> getEstimateDetails(jsonData) async {
    try {
      final getEstimateResponse = await requestGET(
          path: 'get_estimate/${jsonData['id']}', parameters: jsonData);
      return getEstimateResponse['Estimate'];
    } catch (er) {
      print("Error is---------$er");
    }
  }

//get invocie by job sheet
  Future<dynamic> getInvoiceByJobsheet(jsonData) async {
    try {
      final getInvoiceResponse = await requestGET(
          path: 'get_invoice_by_id/${jsonData['id']}', parameters: jsonData);
      return getInvoiceResponse['Invoice'];
    } catch (er) {
      print("Error is---------$er");
    }
  }

  //get invoice Details by invoice id
  Future<dynamic> getInvoiceByInvoiceId(jsonData) async {
    try {
      final getEstimateResponse = await requestGET(
          path: 'get_invoice_by_id/${jsonData['id']}', parameters: jsonData);
      return getEstimateResponse['Invoice'];
    } catch (er) {
      print("Error is---------$er");
    }
  }

//getEstimateDetailsByJobsheet
  Future<dynamic> getEstimateDetailsByJobsheet(jsonData) async {
    try {
      final getEstimateResponse = await requestGET(
          path: 'get_estimate/${jsonData['id']}', parameters: jsonData);
      return getEstimateResponse['Estimate'];
    } catch (er) {
      print("Error is---------$er");
    }
  }

  Future<dynamic> updateVehicle(jsonData, String id) async {
    try {
      final result =
          await requestPUT(path: '/update_vehicle/$id', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is------$er");
    }
  }

  Future<dynamic> getjobsheetimages(jsonData) async {
    try {
      final imageslide = await requestGET(
          path: '/get_job_sheet_original_img/${jsonData['id']}',
          parameters: jsonData);
      return imageslide['Jobsheet'];
    } catch (er) {
      print("Error is---------$er");
    }
  }

  //dashnoard.
  Future<dynamic> dashboardData(jsonData) async {
    try {
      final result = await requestGET(path: '/dashboard', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is---------$er");
    }
  }

//updateJobSheet
  Future<dynamic> updateJobSheet(jsonData, String id) async {
    try {
      final result =
          await requestPUT(path: '/update_job_sheet/$id', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is---------$er");
    }
  }

  Future<dynamic> updateJobSheetStatus(jsonData, String id) async {
    try {
      final result =
          await requestPUT(path: '/update_status/$id', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is---------$er");
    }
  }

  Future<dynamic> updateCustomer(jsonData, String id) async {
    try {
      final result =
          await requestPUT(path: '/update_customer/$id', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is------$er");
    }
  }

//update task list
  Future<dynamic> updateCustomerComplaints(jsonData, String id) async {
    try {
      final result = await requestPUT(
          path: '/update_customer_complaints/$id', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is------$er");
    }
  }

//search vehicle
  Future<dynamic> searchVehicleDetails(
    jsonData,
  ) async {
    try {
      final apiResponse =
          await requestGET(path: '/get_vehicles', parameters: jsonData);
      return apiResponse['vehicles'];
    } catch (er) {
      print("Error is---------$er");
    }
  }

  ////customer complaints/////

  Future<dynamic> searchCustomerComplaints(jsonData) async {
    try {
      final apiResponse = await requestGET(
          path: '/get_customer_complaints', parameters: jsonData);
      return apiResponse['customer_complaints'];
    } catch (er) {
      print("Error is---------$er");
    }
  }

  // search customer
  Future<dynamic> searchCustomerDetails(
    jsonData,
  ) async {
    try {
      final apiResponse =
          await requestGET(path: '/get_customers', parameters: jsonData);
      return apiResponse['customers'];
    } catch (er) {
      print("Error is---------$er");
    }
  }

//search invoice list
  Future<dynamic> searchEstimateDetails(dynamic jsonData) async {
    final apiResponse =
        await requestGET(path: '/get_estimates', parameters: jsonData);
    return apiResponse['Estimates'];
  }

//search invoice list
  Future<dynamic> searchInvoiceList(dynamic jsonData) async {
    final apiResponse =
        await requestGET(path: '/get_invoices', parameters: jsonData);
    return apiResponse['Invoice'];
  }

//job sheet search
  Future<dynamic> searchJobSheet(dynamic jsonData) async {
    final apiResponse =
        await requestGET(path: '/search_job_sheet', parameters: jsonData);
    return apiResponse['Jobsheet'];
  }

  //profile information

  Future<dynamic> profileInformation(jsonData) async {
    try {
      final profileInformation =
          await requestGET(path: '/profile_information', parameters: jsonData);

      storage.write(
        key: 'id',
        value: profileInformation['user']['id'].toString(),
      );
      storage.write(
        key: 'firstName',
        value: profileInformation['user']['first_name'].toString(),
      );

      ProfileInformationIsar profileIsarData = ProfileInformationIsar();
      profileIsarData.id = 1;
      profileIsarData.profileInformation = jsonEncode(profileInformation);
      await app_instance.profileDataStore
          .saveProfileInformation(profileIsarData);

      return profileInformation['user'];
    } catch (e, _) {
      print(e);
    }
  }

  Future<dynamic> updatePassword(jsonData, String id) async {
    try {
      final passwordData =
          await requestPUT(path: '/update_password/$id', parameters: jsonData);

      return passwordData;
    } catch (e, _) {
      print(e);
      print(_);
    }
  }

  Future<dynamic> updateGstFlag(jsonData, String id) async {
    try {
      final apiResponse = await requestPUT(
        path: '/update_gst_flag/$id',
        parameters: jsonData,
      );
      return apiResponse;
    } catch (e) {
      print('Error while updating GST flag: $e');
      return null;
    }
  }

  Future<dynamic> updateCompany(jsonData, String id) async {
    try {
      final result =
          await requestPUT(path: '/update_company/$id', parameters: jsonData);

      return result;
    } catch (e, _) {
      print(e);
      print(_);
    }
  }

  Future<dynamic> getStaffData(jsonData) async {
    try {
      final response = await requestGET(
          path: 'get_user/${jsonData['id']}', parameters: jsonData);
      StaffUpdatedProfileData staffUpdatingData = StaffUpdatedProfileData();
      staffUpdatingData.id = 1;
      staffUpdatingData.staffUpdatedData = jsonEncode(response);
      await app_instance.staffUpdatedStore
          .saveStaffUpatedData(staffUpdatingData);
      return response['users'];
    } catch (er) {
      print("Error is---------$er");
    }
  }

  Future<dynamic> updatestaffData(jsonData, String id) async {
    try {
      final result =
          await requestPUT(path: '/update_user/$id', parameters: jsonData);

      return result;
    } catch (e, _) {
      print(e);
      print(_);
    }
  }

  Future<dynamic> getInvoicePayment(jsonData) async {
    try {
      final getPaymentResponse = await requestGET(
          path: 'get-invoice-payment/${jsonData['id']}', parameters: jsonData);
      return getPaymentResponse['Payment'];
    } catch (er) {
      print("Error is---------$er");
    }
  }

  //add payment of invoice
  Future<dynamic> addPayment(jsonData) async {
    try {
      final apiResponse =
          await requestPOST(path: '/add_invoice_payment', parameters: jsonData);
      return apiResponse;
    } catch (e, _) {
      print(e);
    }
  }

  Future<dynamic> updateGstBill(jsonData, String id) async {
    try {
      final result =
          await requestPUT(path: '/update-gst-bill/$id', parameters: jsonData);

      return result;
    } catch (e, _) {
      print(e);
      print(_);
    }
  }

  Future<dynamic> updatedJobCardProduct(jsonData, String id) async {
    try {
      final result =
          await requestPUT(path: '/update-products/$id', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is------$er");
    }
  }

  Future<dynamic> updateJobCardLabour(jsonData, String id) async {
    try {
      final result =
          await requestPUT(path: '/update-labours/$id', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is------$er");
    }
  }

  Future<dynamic> updateJobCardComments(jsonData, String id) async {
    try {
      final result =
          await requestPUT(path: '/update-comments/$id', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is------$er");
    }
  }

  ///Stock Point
  Future<dynamic> getStockList(Map<String, dynamic> jsonData) async {
    try {
      final Map<String, Object> params = jsonData.map(
        (key, value) => MapEntry(key, value as Object),
      );
      final stockList =
          await requestGET(path: '/get-products', parameters: params)
              .timeout(const Duration(seconds: 30));
      return stockList;
    } catch (e, _) {
      print(e);
    }
  }

  Future<dynamic> getStockDetails(jsonData) async {
    try {
      final stockDetails = await requestGET(
          path: 'get_product/${jsonData['id']}', parameters: jsonData);
      return stockDetails['Product'];
    } catch (er) {
      print("Error is---------$er");
    }
  }

  Future<dynamic> updateManagerStock(jsonData, String id) async {
    try {
      final apiResponse = await requestPOST(
          path: '/product_timeline/$id', parameters: jsonData);
      return apiResponse;
    } catch (e, _) {
      print(e);
    }
  }

  Future<dynamic> getSparePartCategory(Map<String, String> jsonData) async {
    try {
      final categoryList = await requestGET(
              path: '/get_spare_part_category', parameters: jsonData)
          .timeout(
        const Duration(seconds: 30),
      );
      return categoryList['serialized_category'];
    } catch (e, _) {
      print(e);
    }
  }

  Future<dynamic> addSparePartCategory(jsonData) async {
    try {
      final result = await requestPOST(
        path: '/add_spare_part_category',
        parameters: jsonData,
      );
      return result;
    } catch (e, _) {
      print(e);
      return null;
    }
  }

  Future<dynamic> getSparePartCategoryById(jsonData) async {
    try {
      final response = await requestGET(
        path: 'get_spare_part_category_by_id/${jsonData['id']}',
        parameters: jsonData,
      );
      return response['serialized_category'];
    } catch (e, _) {
      print(e);
      return null;
    }
  }

  Future<dynamic> updateSparePartCategory(jsonData, String id) async {
    try {
      final result = await requestPUT(
        path: '/update_spare_part_category/$id',
        parameters: jsonData,
      );
      return result;
    } catch (e, _) {
      print(e);
      return null;
    }
  }

  Future<dynamic> createNewStock(jsonData) async {
    try {
      final apiResponse =
          await requestPOST(path: '/add_product', parameters: jsonData);
      return apiResponse;
    } catch (e, _) {
      print(e);
    }
  }

  //update edit stock
  Future<dynamic> updateEditStock(jsonData, String id) async {
    try {
      final result =
          await requestPUT(path: '/update_product/$id', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is---------$er");
    }
  }

  Future<dynamic> deleteStock(jsonData) async {
    try {
      final result = await requestDELETE(
          path: '/delete_product/${jsonData['id']}', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is---------$er");
    }
  }

  //purches invoice
  Future<dynamic> getPurchesInvoiceList(Map<String, String> jsonData) async {
    try {
      final apiResponse =
          await requestGET(path: '/get-vendor-invoices', parameters: jsonData)
              .timeout(
        const Duration(seconds: 30),
      );
      return apiResponse;
    } catch (e, _) {
      print(e);
    }
  }

  //add estimate
  Future<dynamic> createPurchesInvoice(jsonData) async {
    try {
      final apiResponse = await requestPOST(
          path: '/create-vendor-invoice', parameters: jsonData);
      return apiResponse;
    } catch (e, _) {
      print(e);
    }
  }

  Future<dynamic> getPurchesDetailsByLastId(jsonData) async {
    try {
      final response = await requestGET(
          path: 'get-vendor-invoice/${jsonData['id']}', parameters: jsonData);
      return response['PurchaseInvoice'];
    } catch (er) {
      print("Error is---------$er");
    }
  }

  //update purches invoice
  Future<dynamic> updatePurchesInvoice(jsonData, String id) async {
    try {
      final apiResponse = await requestPOST(
          path: '/add-vendor-invoice/$id', parameters: jsonData);
      return apiResponse;
    } catch (e, _) {
      print(e);
    }
  }
  //delete purchase invoice

  Future<dynamic> deletePurchaseInvoice(jsonData) async {
    try {
      final result = await requestDELETE(
          path: '/delete-vendor-invoice/${jsonData['id']}',
          parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is---------$er");
    }
  }

  ///Vendor List
  Future<dynamic> getVendorList(Map<String, String> jsonData) async {
    try {
      final vendorList =
          await requestGET(path: '/get-vendors', parameters: jsonData).timeout(
        const Duration(seconds: 30),
      );
      return vendorList['vendors'];
    } catch (e, _) {
      print(e);
      return null;
    }
  }

  //delete vendor///
  Future<dynamic> deleteVendor(jsonData) async {
    try {
      final result = await requestDELETE(
          path: '/delete_vendor/${jsonData['id']}', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is---------$er");
    }
  }

  //add vendor
  Future<dynamic> addVendor(jsonData) async {
    try {
      final apiResponse =
          await requestPOST(path: '/add_vendor', parameters: jsonData);
      return apiResponse;
    } catch (e, _) {
      print(e);
    }
  }

  //get vendor details to update
  Future<dynamic> getVendorsDetails(jsonData) async {
    try {
      final response = await requestGET(
          path: 'get_vendor/${jsonData['id']}', parameters: jsonData);
      return response['Vendor'];
    } catch (er) {
      print("Error is---------$er");
    }
  }

  //update vendor
  Future<dynamic> updateVendor(jsonData, String id) async {
    try {
      final result =
          await requestPUT(path: '/update_vendor/$id', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is------$er");
    }
  }

  //for staff section
  Future<dynamic> getStaffList(Map<String, String> jsonData) async {
    try {
      final staffList =
          await requestGET(path: '/get-users', parameters: jsonData)
              .timeout(const Duration(seconds: 30));
      return staffList['users'];
    } catch (e, _) {
      print(e);
    }
  }

  //get staff details to update
  Future<dynamic> getStaffDetails(jsonData) async {
    try {
      final response = await requestGET(
          path: '/get_user/${jsonData['id']}', parameters: jsonData);
      return response['users'];
    } catch (er) {
      print("Error is---------$er");
    }
  }

  //delete staff///
  Future<dynamic> deleteStaffRecord(jsonData) async {
    try {
      final result = await requestDELETE(
          path: '/delete_user/${jsonData['id']}', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is---------$er");
    }
  }

  //update staff's details
  Future<dynamic> updateStaffsDetails(jsonData, String id) async {
    try {
      final result =
          await requestPUT(path: '/update_user/$id', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is------$er");
    }
  }

  Future<dynamic> createAddStaff(jsonData) async {
    try {
      final apiResponse =
          await requestPOST(path: '/add_user', parameters: jsonData);
      return apiResponse;
    } catch (e, _) {
      print(e);
    }
  }

  Future<dynamic> getStorageLocation(Map<String, String> jsonData) async {
    try {
      final locationList =
          await requestGET(path: '/get_locations', parameters: jsonData)
              .timeout(const Duration(seconds: 30));
      return locationList['stock_locations'];
    } catch (e, _) {
      print(e);
    }
  }

Future<void> logoutUser(String token) async {
    try {
      await requestGET(
        path: '/logout',
        parameters: {'token': token},
      );
    } catch (e) {
      print('Error in logout: $e');
      throw e;
    }
  }
  
}
