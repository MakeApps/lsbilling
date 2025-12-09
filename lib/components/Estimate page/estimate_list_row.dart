import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/components/center_loader.dart';
import 'package:local_shout_billing/config/app_icons.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/models/estimate_listing_model.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/job_sheet_bloc/job_sheet_bloc.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
import '../../modules/Estimate/estimate_page.dart';
import '../../modules/job_sheet/bloc/job_sheet_details_bloc/job_sheet_details_bloc.dart';

class EstimateListRow extends StatefulWidget {
  final EstimateListingModel? estimateList;
  const EstimateListRow({super.key, this.estimateList});

  @override
  State<EstimateListRow> createState() => _EstimateListRowState();
}

class _EstimateListRowState extends State<EstimateListRow> {
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
      onTap: () {
        context.read<JobSheetDetailsBloc>().add(
              GetEstimateDetailsByEstimate(
                id: widget.estimateList!.id.toString(),
              ),
            );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EstimatePage(),
          ),
        );
      },
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
                      Column(
                        children: [
                          Row(
                            children: [
                              (widget.estimateList!.estimateNumber
                                          .toString()
                                          .length ==
                                      1)
                                  ? Text(
                                      '#000${widget.estimateList!.estimateNumber.toString()}',
                                      style: const TextStyle(
                                          color: bluecolorprimary,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    )
                                  : (widget.estimateList!.estimateNumber
                                              .toString()
                                              .length ==
                                          3)
                                      ? Text(
                                          '#0${widget.estimateList!.estimateNumber.toString()}',
                                          style: const TextStyle(
                                              color: bluecolorprimary,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        )
                                      : Text(
                                          '#00${widget.estimateList!.estimateNumber.toString()}',
                                          style: const TextStyle(
                                              color: bluecolorprimary,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                            ],
                          ),
                        ],
                      ),
                      if (roleId != null && roleId != '4')
                        PopupMenuButton<String>(
                          elevation: 6, // shadow
                          color: whiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(
                                color: Colors.black12, width: 1),
                          ),
                          itemBuilder: (context) => [
                            const PopupMenuItem<String>(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(Icons.delete, color: redColor, size: 18),
                                  SizedBox(width: 8),
                                  Text(
                                    'Delete',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: blackColorDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          onSelected: (value) {
                            if (value == 'delete') {
                              showExitConfirmation(context);
                            }
                          },
                          child: const Icon(verticleDot,
                              color: hintTextColor, size: 30),
                        ),
                    ],
                  ),
                  Text(
                    widget.estimateList!.fullname.toString(),
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: blackColor),
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
                        widget.estimateList!.email.toString(),
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
                            widget.estimateList!.mobileNumber.toString(),
                            style: const TextStyle(
                                fontSize: 13,
                                color: blackColorDark,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            currency,
                            size: 14,
                            color: blackColor,
                          ),
                          (widget.estimateList!.estimateTotal == 'null')
                              ? const Text(
                                  '0',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: blackColor,
                                      fontWeight: FontWeight.w600),
                                )
                              : Text(
                                  double.parse(
                                          widget.estimateList!.estimateTotal!)
                                      .toStringAsFixed(2),
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: blackColor,
                                      fontWeight: FontWeight.w600),
                                )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showExitConfirmation(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          title: const Text(
            "Are you sure you want to delete Estimate?",
            style: TextStyle(
                color: blackColorDark,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                context.read<JobSheetBloc>().add(
                      DeleteEstimate(
                        id: widget.estimateList!.id.toString(),
                      ),
                    );
                CenterLoader.hide();
                context.read<JobSheetBloc>().add(
                      const FetchEstimateList(status: JobSheetStatus.success),
                    );
                Navigator.pushNamed(context, '/estimate_listing');
                Fluttertoast.showToast(
                    toastLength: Toast.LENGTH_LONG,
                    msg: "Estimate deleted succesfully",
                    backgroundColor: successDarkColor);
              },
              style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  backgroundColor: primaryColor,
                  foregroundColor: whiteColor),
              child: const Text(
                "Delete",
                style: TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(3),
                  ),
                ),
                backgroundColor: whiteColor,
                side: const BorderSide(color: primaryColor, width: 1),
              ),
              child: const Text(
                "Cancel",
                style: TextStyle(
                    color: blackColorDark,
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
              ),
            ),
          ],
        );
      },
    );
  }
}
