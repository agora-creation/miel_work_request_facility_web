import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miel_work_request_facility_web/common/custom_date_time_picker.dart';
import 'package:miel_work_request_facility_web/common/functions.dart';
import 'package:miel_work_request_facility_web/common/style.dart';
import 'package:miel_work_request_facility_web/models/request_facility.dart';
import 'package:miel_work_request_facility_web/providers/request_facility.dart';
import 'package:miel_work_request_facility_web/screens/step2.dart';
import 'package:miel_work_request_facility_web/services/request_facility.dart';
import 'package:miel_work_request_facility_web/widgets/attached_file_list.dart';
import 'package:miel_work_request_facility_web/widgets/custom_button.dart';
import 'package:miel_work_request_facility_web/widgets/custom_text_field.dart';
import 'package:miel_work_request_facility_web/widgets/datetime_range_form.dart';
import 'package:miel_work_request_facility_web/widgets/dotted_divider.dart';
import 'package:miel_work_request_facility_web/widgets/form_label.dart';
import 'package:miel_work_request_facility_web/widgets/form_value.dart';
import 'package:miel_work_request_facility_web/widgets/responsive_box.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';

class Step1Screen extends StatefulWidget {
  const Step1Screen({super.key});

  @override
  State<Step1Screen> createState() => _Step1ScreenState();
}

class _Step1ScreenState extends State<Step1Screen> {
  RequestFacilityService facilityService = RequestFacilityService();
  TextEditingController companyName = TextEditingController();
  TextEditingController companyUserName = TextEditingController();
  TextEditingController companyUserEmail = TextEditingController();
  TextEditingController companyUserTel = TextEditingController();
  PlatformFile? pickedUseLocationFile;
  DateTime useStartedAt = DateTime.now();
  DateTime useEndedAt = DateTime.now();
  bool useAtPending = false;
  List<PlatformFile> pickedAttachedFiles = [];

  void _getPrm() async {
    String? id = Uri.base.queryParameters['id'];
    if (id == null) return;
    RequestFacilityModel? facility = await facilityService.selectData(id);
    if (facility == null) return;
    companyName.text = facility.companyName;
    companyUserName.text = facility.companyUserName;
    companyUserEmail.text = facility.companyUserEmail;
    companyUserTel.text = facility.companyUserTel;
    useStartedAt = facility.useStartedAt;
    useEndedAt = facility.useEndedAt;
    useAtPending = facility.useAtPending;
    setState(() {});
  }

