import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'components/prefix_icon.dart';
part 'components/suffix_icon.dart';
part 'components/title.dart';

class AppTextField extends StatefulWidget {
  final String? initialValue;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final Color prefixIconColor;
  final double? prefixIconSize;
  final String title;
  final String hint;
  final TextInputType inputType;
  final int? maxLength;
  final int maxLines;
  final bool isPasswordField;
  final bool required;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry margin;
  final bool autoFocus;
  final bool enabled;
  final TextInputAction textInputAction;
  final Function(String)? onChanged;
  final String? Function(String?)? onValidate;
  final List<TextInputFormatter>? inputFormatters;
  final bool showValid;
  final String error;
  final Color backgroundColor;
  final Color borderColor;
  final BorderRadius? borderRadius;
  final double? fontSize;
  final double borderWidth;
  final bool readOnly;
  final TextAlign textAlign;
  final InputDecoration? decoration;
  final TextStyle? style;
  final bool isVisible;
  final bool isShadow;
  final ValueChanged<String>? onFieldSubmitted;
  final TextEditingController? controller;

  const AppTextField(
      {Key? key,
      this.title = '',
      this.hint = '',
      this.onChanged,
      this.onValidate,
      this.prefixIconColor = Colors.black,
      this.initialValue,
      this.suffixIcon,
      this.margin = const EdgeInsets.symmetric(
        vertical: 0,
      ),
      this.autoFocus = false,
      this.isVisible = true,
      this.inputType = TextInputType.text,
      this.inputFormatters,
      this.maxLength,
      this.maxLines = 1,
      this.enabled = true,
      this.textInputAction = TextInputAction.done,
      this.padding,
      this.isPasswordField = false,
      this.showValid = false,
      this.error = '',
      this.prefixIcon,
      this.required = true,
      this.prefixIconSize,
      this.borderWidth = 1,
      this.borderRadius,
      this.textAlign = TextAlign.start,
      this.backgroundColor = const Color(0xffFFFFFF),
      this.borderColor = const Color(0xffE1E4E8),
      this.fontSize = 15,
      this.readOnly = false,
      this.decoration,
      this.style,
      this.controller,
      this.onFieldSubmitted,
      this.isShadow = false})
      : super(key: key);

  @override
  CoreTextFieldState createState() => CoreTextFieldState();
}

class CoreTextFieldState extends State<AppTextField>
    with AutomaticKeepAliveClientMixin {
  var hidePassword = true;
  var errorVisibility = false;
  var isHovered = false;
  final TextEditingController controller = TextEditingController();
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      controller.text = widget.initialValue!;
      controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
      _focus.addListener(_onFocusChange);
    }
  }

  @override
  bool get wantKeepAlive => true;

  _onFocusChange() {}

  bool get hasPrefixIcon => widget.prefixIcon != null;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.initialValue != null) {
      controller.text = widget.initialValue!;
      controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
    }
    if (!widget.isVisible) {
      controller.text = '';
    }

    return Visibility(
      visible: widget.isVisible,
      child: Container(
        margin: widget.margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: widget.title.isNotEmpty,
              child: InkWell(
                onTap: () {
                  _onFocusChange();
                },
                child: Row(
                  children: [
                    _Title(
                      text: widget.title,

                      // style: widget.titleStyle,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4),
            Container(
              decoration: BoxDecoration(
                  boxShadow: widget.isShadow
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(.15),
                            offset: const Offset(2.0, 2.0), //(x,y)
                            spreadRadius: 10,
                            blurRadius: 20.0,
                          )
                        ]
                      : null),
              child: TextFormField(
                controller: widget.initialValue != null
                    ? controller
                    : widget.controller != null
                        ? widget.controller
                        : null,
                enabled: widget.enabled,
                readOnly: widget.readOnly,
                autocorrect: false,
                textAlign: widget.textAlign,
                minLines: widget.maxLines > 1 ? widget.maxLines : 1,
                maxLines: widget.maxLines > 1 ? widget.maxLines : 1,
                obscureText: widget.isPasswordField && hidePassword,
                autofocus: widget.autoFocus,
                onChanged: widget.onChanged,
                onFieldSubmitted: widget.onFieldSubmitted,
                keyboardType: widget.inputType,
                maxLength: widget.maxLength,
                textInputAction: widget.textInputAction,
                inputFormatters: widget.inputFormatters,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                validator: widget.onValidate ??
                    (value) {
                      if (widget.required && (value == null || value.isEmpty)) {
                        return 'هذا الحقل مطلوب';
                      }
                      return null;
                    },
                onTapOutside: (ev) {},
                cursorColor: Colors.grey,
                style: widget.style ??
                    TextStyle(
                      fontSize: widget.fontSize ?? 16,
                      fontWeight: FontWeight.w500,
                    ),
                decoration: widget.decoration ??
                    InputDecoration(
                        errorMaxLines: 2,
                        contentPadding: widget.padding ??
                            EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                        counterText: '',
                        border: InputBorder.none,
                        filled: true,
                        isDense: true,
                        fillColor: Colors.white,
                        hoverColor: Colors.white,
                        prefixIcon: hasPrefixIcon
                            ? _PrefixIcon(
                                icon: widget.prefixIcon,
                                color: widget.prefixIconColor,
                                size: 16)
                            : null,
                        prefixIconColor: widget.prefixIconColor,
                        suffixIcon: _SuffixIcon(
                          obscureText: widget.isPasswordField,
                          visibility: hidePassword,
                          showValid: widget.showValid,
                          icon: widget.suffixIcon ??
                              (widget.isPasswordField
                                  ? Icon(hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility)
                                  : SizedBox.shrink()),
                          size: 10,
                          onTouch: () =>
                              setState(() => hidePassword = !hidePassword),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 0.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              widget.borderRadius ?? BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: widget.borderColor,
                              width: widget.borderWidth),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              widget.borderRadius ?? BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: widget.borderColor,
                              width: widget.borderWidth),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius:
                              widget.borderRadius ?? BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: widget.borderColor,
                              width: widget.borderWidth),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius:
                              widget.borderRadius ?? BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: widget.borderColor,
                              width: widget.borderWidth),
                        ),
                        errorStyle: TextStyle(
                          color: CupertinoColors.destructiveRed,
                          fontSize: 14.0,
                        ),
                        hintText:
                            widget.hint.isEmpty ? widget.title : widget.hint,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: widget.fontSize ?? 14,
                        )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
