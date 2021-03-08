import 'package:Pitch/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future<void> updateUserData(String name, String surname, String email, String phone, String birthDate, String sex) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'surname': surname,
      'email': email,
      'phone': phone,
      'birthDate': birthDate,
      'sex': sex
    });
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      surname: snapshot.data['surname'],
      email: snapshot.data['email'],
      phone: snapshot.data['phone'],
      birthDate: snapshot.data['birthDate'],
      sex: snapshot.data['sex']
    );
  }

  Stream<UserData> get userData{
    return userCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }
}