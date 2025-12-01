import 'dart:async';

class StreamsBrodcasts {
  // This stream used when invoice update
  // we are delete some lists from the invoice details page using this stream.
  static final StreamController<String> updateInvoiceDetailsStream =
      StreamController<String>.broadcast();

  static final StreamController<Map<String, dynamic>> updateGstBillSTream =
      StreamController<Map<String, dynamic>>.broadcast();
}
