// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      userId: json['userId'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      age: json['age'] as int,
      address: json['address'] as String,
      email: json['email'] as String,
      language: json['language'] as String?,
    )..userType = $enumDecode(_$UserTypeEnumMap, json['userType']);

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'surname': instance.surname,
      'age': instance.age,
      'address': instance.address,
      'email': instance.email,
      'userType': _$UserTypeEnumMap[instance.userType]!,
      'language': instance.language,
    };

const _$UserTypeEnumMap = {
  UserType.student: 'student',
  UserType.teacher: 'teacher',
};

Teacher _$TeacherFromJson(Map<String, dynamic> json) => Teacher(
      userId: json['userId'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      age: json['age'] as int?,
      address: json['address'] as String?,
      email: json['email'] as String?,
      educationType:
          $enumDecodeNullable(_$EducationTypeEnumMap, json['educationType']),
      specialty: json['specialty'] == null
          ? null
          : Speciality.fromJson(json['specialty'] as Map<String, dynamic>),
      phoneNumber: json['phoneNumber'] as String?,
    )..userType = $enumDecode(_$UserTypeEnumMap, json['userType']);

Map<String, dynamic> _$TeacherToJson(Teacher instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'surname': instance.surname,
      'age': instance.age,
      'address': instance.address,
      'email': instance.email,
      'userType': _$UserTypeEnumMap[instance.userType]!,
      'educationType': _$EducationTypeEnumMap[instance.educationType],
      'specialty': instance.specialty?.toJson(),
      'phoneNumber': instance.phoneNumber,
    };

const _$EducationTypeEnumMap = {
  EducationType.primary: 'primary',
  EducationType.secondary: 'secondary',
  EducationType.higherEducation: 'higherEducation',
  EducationType.vocational: 'vocational',
  EducationType.other: 'other',
};
