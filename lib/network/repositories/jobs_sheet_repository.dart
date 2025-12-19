import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:local_shout_billing/config/constants.dart';
import 'package:local_shout_billing/network/api/job_sheet_api.dart';
import 'package:local_shout_billing/network/repositories/repository.dart';
import 'package:local_shout_billing/config.dart' as app_instance;

class JobSheetRepository extends Repository {
  final jobSheetApi = JobSheetApi();
  final _estimatePdfUrl = Constants.estimatePdfUrl;
  final _invoicePdfUrl = Constants.invoicePdfUrl;

  // fetch all estimate result
  Future<dynamic> getEstimate(jsonData) async {
    return jobSheetApi.getEstimate(jsonData);
  }

  ////fetch invoice list/////
  Future<dynamic> getInvoice(jsonData) async {
    return jobSheetApi.getInvoice(jsonData);
  }

  // fetch profile information
  Future<dynamic> profileInformation(jsonData) async {
    return jobSheetApi.profileInformation(jsonData);
  }

  // create new estimate
  Future<dynamic> addEstimate(jsonData) async {
    return jobSheetApi.addEstimate(jsonData);
  }

  //create new invoice
  Future<dynamic> createAddInvoice(jsonData) async {
    return jobSheetApi.createAddInvoice(jsonData);
  }

  // create new estimate by job sheet
  Future<dynamic> addEstimateByJobSheet(jsonData, String id) async {
    return jobSheetApi.addEstimateByJobSheet(jsonData, id);
  }

  // create new estimate by job sheet
  Future<dynamic> generateInvoice(jsonData, String id) async {
    return jobSheetApi.generateInvoice(jsonData, id);
  }

  // search labour
  Future<dynamic> searchLabour(jsonData) async {
    return jobSheetApi.searchLabour(jsonData);
  }

  // search product
  Future<dynamic> searchProduct(jsonData) async {
    return jobSheetApi.searchProduct(jsonData);
  }

  // search spare part
  Future<dynamic> searchSparePart(jsonData) async {
    return jobSheetApi.searchSparePart(jsonData);
  }

  //Search customer complaints
  Future<dynamic> searchCustomerComplaints(jsonData) async {
    return jobSheetApi.searchCustomerComplaints(jsonData);
  }

  // search customer details
  Future<dynamic> getCustomerList(jsonData) async {
    return jobSheetApi.getCustomerList(jsonData);
  }

//update profile
  Future<dynamic> getUpdatedProfile(jsonData) async {
    return jobSheetApi.getUpdatedProfile(jsonData);
  }

  //update staff profile
  Future<dynamic> getStaffData(jsonData) async {
    return jobSheetApi.getStaffData(jsonData);
  }

  // get estimate details
  Future<dynamic> getEstimateDetails(jsonData) {
    return jobSheetApi.getEstimateDetails(jsonData);
  }

// get invoice details by invoice id
  Future<dynamic> getInvoiceByInvoiceId(jsonData) {
    return jobSheetApi.getInvoiceByInvoiceId(jsonData);
  }

  // delete estimate
  Future<dynamic> deleteEstimate(jsonData) {
    return jobSheetApi.deleteEstimate(jsonData);
  }

  // delete inoice
  Future<dynamic> deleteInvoice(jsonData) {
    return jobSheetApi.deleteInvoice(jsonData);
  }

// update vehicle
  Future<dynamic> updateVehicle(jsonData, String id) {
    return jobSheetApi.updateVehicle(jsonData, id);
  }

  Future<dynamic> updatePassword(jsonData, String id) async {
    return await jobSheetApi.updatePassword(jsonData, id);
  }

  //dashboard
  Future<dynamic> dashboardData(jsonData) {
    return jobSheetApi.dashboardData(jsonData);
  }

  // update customer
  Future<dynamic> updateCustomer(jsonData, String id) {
    return jobSheetApi.updateCustomer(jsonData, id);
  }

  // search job sheet
  Future<dynamic> searchJobSheet(
      String searchKeyword, String fromDate, String toDate) async {
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": token.toString(),
      "search": searchKeyword,
      "fromDate": fromDate,
      "toDate": toDate
    };
    return jobSheetApi.searchJobSheet(jsonData);
  }

  Future<String> getEstimatePdf(String token, String id) async {
    final response = await http.get(
      Uri.parse('$_estimatePdfUrl$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['url'];
    } else {
      throw Exception('Failed to get estimate URL');
    }
  }

  Future<Uint8List> downloadPdfEstimate(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to download PDF');
    }
  }

  //for invoice pdf
  Future<String> getInvoiceUrl(String token, String id) async {
    final response = await http.get(
      Uri.parse('$_invoicePdfUrl$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['url'];
    } else {
      throw Exception('Failed to get invoice URL');
    }
  }

  Future<Uint8List> downloadPdfInvocie(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to download PDF');
    }
  }

  Future<dynamic> updateGstFlag(jsonData, String id) async {
    return jobSheetApi.updateGstFlag(jsonData, id);
  }

  Future<dynamic> updateCompany(jsonData, String id) async {
    return jobSheetApi.updateCompany(jsonData, id);
  }

  Future<dynamic> updatestaffData(jsonData, String id) async {
    return jobSheetApi.updatestaffData(jsonData, id);
  }

  // get single invoice  payment  details
  Future<dynamic> getInvoicePayment(jsonData) {
    return jobSheetApi.getInvoicePayment(jsonData);
  }

  // create new payment
  Future<dynamic> addPayment(jsonData) async {
    return jobSheetApi.addPayment(jsonData);
  }

  Future<dynamic> updateGstBill(jsonData, String id) async {
    return jobSheetApi.updateGstBill(jsonData, id);
  }

  // update job card product
  Future<dynamic> updatedJobCardProduct(jsonData, String id) {
    return jobSheetApi.updatedJobCardProduct(jsonData, id);
  }

  // update job card labour
  Future<dynamic> updateJobCardLabour(jsonData, String id) {
    return jobSheetApi.updateJobCardLabour(jsonData, id);
  }

  // update job card comments
  Future<dynamic> updateJobCardComments(jsonData, String id) {
    return jobSheetApi.updateJobCardComments(jsonData, id);
  }

  // getStockList
  Future<dynamic> getStockList(jsonData) {
    return jobSheetApi.getStockList(jsonData);
  }

  // get single stock details
  Future<dynamic> getStockDetails(jsonData) {
    return jobSheetApi.getStockDetails(jsonData);
  }

  //on details page updated or manage stock
  Future<dynamic> updateManagerStock(jsonData, String id) async {
    return jobSheetApi.updateManagerStock(jsonData, id);
  }

  // fetch spare part category list
  Future<dynamic> getSparePartCategory(jsonData) async {
    return jobSheetApi.getSparePartCategory(jsonData);
  }

  // add spare part category from create category dialog
  Future<dynamic> addSparePartCategory(jsonData) async {
    return jobSheetApi.addSparePartCategory(jsonData);
  }

