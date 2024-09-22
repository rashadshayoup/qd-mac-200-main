part of '../text_field.dart';

class _PrefixIcon extends StatelessWidget {
  final IconData? icon;
  final Color color;
  final double size;

  const _PrefixIcon({
    Key? key,
    this.icon,
    this.color = CupertinoColors.black,
    this.size = 32,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Icon(
              icon,
              color: color,
              size: size,
            ),
          )
        : const SizedBox(width: 1);
  }
}