  @override
  void initState() {
    useStartedAt = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      10,
      0,
      0,
    );
    useEndedAt = useStartedAt.add(
      const Duration(days: 7, hours: 2),
    );
    _getPrm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final facilityProvider = Provider.of<RequestFacilityProvider>(context);
    int useAtDaysPrice = 0;
    if (!useAtPending) {
      int useAtDays = useEndedAt.difference(useStartedAt).inDays;
      int price = 1200;
      useAtDaysPrice = price * useAtDays;
    }
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
                  const SizedBox(height: 16),
                  const DottedDivider(),
                  const SizedBox(height: 16),
                  const Text(
                    '申込者情報',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceHanSansJP-Bold',
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '店舗名',
                    required: true,
                    child: CustomTextField(
                      controller: companyName,
                      textInputType: TextInputType.text,
                      maxLines: 1,
                      hintText: '例）明神水産',
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '店舗責任者名',
                    required: true,
                    child: CustomTextField(
                      controller: companyUserName,
                      textInputType: TextInputType.text,
                      maxLines: 1,
                      hintText: '例）田中太郎',
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '店舗責任者メールアドレス',
                    required: true,
                    child: CustomTextField(
                      controller: companyUserEmail,
                      textInputType: TextInputType.text,
                      maxLines: 1,
                      hintText: '例）tanaka@hirome.co.jp',
                    ),
                  ),
                  const Text(
                    '※このメールアドレス宛に、お問合せさせていただきます',
                    style: TextStyle(
                      color: kRedColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceHanSansJP-Bold',
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '店舗責任者電話番号',
                    required: true,
                    child: CustomTextField(
                      controller: companyUserTel,
                      textInputType: TextInputType.text,
                      maxLines: 1,
                      hintText: '例）090-0000-0000',
                    ),
                  ),
                  const SizedBox(height: 16),
                  const DottedDivider(),
                  const SizedBox(height: 16),
                  const Text(
                    '旧梵屋跡の倉庫を使用します (貸出面積：約12㎡)',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceHanSansJP-Bold',
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '使用場所を記したPDFファイル',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomButton(
                          type: ButtonSizeType.sm,
                          label: 'ファイル選択',
                          labelColor: kWhiteColor,
                          backgroundColor: kGreyColor,
                          onPressed: () async {
                            final result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['pdf'],
                              withData: true,
                            );
                            if (result == null) return;
                            setState(() {
                              pickedUseLocationFile = result.files.first;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '使用予定日時',
                    child: DatetimeRangeForm(
                      startedAt: useStartedAt,
                      startedOnTap: () async =>
                          await CustomDateTimePicker().picker(
                        context: context,
                        init: useStartedAt,
                        title: '使用予定開始日時を選択',
                        onChanged: (value) {
                          setState(() {
                            useStartedAt = value;
                          });
                        },
                      ),
                      endedAt: useEndedAt,
                      endedOnTap: () async =>
                          await CustomDateTimePicker().picker(
                        context: context,
                        init: useEndedAt,
                        title: '使用予定終了日時を選択',
                        onChanged: (value) {
                          setState(() {
                            useEndedAt = value;
                          });
                        },
                      ),
                      pending: useAtPending,
                      pendingOnChanged: (value) {
                        setState(() {
                          useAtPending = value ?? false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '使用料合計(税抜)',
                    child: FormValue(
                      '${NumberFormat("#,###").format(useAtDaysPrice)}円',
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '※使用料：1,200円(税抜)／1日',
                    style: TextStyle(
                      color: kRedColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceHanSansJP-Bold',
                    ),
                  ),
                  const Text(
                    '※使用期間中は、旧梵屋跡の内側および外側のシャッターの鍵をお渡しいたします。貴店で厳重な管理をお願いします。また使用終了後は直ちにインフォメーションまで返却してください。',
                    style: TextStyle(
                      color: kRedColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceHanSansJP-Bold',
                    ),
                  ),
                  const Text(
                    '※使用料につきましては、使用終了後、速やかにインフォメーションにてお支払いください。',
                    style: TextStyle(
                      color: kRedColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceHanSansJP-Bold',
                    ),
                  ),
                  const Text(
                    '※使用後は、清掃をお願いします。',
                    style: TextStyle(
                      color: kRedColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceHanSansJP-Bold',
                    ),
                  ),
                  const Text(
                    '※使用期間中、既に置いてあった商品などの損害については責任を負いかねますのでご了承ください。',
                    style: TextStyle(
                      color: kRedColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceHanSansJP-Bold',
                    ),
                  ),
                  const Text(
                    '※使用期間中、鍵を紛失したり、貴店の責により損害を与え修理などが必要となった場合には、修理費用実費をご請求させていただきます。',
                    style: TextStyle(
                      color: kRedColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceHanSansJP-Bold',
                    ),
                  ),
                  const SizedBox(height: 16),
                  const DottedDivider(),
                  const SizedBox(height: 16),
                  FormLabel(
                    '添付ファイル',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomButton(
                          type: ButtonSizeType.sm,
                          label: 'ファイル選択',
                          labelColor: kWhiteColor,
                          backgroundColor: kGreyColor,
                          onPressed: () async {
                            final result = await FilePicker.platform.pickFiles(
                              type: FileType.any,
                            );
                            if (result == null) return;
                            pickedAttachedFiles.addAll(result.files);
                            setState(() {});
                          },
                        ),
                        const SizedBox(height: 4),
                        Column(
                          children: pickedAttachedFiles.map((file) {
                            return AttachedFileList(
                              fileName: p.basename(file.name),
                              onTap: () {
                                pickedAttachedFiles.remove(file);
                                setState(() {});
                              },
                              isClose: true,
                            );
                          }).toList(),
                        ),
                      ],
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
                      String? error = await facilityProvider.check(
                        companyName: companyName.text,
                        companyUserName: companyUserName.text,
                        companyUserEmail: companyUserEmail.text,
                        companyUserTel: companyUserTel.text,
                      );
                      if (error != null) {
                        if (!mounted) return;
                        showMessage(context, error, false);
                        return;
                      }
                      if (!mounted) return;
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: Step2Screen(
                            companyName: companyName.text,
                            companyUserName: companyUserName.text,
                            companyUserEmail: companyUserEmail.text,
                            companyUserTel: companyUserTel.text,
                            pickedUseLocationFile: pickedUseLocationFile,
                            useStartedAt: useStartedAt,
                            useEndedAt: useEndedAt,
                            useAtPending: useAtPending,
                            pickedAttachedFiles: pickedAttachedFiles,
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
