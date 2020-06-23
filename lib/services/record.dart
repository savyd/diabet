import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabet/models/record.dart';

class RecordService {
  final CollectionReference recordCollection =
      Firestore.instance.collection("user_records");

  Future<void> createRecord(
      {String userUid, String date, String time, String sugarLevel}) async {
    await recordCollection.add({
      'user_uid': userUid,
      'date': date,
      'time': time,
      'sugar_level': sugarLevel
    });
  }

  Future<void> updateRecord({String recordUid, String userUid, String date, String time, String sugarLevel}) async {
    await recordCollection.document(recordUid).setData({
      'user_uid': userUid,
      'date': date,
      'time': time,
      'sugar_level': sugarLevel
    });
  }

  Future<void> deleteRecord({String recordUid}) async {
    await recordCollection.document(recordUid).delete();
  }

  List<Record> _recordListsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((data) {
      return Record(
          userUid: data['user_uid'],
          date: data['date'],
          time: data['time'],
          sugarLevel: data['sugar_level']);
    }).toList();
  }

  Record _recordFromSnapshot(DocumentSnapshot snapshot) {
    return Record(
        userUid: snapshot.data['user_uid'],
        date: snapshot.data['date'],
        time: snapshot.data['time'],
        sugarLevel: snapshot.data['sugar_level']);
  }

  Stream<List<Record>> recordLists(String userUid) {
    return recordCollection
        .where('user_uid', isEqualTo: userUid)
        .snapshots()
        .map(_recordListsFromSnapshot);
  }

  Stream<Record> recordDetail(String recordUid) {
    return recordCollection
        .document(recordUid)
        .snapshots()
        .map(_recordFromSnapshot);
  }
}
