import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
import 'package:local_shout_billing/config/app_icons.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/models/customer_invoice_model.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/job_sheet_details_bloc/job_sheet_details_bloc.dart';

class CustomInvoiceRow extends StatefulWidget {
  final InvoiceCustModel? invoiceCustList;
  const CustomInvoiceRow({super.key, this.invoiceCustList});

  @override
  State<CustomInvoiceRow> createState() => _CustomInvoiceRowState();
}

class _CustomInvoiceRowState extends State<CustomInvoiceRow> {
  final _formKey = GlobalKey<FormState>();
  String? roleId;

  @override
  void initState() {
    super.initState();
    _loadRoleId();
  }

  Future<void> _loadRoleId() async {
    final id = await app_instance.appConfig.secureStorage.read(key: 'roleId');
    setState(() {
      roleId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 2, 0, 4),
        child: Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: hintTextColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.invoiceCustList!.fullName.toString(),
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: blackColor),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<JobSheetDetailsBloc>().add(
                                  GetInvoiceByInvoice(
                                    id: widget.invoiceCustList!.id.toString(),
                                  ),
                                );
                            Navigator.pushNamed(
                                context, '/invoice_details_page');
                          },
                          icon: const Icon(
                            Icons.edit,
                            size: 18,
                            color: blackColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Icon(
                      mailIcon,
                      size: 17,
                      color: hintTextColor,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      widget.invoiceCustList!.email.toString(),
                      style: const TextStyle(
                          color: blackColorDark,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          call,
                          color: blackColorLight,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.invoiceCustList!.mobileNumber.toString(),
                          style: const TextStyle(
                              fontSize: 13,
                              color: blackColorDark,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          address,
                          color: blackColorLight,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.invoiceCustList!.tempDate.toString(),
                          style: const TextStyle(
                              fontSize: 13,
                              color: blackColorDark,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
