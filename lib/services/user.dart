import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miel_work_request_facility_web/models/user.dart';

class UserService {
  String collection = 'user';
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> selectList() async {
    List<UserModel> ret = [];
    await firestore
        .collection(collection)
        .orderBy('createdAt', descending: false)
        .get()
        .then((value) {
      for (DocumentSnapshot<Map<String, dynamic>> map in value.docs) {
        ret.add(UserModel.fromSnapshot(map));
      }
    });
    return ret;
  }
}
