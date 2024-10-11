import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miel_work_request_facility_web/common/functions.dart';
import 'package:miel_work_request_facility_web/common/style.dart';

class DatetimeRangeForm extends StatelessWidget {
  final DateTime startedAt;
  final Function() startedOnTap;
  final DateTime endedAt;
  final Function() endedOnTap;
  final bool pending;
  final Function(bool?) pendingOnChanged;

  const DatetimeRangeForm({
    required this.startedAt,
    required this.startedOnTap,
    required this.endedAt,
    required this.endedOnTap,
    required this.pending,
    required this.pendingOnChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: kBorderColor)),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '時間部分をタップすると、日時選択ダイアログが画面下部に表示されます。',
            style: TextStyle(
              color: kGreyColor,
              fontSize: 12,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: startedOnTap,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        !pending
                            ? dateText('yyyy年MM月dd日(E)', startedAt)
                            : '----年--月--日(-)',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        !pending ? dateText('HH:mm', startedAt) : '--:--',
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const FaIcon(
                  FontAwesomeIcons.chevronRight,
                  color: kDisabledColor,
                  size: 24,
                ),
                GestureDetector(
                  onTap: endedOnTap,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        !pending
                            ? dateText('yyyy年MM月dd日(E)', endedAt)
                            : '----年--月--日(-)',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        !pending ? dateText('HH:mm', endedAt) : '--:--',
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: kBorderColor)),
            ),
            padding: const EdgeInsets.only(top: 8),
            width: double.infinity,
            child: CheckboxListTile(
              value: pending,
              onChanged: pendingOnChanged,
              title: const Text('未定'),
            ),
          ),
        ],
      ),
    );
  }
}
