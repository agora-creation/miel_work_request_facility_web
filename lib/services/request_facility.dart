import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miel_work_request_facility_web/models/request_facility.dart';

class RequestFacilityService {
  String collection = 'requestFacility';
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String id() {
    return firestore.collection(collection).doc().id;
  }

  void create(Map<String, dynamic> values) {
    firestore.collection(collection).doc(values['id']).set(values);
  }

  Future<RequestFacilityModel?> selectData(String id) async {
    RequestFacilityModel? ret;
    await firestore.collection(collection).doc(id).get().then((value) {
      ret = RequestFacilityModel.fromSnapshot(value);
    });
    return ret;
  }
}
