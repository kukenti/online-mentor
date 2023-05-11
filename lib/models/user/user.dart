import 'package:json_annotation/json_annotation.dart';
import 'package:online_mentor/core/enums.dart';
import 'package:online_mentor/models/speciality/speciality.dart';

part 'user.g.dart';

abstract class User {
  String userId;
  String name;
  String surname;
  int age;
  String address;
  String email;
  UserType userType;

  User(
    this.userId,
    this.name,
    this.surname,
    this.age,
    this.address,
    this.email, {
    required this.userType,
  });

  Map<String, dynamic> toJson();
}

@JsonSerializable(explicitToJson: true)
class Student extends User {
  String? language;

  Student({
    required String userId,
    required String name,
    required String surname,
    required int age,
    required String address,
    required String email,
    this.language,
  }) : super(
          userId,
          name,
          surname,
          age,
          address,
          email,
          userType: UserType.student,
        );

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StudentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Teacher extends User {
  EducationType? educationType;
  Speciality? specialty;
  String? phoneNumber;

  Teacher({
    String? userId,
    String? name,
    String? surname,
    int? age,
    String? address,
    String? email,
    this.educationType,
    this.specialty,
    this.phoneNumber,
  }) : super(
          userId ?? '',
          name ?? '',
          surname ?? '',
          age ?? 0,
          address ?? '',
          email ?? '',
          userType: UserType.teacher,
        );

  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TeacherToJson(this);
}
