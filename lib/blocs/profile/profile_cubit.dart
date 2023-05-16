import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:online_mentor/blocs/auth/auth_cubit.dart';
import 'package:online_mentor/models/user/user.dart';
import 'package:online_mentor/repositories/image_repository.dart';

import 'profile_state.dart';

@lazySingleton
class ProfileCubit extends Cubit<ProfileState> {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  final AuthCubit _authCubit;
  final ImageRepository imageRepository;

  ProfileCubit(
    this._authCubit,
    this.imageRepository,
  ) : super(ProfileState()) {
    emit(state.copyWith(
      userId: _authCubit.state.user?.uid,
    ));

    _authCubit.stream.listen((event) {
      emit(state.copyWith(
        userId: event.user?.uid,
      ));

      fetchUserProfile();
    });

    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      final userDoc = await usersCollection.doc(state.userId).get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final user = User.fromJson(userData);

        emit(state.copyWith(
          user: user,
        ));
      }
    } catch (error) {
      // Handle the error appropriately
      print('Failed to fetch user profile: $error');
    }
  }

  Future<void> updateUserProfile(User updatedUser) async {
    try {
      await usersCollection.doc(state.userId).update(updatedUser.toJson());
      emit(state.copyWith(
        user: updatedUser,
      ));
    } catch (error) {
      // Handle the error appropriately
      print('Failed to update user profile: $error');
    }
  }

  Future<void> changeAvatar(File file) async {
    try {
      final response = await imageRepository.uploadImage(file, state.userId!);
      updateUserProfile(User.fromJson({
        ...?state.user?.toJson(),
        "avatar": response,
      }));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
