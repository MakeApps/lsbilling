import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/modules/stocks/bloc/update_category_bloc/category_name_update_bloc.dart';

class CreateCategoryDialog extends StatefulWidget {
  final Future<void> Function() onCreated;
  const CreateCategoryDialog({super.key, required this.onCreated});

  @override
  State<CreateCategoryDialog> createState() => _CreateCategoryDialogState();
}

class _CreateCategoryDialogState extends State<CreateCategoryDialog> {
  final TextEditingController _nameController = TextEditingController();
  bool _submitting = false;

  Future<void> _submit() async {
    final String name = _nameController.text.trim();
    if (name.isEmpty || _submitting) return;
    setState(() => _submitting = true);

    final Map<String, Object> formData = {
      "id": "",
      'spare_category_name': name,
    };
    context.read<CategoryNameUpdateBloc>().add(
          AddCategorySparePart(
            formData: formData,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        backgroundColor: whiteColor,
        shape: const RoundedRectangleBorder(),
        insetPadding: const EdgeInsets.all(20),
        child: BlocListener<CategoryNameUpdateBloc, CategoryNameUpdateState>(
          listenWhen: (prev, curr) =>
              prev.addCategoryStatus != curr.addCategoryStatus,
          listener: (context, state) async {
            if (_submitting &&
                state.addCategoryStatus == AddCategoryStatus.success) {
              if (mounted) setState(() => _submitting = false);
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop(_nameController.text.trim());
              }
            } else if (_submitting &&
                state.addCategoryStatus == AddCategoryStatus.failure) {
              if (mounted) setState(() => _submitting = false);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Expanded(
                      child: Text(
                        'Item Category',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Close',
                      icon:
                          const Icon(Icons.close, size: 20, color: blackColor),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Text(
                  'Category Name:',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: blackColor),
                ),
                const SizedBox(height: 6),
                TextField(
                  style: const TextStyle(fontSize: 13, color: blackColor),
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter category name',
                    hintStyle: TextStyle(fontSize: 13, color: hintTextColor),
                    filled: true,
                    fillColor: textfieldBg,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(width: 0, style: BorderStyle.none),
                    ),
                    contentPadding: EdgeInsets.only(left: 15, right: 20.0),
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(primaryColor),
                        foregroundColor:
                            WidgetStateProperty.all<Color>(whiteColor),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      onPressed: _submitting ? null : _submit,
                      child: Text(
                        _submitting ? 'Adding...' : 'Add',
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
