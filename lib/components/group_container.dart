import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GroupContainer extends StatelessWidget {
  final Widget child;
  final String title;
  final EdgeInsets? margin;
  final Color? backgroundColor;

  const GroupContainer(
      {Key? key,
      this.margin,
      this.backgroundColor,
      required this.title,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
        color: backgroundColor,
      ),
      padding: const EdgeInsets.all(5),
      margin: margin,
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.apply(color: Colors.black54),
          ),
          child
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('data', title, showName: false));
  }
}
