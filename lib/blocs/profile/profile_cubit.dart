// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:online_mentor/models/user/user.dart';
//
// import 'profile_state.dart';
//
// class ProfileCubit extends Cubit<ProfileState> {
//   final CollectionReference usersCollection =
//       FirebaseFirestore.instance.collection('users');
//   final String userId;
//
//   ProfileCubit() : super(ProfileState());
//
//   Future<void> fetchUserProfile() async {
//     try {
//       final userDoc = await usersCollection.doc(userId).get();
//       if (userDoc.exists) {
//         final userData = userDoc.data() as Map<String, dynamic>;
//         final user = User.fromJson(userData, userDoc.id);
//         emit(user);
//       } else {
//         emit(state.copyWith(id: userId));
//       }
//     } catch (error) {
//       // Handle the error appropriately
//       print('Failed to fetch user profile: $error');
//     }
//   }
//
//   Future<void> updateUserProfile(User updatedUser) async {
//     try {
//       await usersCollection.doc(userId).update(updatedUser.toMap());
//       emit(updatedUser);
//     } catch (error) {
//       // Handle the error appropriately
//       print('Failed to update user profile: $error');
//     }
//   }
// }
