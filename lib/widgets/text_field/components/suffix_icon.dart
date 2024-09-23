part of '../text_field.dart';

class _SuffixIcon extends StatelessWidget {
  final bool obscureText;
  final bool showValid;
  final bool visibility;
  final double size;
  final Widget icon;
  final GestureTapCallback onTouch;

  const _SuffixIcon({
    required this.obscureText,
    required this.visibility,
    required this.onTouch,
    required this.size,
    required this.icon,
    required this.showValid,
  });

  @override
  Widget build(BuildContext context) {
    return obscureText
        ? GestureDetector(
            onTap: onTouch,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
            ),
          )
        : icon;
  }
}
