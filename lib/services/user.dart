import 'package:diabet/models/brew.dart';
import 'package:diabet/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final String userUid;

  UserService({this.userUid});

  // collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Future updateUserData(String fullname, String phoneNumber, String gender,
      String birthDate, String weight, String height) async {
    await userCollection.document(userUid).setData({
      'name': fullname,
      'phone_number': phoneNumber,
      'gender': gender,
      'birth_date': birthDate,
      'weight': weight,
      'height': height,
    });

    return userData;
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: userUid,
      name: snapshot.data['name'],
      phone: snapshot.data['phone_number'],
      birthDate: snapshot.data['birth_date'],
      gender: snapshot.data['gender'],
      weight: snapshot.data['weight'],
      height: snapshot.data['height'],
    );
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection
        .document(userUid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }
}
