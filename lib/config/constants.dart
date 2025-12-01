class Constants {
  static const String root = "api";

  //----------- For Staging ........
  static const String appEnv = "staging";
  static const String hostname = "api-mech-invoice.thermalcode.com";
  static const String estimatePdfUrl =
      'https://api-mech-invoice.thermalcode.com/download_estimate/';
  static const String invoicePdfUrl =
      'https://api-mech-invoice.thermalcode.com/download_invoice/';
  static const String customerInvoicePdfUrl =
      'https://api-mech-invoice.thermalcode.com/api-customer-download-invoice/';
  static const String protocol = 'https';

  //-----------for production......
  // static const String appEnv = "production";
  // static const String hostname = "api.mechmanager.com";
  // static const String estimatePdfUrl =
  //     'https://api.mechmanager.com/download_estimate/';
  // static const String invoicePdfUrl =
  //     'https://api.mechmanager.com/download_invoice/';
  // static const String customerInvoicePdfUrl =
  //     'https://api.mechmanager.com/api-customer-download-invoice/';
  // static const String protocol = 'https';

  //------------For Local..........
  // static const String appEnv = "local";
  // static const String hostname = "192.168.0.121:5000";
  // static const String estimatePdfUrl = '';
  // static const String invoicePdfUrl = '';
  // static const String customerInvoicePdfUrl = '';
  // static const String protocol = 'http';

  final int secondsRemaining = 90;
  final String countryCode = "+91";
}
