import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GroupContainer extends StatelessWidget {
  final Widget child;
  final String? title;
  final EdgeInsets? margin;
  final Color? backgroundColor;

  const GroupContainer({
    super.key,
    this.margin,
    this.backgroundColor,
    this.title,
    required this.child,
  });

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
      child: title != null
          ? Column(
              children: [
                Text(
                  title!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                child
              ],
            )
          : child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('data', title, showName: false));
  }
}
