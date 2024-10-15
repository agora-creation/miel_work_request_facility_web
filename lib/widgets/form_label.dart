import 'package:flutter/material.dart';
import 'package:miel_work_request_facility_web/common/style.dart';

class FormLabel extends StatelessWidget {
  final String label;
  final Widget child;
  final bool required;

  const FormLabel(
    this.label, {
    required this.child,
    this.required = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: kBlackColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 4),
            required
                ? const Chip(
                    label: Text(
                      '必須',
                      style: TextStyle(color: kWhiteColor, fontSize: 10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    labelPadding: EdgeInsets.zero,
                    backgroundColor: kRedColor,
                    side: BorderSide.none,
                  )
                : Container(),
          ],
        ),
        const SizedBox(height: 2),
        child,
      ],
    );
  }
}
