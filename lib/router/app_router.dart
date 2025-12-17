import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_shout_billing/modules/Dashboard/dashboard_page.dart';
import 'package:local_shout_billing/modules/Estimate/estimate_page.dart';
import 'package:local_shout_billing/modules/Profile/pages/update_admin_profile.dart';
import 'package:local_shout_billing/modules/Profile/profile.dart';
import 'package:local_shout_billing/modules/customers/bloc/customer_bloc/customer_bloc.dart';
import 'package:local_shout_billing/modules/customers/customer_listing.dart';
import 'package:local_shout_billing/modules/customers/pages/edit_customer.dart';
import 'package:local_shout_billing/modules/estimate/estimate_listing.dart';
import 'package:local_shout_billing/modules/invoices/invoice_details_page.dart';
import 'package:local_shout_billing/modules/invoices/invoice_listing_page.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/job_sheet_bloc/job_sheet_bloc.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/profile_bloc/profile_section_bloc.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/profile_bloc/profile_section_event.dart';
import 'package:local_shout_billing/modules/purches_invoice/bloc/purches_invoice/purchase_invoice_bloc.dart';
import 'package:local_shout_billing/modules/purches_invoice/pages/purches_invoice_details_page.dart';
import 'package:local_shout_billing/modules/purches_invoice/pages/purches_invoice_list.dart';
import 'package:local_shout_billing/modules/staff/bloc/staff_bloc/staff_bloc.dart';
import 'package:local_shout_billing/modules/staff/pages/edit_staff_screen.dart';
import 'package:local_shout_billing/modules/staff/pages/staff_listing.dart';
import 'package:local_shout_billing/modules/stocks/bloc/stock_bloc/stock_bloc.dart';
import 'package:local_shout_billing/modules/stocks/pages/stock_listing.dart';
import 'package:local_shout_billing/modules/vendors/bloc/vendor_bloc/vendor_bloc.dart';
import 'package:local_shout_billing/modules/vendors/page/edit_vendors_details.dart';
import 'package:local_shout_billing/modules/vendors/page/vendor_listing_screen.dart';
import 'package:local_shout_billing/splash_screen.dart';
import '../modules/login/login_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      //------------Staff Portal-------//
      case '/login_screen':
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case '/splash_screen':
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case '/dashboard_page':
        return MaterialPageRoute(
          builder: (_) => const DashboardPage(),
        );

      case '/invoice_page_listing':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => JobSheetBloc()
              ..add(
                const FetchInvoiceList(status: JobSheetStatus.initial),
              ),
            child: const InvoiceListingPage(),
          ),
        );

      case '/stock_listing_screen':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<StockBloc>(
            create: (context) => StockBloc()
              ..add(
                const FetchStockList(status: StockStatus.initial),
              ),
            child: const StockListing(),
          ),
        );

      case '/purches_invoice_listing':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PurchesInvoiceBloc>(
            create: (context) => PurchesInvoiceBloc()
              ..add(
                const FetchPurchesInvoiceList(
                    status: PurchesInvoiceStatus.initial),
              ),
            child: const PurchesInvoiceListingPage(),
          ),
        );

      case '/purchase_details_screen':
        return MaterialPageRoute(
          builder: (_) => const PurchesInvoiceDetailScreen(),
        );

      case '/vendor_listing':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<VendorBloc>(
            create: (context) => VendorBloc()
              ..add(
                const FetchVendorList(status: VendorStatus.initial),
              ),
            child: const VendorListingPage(),
          ),
        );
        
      case '/customer_page':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<CustomerBloc>(
            create: (context) => CustomerBloc()
              ..add(
                const FetchCustomerList(status: CustomerStatus.initial),
              ),
            child: const CustomerListing(),
          ),
        );

      case '/edit_customer_info':
        return MaterialPageRoute(
          builder: (_) => const EditCustomerForm(),
        );

      case '/profile_info_page':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ProfileSectionBloc()
                    ..add(
                      const FetchProfileInfo(),
                    ),
                  child: const ProfilePage(),
                ));

      case '/estimate_listing':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<JobSheetBloc>(
            create: (context) => JobSheetBloc()
              ..add(const FetchEstimateList(
                status: JobSheetStatus.initial,
              )),
            child: const EstimateListing(),
          ),
        );

      case '/estimate_page':
        return MaterialPageRoute(
          builder: (_) => const EstimatePage(),
        );
      case '/update_proifile':
        return MaterialPageRoute(
          builder: (_) => const UpdateProfile(),
        );
      case '/invoice_details_page':
        return MaterialPageRoute(
          builder: (_) => const InvoiceDetailsPage(),
        );

      //staff section
      case '/staff_listing':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<StaffBloc>(
            create: (context) => StaffBloc()
              ..add(const FetchStaffList(
                createStaffStatus: CreateStaffStatus.initial,
              )),
            child: const StaffListingScreen(),
          ),
        );

      case '/staff_details_screen':
        return MaterialPageRoute(
          builder: (_) => const EditStaffScreen(),
        );

      case '/vendor_details_date':
        return MaterialPageRoute(
          builder: (_) => const EditVendorsDetails(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
    }
  }
}
