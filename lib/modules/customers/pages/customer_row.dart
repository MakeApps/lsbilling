import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
import 'package:local_shout_billing/config/app_icons.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/models/customer_model.dart';
import 'package:local_shout_billing/modules/customers/bloc/customer_details_bloc/customer_details_bloc.dart';

class CustomerDetailsRow extends StatefulWidget {
  final CustomerModel? customerListing;
  const CustomerDetailsRow({super.key, this.customerListing});

  @override
  State<CustomerDetailsRow> createState() => _CustomerDetailsRowState();
}

class _CustomerDetailsRowState extends State<CustomerDetailsRow> {
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
    return GestureDetector(
      onTap: () {},
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
          child: Card(
            color: whiteColor,
            shape: const RoundedRectangleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.customerListing!.fullName.toString(),
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: blackColor),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<CustomerDetailsBloc>().add(
                                    GetCustomerDetail(
                                      id: widget.customerListing!.id.toString(),
                                    ),
                                  );
                              Navigator.pushNamed(
                                  context, '/edit_customer_info');
                            },
                            icon: const Icon(
                              Icons.edit,
                              size: 18,
                              color: blackColor,
                            ),
                          ),
                          PopupMenuButton<String>(
                            elevation: 6, // shadow
                            color: whiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                              side: const BorderSide(
                                  color: Colors.black12, width: 1),
                            ),
                            itemBuilder: (context) => [
                              const PopupMenuItem<String>(
                                value: 'estimate',
                                child: Text(
                                  'Estimate',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: greyColor,
                                  ),
                                ),
                              ),
                              const PopupMenuItem<String>(
                                value: 'invoice',
                                child: Text(
                                  'Invoice',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: greyColor,
                                  ),
                                ),
                              ),
                            ],
                            onSelected: (value) {
                              if (value == 'estimate') {
                              } else if (value == 'invoice') {}
                            },
                            child: const Icon(verticleDot,
                                color: hintTextColor, size: 30),
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
                        widget.customerListing!.email.toString(),
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
                            widget.customerListing!.mobileNumber.toString(),
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
                            widget.customerListing!.address.toString(),
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
      ),
    );
  }
}
