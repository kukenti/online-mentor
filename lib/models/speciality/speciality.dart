import 'package:json_annotation/json_annotation.dart';
import 'package:online_mentor/core/enums.dart';

part 'speciality.g.dart';

@JsonSerializable(explicitToJson: true)
class Speciality {
  String? name;
  String? code;

  Speciality({
    this.name,
    this.code,
  });

  factory Speciality.fromJson(Map<String, dynamic> json) =>
      _$SpecialityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SpecialityToJson(this);
}
