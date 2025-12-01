import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_shout_billing/components/no_data_found.dart';
import 'package:local_shout_billing/components/skeleton/listing_skeleton.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/modules/stock/bloc/category_bloc/category_list_bloc.dart';

class PurchesStockCategoryPicker extends StatefulWidget {
  final void Function(int id, String name) onSelected;
  final VoidCallback onCreateRequested;
  const PurchesStockCategoryPicker(
      {super.key,
      required this.onSelected,
      required this.onCreateRequested,
      d});

  @override
  State<PurchesStockCategoryPicker> createState() =>
      _CategoryPickerDialogState();
}

class _CategoryPickerDialogState extends State<PurchesStockCategoryPicker> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          backgroundColor: whiteColor,
          shape: const RoundedRectangleBorder(),
          insetPadding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: SizedBox(
              width: 540,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        const Expanded(
                          child: Text(
                            'Spare part category',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 38,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all<Color>(primaryColor),
                              foregroundColor:
                                  WidgetStateProperty.all<Color>(blackColor),
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
                                fontSize: 13,
                              ),
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
                      controller: _searchController,
                      style: const TextStyle(fontSize: 13, color: blackColor),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        filled: true,
                        fillColor: lightGreyColor,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search,
                              size: 20, color: blackColor),
                          onPressed: () {},
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
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
                        return (state.categoryListStatus ==
                                    CategoryListStatus.failure ||
                                items.isEmpty)
                            ? const NoDataFoundWidget()
                            : ListView.separated(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                itemBuilder: (_, index) {
                                  final item = items[index];
                                  return ListTile(
                                    title: Text(
                                      item.categoryName ?? '',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    onTap: () {
                                      widget.onSelected(
                                        item.id ?? 0,
                                        item.categoryName ?? '',
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    trailing: IconButton(
                                      icon: const Icon(
                                        Icons.edit_outlined,
                                        size: 18,
                                        color: Color(0xFF2E5AAC),
                                      ),
                                      onPressed: () {},
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
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ));
  }
}
