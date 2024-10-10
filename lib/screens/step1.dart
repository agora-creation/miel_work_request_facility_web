import 'package:flutter/material.dart';
import 'package:miel_work_request_facility_web/common/style.dart';
import 'package:miel_work_request_facility_web/screens/step2.dart';
import 'package:miel_work_request_facility_web/widgets/custom_button.dart';
import 'package:miel_work_request_facility_web/widgets/custom_text_field.dart';
import 'package:miel_work_request_facility_web/widgets/dotted_divider.dart';
import 'package:miel_work_request_facility_web/widgets/form_label.dart';
import 'package:miel_work_request_facility_web/widgets/responsive_box.dart';
import 'package:page_transition/page_transition.dart';

class Step1Screen extends StatefulWidget {
  const Step1Screen({super.key});

  @override
  State<Step1Screen> createState() => _Step1ScreenState();
}

class _Step1ScreenState extends State<Step1Screen> {
  TextEditingController shopName = TextEditingController();
  TextEditingController shopUserName = TextEditingController();
  TextEditingController shopUserEmail = TextEditingController();
  TextEditingController shopUserTel = TextEditingController();
  TextEditingController usePeriod = TextEditingController();
  TextEditingController remarks = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  const Text('以下のフォームにご入力いただき、申込を行なってください。'),
                  const SizedBox(height: 8),
                  FormLabel(
                    '店舗名',
                    child: CustomTextField(
                      controller: shopName,
                      textInputType: TextInputType.text,
                      maxLines: 1,
                      hintText: '例）黒潮水産',
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '店舗責任者名',
                    child: CustomTextField(
                      controller: shopUserName,
                      textInputType: TextInputType.text,
                      maxLines: 1,
                      hintText: '例）田中太郎',
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '店舗責任者メールアドレス',
                    child: CustomTextField(
                      controller: shopUserEmail,
                      textInputType: TextInputType.text,
                      maxLines: 1,
                      hintText: '例）tanaka@hirome.co.jp',
                    ),
                  ),
                  const Text(
                    '※このメールアドレス宛に、返答させていただきます',
                    style: TextStyle(
                      color: kRedColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '店舗責任者電話番号',
                    child: CustomTextField(
                      controller: shopUserTel,
                      textInputType: TextInputType.text,
                      maxLines: 1,
                      hintText: '例）090-0000-0000',
                    ),
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
                    child: CustomTextField(
                      controller: usePeriod,
                      textInputType: TextInputType.text,
                      maxLines: 1,
                      hintText: '例）令和元年9月20日〜9月27日',
                    ),
                  ),
                  const SizedBox(height: 24),
                  const DottedDivider(),
                  const SizedBox(height: 16),
                  FormLabel(
                    'その他連絡事項',
                    child: CustomTextField(
                      controller: remarks,
                      textInputType: TextInputType.multiline,
                      maxLines: null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const DottedDivider(),
                  const SizedBox(height: 32),
                  CustomButton(
                    type: ButtonSizeType.lg,
                    label: '入力内容を確認',
                    labelColor: kWhiteColor,
                    backgroundColor: kBlueColor,
                    onPressed: () async {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: Step2Screen(
                            shopName: shopName.text,
                            shopUserName: shopUserName.text,
                            shopUserEmail: shopUserEmail.text,
                            shopUserTel: shopUserTel.text,
                            usePeriod: usePeriod.text,
                            remarks: remarks.text,
                          ),
                        ),
                      );
                    },
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
