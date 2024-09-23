import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Widget? icon;
  final void Function()? onPressed;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final Color? fontColor;
  final String? fontFamily;
  final FontWeight fontWeight;
  final Color? foregroundColor;
  final Color backgroundColor;
  final BorderRadius radius;
  final Gradient? gradient;
  final Color? disabledBackgroundColor;
  final BoxBorder? border;
  final double width;
  final double? height;
  final bool isDisable;
  final bool visible;
  final List<BoxShadow>? boxShadow;

  const AppButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.fontSize = 17,
    this.icon,
    this.gradient,
    this.border,
    this.isDisable = false,
    this.fontColor,
    this.fontFamily,
    this.foregroundColor,
    this.backgroundColor = const Color.fromARGB(255, 139, 36, 83),
    this.disabledBackgroundColor,
    this.radius = const BorderRadius.all(Radius.circular(6.0)),
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    this.width = double.infinity,
    this.boxShadow,
    this.height,
    this.fontWeight = FontWeight.bold,
    this.visible = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        // padding: padding,
        height: height ?? 70,
        margin: margin,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: width),
          child: icon != null
              ? ElevatedButton.icon(
                  icon: icon!,
                  label: Text(text,
                      style: TextStyle(
                        color: fontColor ?? Colors.white,
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                      )),
                  onPressed: isDisable ? null : onPressed,
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(0.0),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      backgroundColor,
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(disabledBackgroundColor ?? Colors.white),
                    shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: radius)),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding),
                  ),
                )
              : GestureDetector(
                  onTap: isDisable ? null : onPressed,
                  child: Container(
                      decoration: BoxDecoration(
                          color: isDisable ? disabledBackgroundColor : backgroundColor,
                          gradient: gradient,
                          border: border,
                          boxShadow: boxShadow,
                          borderRadius: radius),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              flex: 5,
                              child: Center(
                                child: Text(
                                  text,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: fontColor ?? Colors.white,
                                    fontSize: fontSize,
                                    fontWeight: fontWeight,
                                    fontFamily: fontFamily,
                                  ),
                                ),
                              )),
                        ],
                      )),
                ),
        ),
      ),
    );
  }
}
