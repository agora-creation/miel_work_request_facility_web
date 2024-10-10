import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miel_work_request_facility_web/models/user.dart';
import 'package:miel_work_request_facility_web/services/fm.dart';
import 'package:miel_work_request_facility_web/services/request_facility.dart';
import 'package:miel_work_request_facility_web/services/user.dart';

class RequestFacilityProvider with ChangeNotifier {
  final RequestFacilityService _facilityService = RequestFacilityService();
  final UserService _userService = UserService();
  final FmService _fmService = FmService();

  Future<String?> create({
    required String shopName,
    required String shopUserName,
    required String shopUserEmail,
    required String shopUserTel,
    required String usePeriod,
    required String remarks,
  }) async {
    String? error;
    if (shopName == '') return '会社名は必須入力です';
    if (shopUserName == '') return '担当者名は必須入力です';
    if (shopUserEmail == '') return '担当者メールアドレスは必須入力です';
    if (shopUserTel == '') return '担当者電話番号は必須入力です';
    try {
      await FirebaseAuth.instance.signInAnonymously().then((value) {
        String id = _facilityService.id();
        _facilityService.create({
          'id': id,
          'shopName': shopName,
          'shopUserName': shopUserName,
          'shopUserEmail': shopUserEmail,
          'shopUserTel': shopUserTel,
          'usePeriod': usePeriod,
          'remarks': remarks,
          'approval': 0,
          'approvedAt': DateTime.now(),
          'approvalUsers': [],
          'createdAt': DateTime.now(),
        });
      });
      //通知
      List<UserModel> sendUsers = [];
      sendUsers = await _userService.selectList();
      if (sendUsers.isNotEmpty) {
        for (UserModel user in sendUsers) {
          _fmService.send(
            token: user.token,
            title: '社外申請',
            body: '施設使用の申込がありました',
          );
        }
      }
    } catch (e) {
      error = '申込に失敗しました';
    }
    return error;
  }
}
