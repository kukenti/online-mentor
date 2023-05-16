// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      age: json['age'] as int?,
      address: json['address'] as String?,
      email: json['email'] as String?,
      userId: json['userId'] as String?,
      avatar: json['avatar'] as String?,
      educationType:
          $enumDecodeNullable(_$EducationTypeEnumMap, json['educationType']),
      specialty: json['specialty'] == null
          ? null
          : Speciality.fromJson(json['specialty'] as Map<String, dynamic>),
      phoneNumber: json['phoneNumber'] as String?,
      language: json['language'] as String?,
      userType: $enumDecode(_$UserTypeEnumMap, json['userType']),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'surname': instance.surname,
      'age': instance.age,
      'address': instance.address,
      'email': instance.email,
      'avatar': instance.avatar,
      'userType': _$UserTypeEnumMap[instance.userType]!,
      'educationType': _$EducationTypeEnumMap[instance.educationType],
      'specialty': instance.specialty?.toJson(),
      'phoneNumber': instance.phoneNumber,
      'language': instance.language,
    };

const _$EducationTypeEnumMap = {
  EducationType.primary: 'primary',
  EducationType.secondary: 'secondary',
  EducationType.higherEducation: 'higherEducation',
  EducationType.vocational: 'vocational',
  EducationType.other: 'other',
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
    )
      ..avatar = json['avatar'] as String?
      ..userType = $enumDecode(_$UserTypeEnumMap, json['userType'])
      ..language = json['language'] as String?;

Map<String, dynamic> _$TeacherToJson(Teacher instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'surname': instance.surname,
      'age': instance.age,
      'address': instance.address,
      'email': instance.email,
      'avatar': instance.avatar,
      'userType': _$UserTypeEnumMap[instance.userType]!,
      'educationType': _$EducationTypeEnumMap[instance.educationType],
      'specialty': instance.specialty?.toJson(),
      'phoneNumber': instance.phoneNumber,
      'language': instance.language,
    };
