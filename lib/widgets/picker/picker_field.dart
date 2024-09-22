import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class PickerModel {
  String id = '';
  String name = '';

  PickerModel({required this.id, required this.name});
}

class AppPicker<T> extends StatefulWidget {
  final String hintText;
  final List<String> options;
  final List<PickerModel> items;
  final List<String> selectedOptions;
  final String value;
  final String title;
  final String note;
  final String? fontFamily;
  final double titleFontSize;
  final void Function(String?) onChanged;
  final IconData icon;
  final Color iconColor;
  final Color? backgroundColor;
  final String textError;
  final Color borderSideColor;
  final Color fontColor;
  final double horizontalPadding;
  final double fontSize;
  final double iconSize;
  final double? iconSpace;
  final double height;
  final double radius;
  final bool center;
  final bool isExpanded;
  final bool required;
  final bool isMultiSelect;
  final bool isVisible;
  final bool isShadow;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Function()? onRefresh;

  const AppPicker({
    this.hintText = '',
    this.title = '',
    this.options = const [],
    this.items = const [],
    this.selectedOptions = const [],
    this.value = '',
    required this.onChanged,
    this.icon = Icons.arrow_drop_down,
    this.iconColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.textError = '',
    this.borderSideColor = const Color(0xffE1E4E8),
    this.fontColor = Colors.black,
    this.horizontalPadding = 15,
    this.fontSize = 14,
    this.iconSize = 25,
    this.radius = 5,
    this.height = 50,
    this.titleFontSize = 14,
    this.iconSpace,
    this.note = '',
    this.center = false,
    this.isExpanded = false,
    this.isShadow = false,
    this.isVisible = true,
    this.required = true,
    this.isMultiSelect = false,
    this.margin = const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    this.padding = const EdgeInsets.all(5.0),
    this.onRefresh,
    this.fontFamily,
  });

  @override
  State<AppPicker> createState() => _AppPickerState();
}

class _AppPickerState extends State<AppPicker> {
  String selectedItem = '';

  @override
  void initState() {
    selectedItem = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items
        .firstWhere((element) => element.id == selectedItem, orElse: () => PickerModel(id: '', name: ''))
        .name
        .isEmpty) {
      selectedItem = '';
    }

    return Visibility(
      visible: widget.isVisible,
      child: widget.center
          ? Center(
              child: _buildPicker,
            )
          : _buildPicker,
    );
  }

  Widget get _buildPicker {
    return Container(
      margin: widget.margin,
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          canvasColor: widget.backgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: widget.title.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: widget.titleFontSize,
                            fontWeight: FontWeight.bold,
                            fontFamily: widget.fontFamily,
                          ),

                          // style: widget.titleStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: widget.height,
              padding: widget.padding,
              decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(widget.radius),
                  border: Border.all(
                    color: widget.borderSideColor,
                  ),
                  boxShadow: widget.isShadow
                      ? [
                          BoxShadow(
                            color: widget.borderSideColor,
                            offset: const Offset(2.0, 2.0), //(x,y)
                            spreadRadius: 10,
                            blurRadius: 20.0,
                          )
                        ]
                      : null),
              child: DropdownButton2<String>(
                value: selectedItem.isEmpty ? null : selectedItem,
                style: TextStyle(
                  color: widget.fontColor,
                  fontSize: widget.fontSize,
                  fontFamily: widget.fontFamily,
                ),
                isExpanded: widget.isExpanded,
                hint: Text(
                  widget.hintText.isEmpty ? widget.title : widget.hintText,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: widget.fontSize,
                    fontFamily: widget.fontFamily,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Colors.white,
                  ),
                  elevation: 0,
                  offset: const Offset(0, -5),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thumbColor: MaterialStateProperty.all<Color>(Colors.black),
                    thickness: MaterialStateProperty.all<double>(4),
                    thumbVisibility: MaterialStateProperty.all<bool>(true),
                  ),
                ),
                underline: const SizedBox.shrink(),
                items: widget.items.isEmpty
                    ? widget.options.map((String item) {
                        return DropdownMenuItem(
                            value: item,
                            child: widget.isMultiSelect
                                ? Row(
                                    children: widget.selectedOptions
                                        .map((item) => Container(
                                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                                              child: Text(
                                                item,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: widget.fontSize,
                                                  color: widget.fontColor,
                                                  fontFamily: widget.fontFamily,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  )
                                : Text(
                                    item,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: widget.fontColor,
                                        fontSize: widget.fontSize,
                                        fontFamily: widget.fontFamily),
                                  ));
                      }).toList()
                    : widget.items.map((PickerModel item) {
                        return DropdownMenuItem(
                          value: item.id,
                          child: widget.isMultiSelect
                              ? Row(
                                  children: widget.selectedOptions
                                      .map((item) => Container(
                                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                                            child: Text(
                                              item,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: widget.fontSize,
                                                color: widget.fontColor,
                                                fontFamily: widget.fontFamily,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                )
                              : Text(item.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: widget.fontSize,
                                    color: widget.fontColor,
                                    fontFamily: widget.fontFamily,
                                  )),
                        );
                      }).toList(),
                onChanged: (newValue) {
                  widget.onChanged(newValue);
                  setState(() {
                    if (widget.items.isNotEmpty) {
                      selectedItem = newValue!;
                    } else {
                      selectedItem = newValue!;
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
