import 'package:flutter/material.dart';
import 'package:miel_work_request_facility_web/common/functions.dart';
import 'package:miel_work_request_facility_web/common/style.dart';
import 'package:miel_work_request_facility_web/providers/request_facility.dart';
import 'package:miel_work_request_facility_web/screens/step3.dart';
import 'package:miel_work_request_facility_web/widgets/custom_button.dart';
import 'package:miel_work_request_facility_web/widgets/dotted_divider.dart';
import 'package:miel_work_request_facility_web/widgets/form_label.dart';
import 'package:miel_work_request_facility_web/widgets/form_value.dart';
import 'package:miel_work_request_facility_web/widgets/link_text.dart';
import 'package:miel_work_request_facility_web/widgets/responsive_box.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Step2Screen extends StatefulWidget {
  final String shopName;
  final String shopUserName;
  final String shopUserEmail;
  final String shopUserTel;
  final String usePeriod;
  final String remarks;

  const Step2Screen({
    required this.shopName,
    required this.shopUserName,
    required this.shopUserEmail,
    required this.shopUserTel,
    required this.usePeriod,
    required this.remarks,
    super.key,
  });

  @override
  State<Step2Screen> createState() => _Step2ScreenState();
}

class _Step2ScreenState extends State<Step2Screen> {
  @override
  Widget build(BuildContext context) {
    final facilityProvider = Provider.of<RequestFacilityProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 24),
              const Text(
                '施設使用申込フォーム',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SourceHanSansJP-Bold',
                ),
              ),
              const SizedBox(height: 24),
              ResponsiveBox(
                children: [
                  const Text('以下の申込内容で問題ないかご確認ください。'),
                  const SizedBox(height: 8),
                  FormLabel(
                    '店舗名',
                    child: FormValue(widget.shopName),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '店舗責任者名',
                    child: FormValue(widget.shopUserName),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '店舗責任者メールアドレス',
                    child: FormValue(widget.shopUserEmail),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '店舗責任者電話番号',
                    child: FormValue(widget.shopUserTel),
                  ),
                  const SizedBox(height: 24),
                  const DottedDivider(),
                  const SizedBox(height: 16),
                  const Text(
                    '旧梵屋跡の倉庫を使用します (貸出面積：約12㎡)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceHanSansJP-Bold',
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '使用期間',
                    child: FormValue(widget.usePeriod),
                  ),
                  const SizedBox(height: 24),
                  const DottedDivider(),
                  const SizedBox(height: 16),
                  FormLabel(
                    'その他連絡事項',
                    child: FormValue(widget.remarks),
                  ),
                  const SizedBox(height: 16),
                  const DottedDivider(),
                  const SizedBox(height: 32),
                  CustomButton(
                    type: ButtonSizeType.lg,
                    label: '上記内容で申し込む',
                    labelColor: kWhiteColor,
                    backgroundColor: kBlueColor,
                    onPressed: () async {
                      String? error = await facilityProvider.create(
                        shopName: widget.shopName,
                        shopUserName: widget.shopUserName,
                        shopUserEmail: widget.shopUserEmail,
                        shopUserTel: widget.shopUserTel,
                        usePeriod: widget.usePeriod,
                        remarks: widget.remarks,
                      );
                      if (error != null) {
                        if (!mounted) return;
                        showMessage(context, error, false);
                        return;
                      }
                      if (!mounted) return;
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const Step3Screen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: LinkText(
                      label: '入力に戻る',
                      color: kBlueColor,
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
