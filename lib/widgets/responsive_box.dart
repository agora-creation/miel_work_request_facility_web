import 'package:flutter/material.dart';
import 'package:miel_work_request_facility_web/common/style.dart';
import 'package:miel_work_request_facility_web/services/responsive.dart';

class ResponsiveBox extends StatelessWidget {
  final List<Widget> children;

  const ResponsiveBox({
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveService.isMobile(context)
          ? ResponsiveService.widthOfScreen(context) * 0.9
          : ResponsiveService.widthOfScreen(context) * 0.8,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: kWhiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }
}
