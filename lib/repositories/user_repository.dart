import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:online_mentor/models/user/user.dart';

abstract class UserRepository {
  Future<void> saveUser(User user);
}

@Injectable(as: UserRepository)
class FirestoreUserRepository implements UserRepository {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Future<void> saveUser(User user) async {
    await _usersCollection.doc(user.userId).set(user.toJson());
  }
}