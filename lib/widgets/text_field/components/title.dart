part of '../text_field.dart';

class _Title extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const _Title({
    Key? key,
    required this.text,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Text(text, style: style ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
    );
  }
}
