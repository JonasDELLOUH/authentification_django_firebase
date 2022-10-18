import 'package:cloud_firestore/cloud_firestore.dart';

class Member{
  late String uid;
  late String fullName;
  late String mail;
  late String phone;
  late String? imageUrl;
  late DocumentReference<Map<String, dynamic>> ref;
  late String documentId;

  Member(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    ref = snapshot.reference;
    uid = snapshot.id;
    Map<String, dynamic>? datas = snapshot.data();
    print(datas);
    mail = datas?["mail"];
    phone = datas?["phone"];
    fullName = datas?["name"];
    imageUrl = datas?["imageUrl"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullName": fullName,
      "imageUrl": imageUrl,
      "mail": mail,
      "phone": phone
    };
  }
}