import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/isar/isar_services.dart';
import 'package:local_shout_billing/modules/customers/bloc/customer_bloc/customer_bloc.dart';
import 'package:local_shout_billing/modules/customers/bloc/customer_details_bloc/customer_details_bloc.dart';
import 'package:local_shout_billing/modules/internet_bloc/internet_bloc.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/job_sheet_bloc/job_sheet_bloc.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/job_sheet_details_bloc/job_sheet_details_bloc.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/profile_bloc/profile_section_bloc.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/profile_bloc/profile_section_event.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/search_bloc/search_bloc_bloc.dart';
import 'package:local_shout_billing/modules/login/cubit/login_cubit.dart';
import 'package:local_shout_billing/modules/purches_invoice/bloc/purches_invoice/purchase_invoice_bloc.dart';
import 'package:local_shout_billing/modules/purches_invoice/bloc/purches_invoice_details_bloc/purches_invoice_details_bloc.dart';
import 'package:local_shout_billing/modules/staff/bloc/staff_bloc/staff_bloc.dart';
import 'package:local_shout_billing/modules/staff/bloc/staff_details_bloc/edit_staff_details_bloc.dart';
import 'package:local_shout_billing/modules/stocks/bloc/category_bloc/category_list_bloc.dart';
import 'package:local_shout_billing/modules/stocks/bloc/stock_bloc/stock_bloc.dart';
import 'package:local_shout_billing/modules/stocks/bloc/update_category_bloc/category_name_update_bloc.dart';
import 'package:local_shout_billing/modules/vendors/bloc/vendor_bloc/vendor_bloc.dart';
import 'package:local_shout_billing/modules/vendors/bloc/vendor_details_bloc/vendor_details_bloc.dart';
import 'package:local_shout_billing/network/controllers/authentication_controller.dart';
import 'package:local_shout_billing/router/app_router.dart';
import 'modules/job_sheet/bloc/profile_update_bloc/profile_update_bloc_bloc.dart';
import 'modules/stocks/bloc/stock_details_bloc/stock_details_bloc.dart';

late IsarServices isarServices;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  isarServices = IsarServices();
  final auth = Authentication();
  final isLogin = await auth.checkLogin();
  // final roleId = await app_instance.appConfig.secureStorage.read(key: 'roleId');
  runApp(
    MyApp(
      appRouter: AppRouter(),
      initialRoute: isLogin ? '/dashboard_page' : '/login_screen',
    ),
  );
}

// check internet connectivity.
Future<bool> checkInternet() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}

class MyApp extends StatelessWidget {
  final String? initialRoute;
  final AppRouter appRouter;
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  const MyApp({super.key, required this.appRouter, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LogInCubit>(
            create: (context) => LogInCubit(),
          ),

          BlocProvider<JobSheetBloc>(
              create: (context) => JobSheetBloc()
                ..add(
                  const FetchEstimateList(status: JobSheetStatus.initial),
                )
                ..add(
                  const FetchInvoiceList(status: JobSheetStatus.initial),
                )),
          BlocProvider<ProfileSectionBloc>(
            create: (context) => ProfileSectionBloc()
              ..add(
                const FetchProfileInfo(),
              ),
          ),
          BlocProvider<JobSheetDetailsBloc>(
            create: (context) => JobSheetDetailsBloc(),
          ),

          BlocProvider<SearchBloc>(
            create: (context) => SearchBloc(),
          ),

          BlocProvider<EditBloc>(
            create: (context) => EditBloc(),
          ),

          //Purchase Invoice
          BlocProvider<PurchesInvoiceBloc>(
            create: (context) => PurchesInvoiceBloc()
              ..add(
                const FetchPurchesInvoiceList(
                    status: PurchesInvoiceStatus.initial),
              ),
          ),
          BlocProvider<PurchesInvoiceDetailsBloc>(
            create: (context) => PurchesInvoiceDetailsBloc(),
          ),

          //stock bloc
          BlocProvider<StockBloc>(
            create: (context) => StockBloc()
              ..add(
                const FetchStockList(status: StockStatus.initial),
              ),
          ),
          BlocProvider<CustomerBloc>(
            create: (context) => CustomerBloc()
              ..add(
                const FetchCustomerList(status: CustomerStatus.initial),
              ),
          ),
          BlocProvider<CustomerDetailsBloc>(
            create: (context) => CustomerDetailsBloc(),
          ),
          BlocProvider<StockDetailsBloc>(
            create: (context) => StockDetailsBloc(),
          ),
          BlocProvider<CategoryListBloc>(
            create: (context) => CategoryListBloc(),
          ),
          BlocProvider<CategoryNameUpdateBloc>(
            create: (context) => CategoryNameUpdateBloc(),
          ),

          //Vendor section
          BlocProvider<VendorBloc>(
            create: (context) => VendorBloc()
              ..add(
                const FetchVendorList(status: VendorStatus.initial),
              ),
          ),
          //get customer
          BlocProvider<CustomerBloc>(
            create: (context) => CustomerBloc()
              ..add(
                const FetchCustomerList(status: CustomerStatus.initial),
              ),
          ),

          BlocProvider<VendorDetailsBloc>(
            create: (context) => VendorDetailsBloc(),
          ),

          //staff section
          BlocProvider<StaffBloc>(
            create: (context) => StaffBloc()
              ..add(
                const FetchStaffList(
                    createStaffStatus: CreateStaffStatus.initial),
              ),
          ),
          BlocProvider<EditStaffDetailsBloc>(
            create: (context) => EditStaffDetailsBloc(),
          ),

          BlocProvider<InternetBloc>(
            create: (context) => InternetBloc()
              ..add(
                CheckInternetConnectionEvent(),
              ),
          )
          //ProfileUpdateBloc
        ],
        child: BlocListener<InternetBloc, InternetState>(
          listenWhen: (previous, current) =>
              previous.status == InternetStatus.internetDisconnected &&
              current.status == InternetStatus.internetConnected,
          listener: (context, state) async {
            if (state.status == InternetStatus.internetConnected) {
              Fluttertoast.showToast(
                msg: "Internet connection restored",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
              );

              final auth = Authentication();
              final isLogin = await auth.checkLogin();
              if (!isLogin) return;

              context.read<JobSheetDetailsBloc>().add(
                    const SyncOfflineUpdatedJobSheets(),
                  );
            }
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: initialRoute,
            title: 'LS Billing',
            navigatorKey: navigatorKey,
            onGenerateRoute: appRouter.onGenerateRoute,
          ),
        ),
      ),
    );
  }
}
