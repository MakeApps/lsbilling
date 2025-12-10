import 'package:flutter/material.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_shout_billing/modules/stock/bloc/update_category_bloc/category_name_update_bloc.dart';

class EditCategoryDialog extends StatefulWidget {
  final int id;
  final Future<void> Function(String newName) onUpdated;
  const EditCategoryDialog(
      {super.key, required this.id, required this.onUpdated});

  @override
  State<EditCategoryDialog> createState() => _EditCategoryDialogState();
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  final TextEditingController _nameController = TextEditingController();
  bool _loading = true;
  bool _submitting = false;

  Future<void> _submit() async {
    final String name = _nameController.text.trim();
    if (name.isEmpty || _submitting) return;
    setState(() => _submitting = true);
    Map<String, dynamic> formData = {
      "id": widget.id,
      "spare_category_name": name,
    };
    context.read<CategoryNameUpdateBloc>().add(
          UpdateCategoryName(
            formData: formData,
            id: widget.id.toString(),
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
          listenWhen: (previous, current) =>
              previous.updateCategoryStatus != current.updateCategoryStatus,
          listener: (context, state) async {
            if (_submitting &&
                state.updateCategoryStatus == UpdateCategoryStatus.success) {
              if (mounted) {
                setState(() => _submitting = false);
              }
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop(_nameController.text.trim());
              }
            } else if (_submitting &&
                state.updateCategoryStatus == UpdateCategoryStatus.failure) {
              if (mounted) {
                setState(() => _submitting = false);
              }
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
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Close',
                      icon:
                          const Icon(Icons.close, size: 20, color: whiteColor),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Text(
                  'Category Name:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                BlocBuilder<CategoryNameUpdateBloc, CategoryNameUpdateState>(
                  builder: (context, state) {
                    if (state.updateCategoryStatus ==
                        UpdateCategoryStatus.loading) {
                      return const Padding(
                        padding: EdgeInsets.all(10),
                        child: LinearProgressIndicator(),
                      );
                    }
                    if (state.updateCategoryStatus ==
                        UpdateCategoryStatus.success) {
                      // Prefill from bloc result once
                      if (_loading) {
                        _nameController.text =
                            state.updateCategoryList.categoryName ?? '';
                        _loading = false;
                      }
                    }
                    return TextField(
                      controller: _nameController,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                      decoration: const InputDecoration(
                        hintText: 'Enter category name',
                        filled: true,
                        fillColor: textfieldBg,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                        ),
                        contentPadding: EdgeInsets.only(left: 15, right: 20.0),
                      ),
                    );
                  },
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
                            WidgetStateProperty.all<Color>(blackColor),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                      ),
                      onPressed: _submitting ? null : _submit,
                      child: Text(_submitting ? 'Updating...' : 'Update'),
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
