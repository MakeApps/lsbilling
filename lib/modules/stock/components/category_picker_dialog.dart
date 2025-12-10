import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_shout_billing/components/no_data_found.dart';
import 'package:local_shout_billing/components/skeleton/listing_skeleton.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/modules/stock/bloc/category_bloc/category_list_bloc.dart';

class CategoryPickerDialog extends StatefulWidget {
  final void Function(int id, String name) onSelected;
  final VoidCallback onCreateRequested;
  final void Function(int id) onEditRequested;
  const CategoryPickerDialog({
    super.key,
    required this.onSelected,
    required this.onCreateRequested,
    required this.onEditRequested,
  });

  @override
  State<CategoryPickerDialog> createState() => _CategoryPickerDialogState();
}

class _CategoryPickerDialogState extends State<CategoryPickerDialog> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        backgroundColor: whiteColor,
        shape: const RoundedRectangleBorder(),
        insetPadding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: constraints.maxHeight * 0.8,
                minHeight: 200,
              ),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 540,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: <Widget>[
                            const Expanded(
                              child: Text(
                                'Item Category',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          primaryColor),
                                  foregroundColor:
                                      WidgetStateProperty.all<Color>(
                                          whiteColor),
                                  shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ),
                                onPressed: widget.onCreateRequested,
                                child: const Text(
                                  'Create',
                                  style: TextStyle(
                                      color: blackColorDark, fontSize: 13),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              height: 38,
                              child: IconButton(
                                tooltip: 'Close',
                                icon: const Icon(Icons.close,
                                    size: 20, color: blackColor),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          style:
                              const TextStyle(fontSize: 13, color: blackColor),
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                                fontSize: 13, color: hintTextColor),
                            hintText: 'Search',
                            filled: true,
                            fillColor: lightGreyColor,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search,
                                  size: 18, color: hintTextColor),
                              onPressed: () {},
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide:
                                  BorderSide(width: 0, style: BorderStyle.none),
                            ),
                            contentPadding:
                                const EdgeInsets.only(left: 15, right: 20.0),
                          ),
                          onChanged: (value) =>
                              context.read<CategoryListBloc>().add(
                                    FetchCategoryList(
                                      status: CategoryListStatus.searching,
                                      searchKeyword: value.trim(),
                                    ),
                                  ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Flexible(
                        child: BlocBuilder<CategoryListBloc, CategoryListState>(
                          builder: (context, state) {
                            if (state.categoryListStatus ==
                                    CategoryListStatus.initial ||
                                state.categoryListStatus ==
                                    CategoryListStatus.loading) {
                              return const Padding(
                                padding: EdgeInsets.all(8),
                                child: Skeleton(),
                              );
                            }
                            final items = state.categoryItems;
                            if (state.categoryListStatus ==
                                    CategoryListStatus.failure ||
                                items.isEmpty) {
                              return const NoDataFoundWidget();
                            }

                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              itemBuilder: (_, index) {
                                final item = items[index];
                                return ListTile(
                                  title: Text(
                                    item.categoryName ?? '',
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onTap: () {
                                    widget.onSelected(
                                        item.id ?? 0, item.categoryName ?? '');
                                    Navigator.of(context).pop();
                                  },
                                  trailing: IconButton(
                                    icon: const Icon(Icons.edit_outlined,
                                        size: 16, color: blueColor),
                                    onPressed: () {
                                      widget.onEditRequested(item.id ?? 0);
                                    },
                                  ),
                                );
                              },
                              separatorBuilder: (_, __) =>
                                  const Divider(height: 1),
                              itemCount: items.length,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
