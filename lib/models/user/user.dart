import 'package:json_annotation/json_annotation.dart';
import 'package:online_mentor/core/enums.dart';
import 'package:online_mentor/models/speciality/speciality.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  String userId;
  String name;
  String surname;
  int age;
  String address;
  String email;
  String? avatar;
  UserType userType;
  EducationType? educationType;
  Speciality? specialty;
  String? phoneNumber;
  String? language;

  User({
    String? name,
    String? surname,
    int? age,
    String? address,
    String? email,
    String? userId,
    this.avatar,
    this.educationType,
    this.specialty,
    this.phoneNumber,
    this.language,
    required this.userType,
  })  : userId = userId ?? '',
        name = name ?? '',
        surname = surname ?? '',
        age = age ?? 0,
        address = address ?? '',
        email = email ?? '';

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Teacher extends User {
  Teacher({
    String? userId,
    String? name,
    String? surname,
    int? age,
    String? address,
    String? email,
    EducationType? educationType,
    Speciality? specialty,
    String? phoneNumber,
  }) : super(
          userId: userId,
          name: name,
          surname: surname,
          age: age,
          address: address,
          email: email,
          userType: UserType.teacher,
          educationType: educationType,
          specialty: specialty,
          phoneNumber: phoneNumber,
        );

  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TeacherToJson(this);
}
