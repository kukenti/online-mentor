import 'package:equatable/equatable.dart';
import 'package:online_mentor/models/user/user.dart';

class ProfileState extends Equatable {
  final String? userId;
  final User? user;

  ProfileState({
    this.userId,
    this.user,
  });

  @override
  List<Object?> get props => [
        userId,
        user,
      ];

  ProfileState copyWith({
    String? userId,
    User? user,
  }) =>
      ProfileState(
        userId: userId ?? this.userId,
        user: user ?? this.user,
      );
}