//fetch spare part category by id to edit
  Future<dynamic> getSparePartCategoryById(jsonData) async {
    return jobSheetApi.getSparePartCategoryById(jsonData);
  }

//udate edited stock category
  Future<dynamic> updateSparePartCategory(jsonData, String id) async {
    return jobSheetApi.updateSparePartCategory(jsonData, id);
  }

  // create new stock
  Future<dynamic> createNewStock(jsonData) async {
    return jobSheetApi.createNewStock(jsonData);
  }

  //update edit stock
  Future<dynamic> updateEditStock(jsonData, String id) {
    return jobSheetApi.updateEditStock(jsonData, id);
  }

  // delete stock
  Future<dynamic> deleteStock(jsonData) {
    return jobSheetApi.deleteStock(jsonData);
  }

  Future<dynamic> getPurchesInvoiceList(jsonData) async {
    return jobSheetApi.getPurchesInvoiceList(jsonData);
  }

  //create purches invoice
  Future<dynamic> createPurchesInvoice(jsonData) async {
    return jobSheetApi.createPurchesInvoice(jsonData);
  }

  // get single job sheet details
  Future<dynamic> getPurchesDetailsByLastId(jsonData) {
    return jobSheetApi.getPurchesDetailsByLastId(jsonData);
  }

  // create new estimate by job sheet
  Future<dynamic> updatePurchesInvoice(jsonData, String id) async {
    return jobSheetApi.updatePurchesInvoice(jsonData, id);
  }

  // delete purchase inoice
  Future<dynamic> deletePurchaseInvoice(jsonData) {
    return jobSheetApi.deletePurchaseInvoice(jsonData);
  }

  //Get Vendor
  Future<dynamic> getVendorList(jsonData) async {
    return jobSheetApi.getVendorList(jsonData);
  }

  // delete vendor
  Future<dynamic> deleteVendor(jsonData) {
    return jobSheetApi.deleteVendor(jsonData);
  }

  //create purches invoice
  Future<dynamic> addVendor(jsonData) async {
    return jobSheetApi.addVendor(jsonData);
  }

  // get single job sheet details
  Future<dynamic> getVendorsDetails(jsonData) {
    return jobSheetApi.getVendorsDetails(jsonData);
  }

  Future<dynamic> updateVendor(jsonData, String id) {
    return jobSheetApi.updateVendor(jsonData, id);
  }

  // fetch all Staff
  Future<dynamic> getStaffList(jsonData) async {
    return jobSheetApi.getStaffList(jsonData);
  }

  // get single staff details by id
  Future<dynamic> getStaffDetails(jsonData) {
    return jobSheetApi.getStaffDetails(jsonData);
  }

  // delete staff
  Future<dynamic> deleteStaffRecord(jsonData) {
    return jobSheetApi.deleteStaffRecord(jsonData);
  }

  // update staff details by id
  Future<dynamic> updateStaffsDetails(jsonData, String id) {
    return jobSheetApi.updateStaffsDetails(jsonData, id);
  }

  // create new staff
  Future<dynamic> createAddStaff(jsonData) async {
    return jobSheetApi.createAddStaff(jsonData);
  }

  Future<dynamic> getStorageLocation(jsonData) async {
    return jobSheetApi.getStorageLocation(jsonData);
  }

  //create Customer
  Future<dynamic> createCustomer(jsonData) async {
    return jobSheetApi.createCustomer(jsonData);
  }

  // get single customer details
  Future<dynamic> getCustomerInfo(jsonData) {
    return jobSheetApi.getCustomerInfo(jsonData);
  }

  Future<dynamic> updateCustomerInfo(jsonData, String id) {
    return jobSheetApi.updateCustomerInfo(jsonData, id);
  }

  Future<dynamic> getCustomersEstimateInvoice(String customerId, jsonData) async {
    return jobSheetApi.getCustomersEstimateInvoice(customerId,  jsonData);
  }

  Future<void> logoutUser(String token) async {
    return await jobSheetApi.logoutUser(token);
  }
}
