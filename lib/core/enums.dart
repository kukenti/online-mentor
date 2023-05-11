enum UserType {
  student,
  teacher,
}

extension UserTypeExt on UserType {
  static const keyMap = {
    UserType.student: "student",
    UserType.teacher: "teacher",
  };

  static const labelMap = {
    UserType.student: "Студент",
    UserType.teacher: "Учитель",
  };

  String? get key => keyMap[this];

  String? get label => labelMap[this];
}

enum EducationType {
  primary,
  secondary,
  higherEducation,
  vocational,
  other,
}

extension EducationTypeExt on EducationType {
  static const keyMap = {
    EducationType.primary: "primary",
    EducationType.secondary: "secondary",
    EducationType.higherEducation: "higherEducation",
    EducationType.vocational: "vocational",
    EducationType.other: "other",
  };

  static const labelMap = {
    EducationType.primary: "начальное образование",
    EducationType.secondary: "среднее образование",
    EducationType.higherEducation: "высшее образование",
    EducationType.vocational: "профессиональное образование",
    EducationType.other: "другое",
  };

  String? get key => keyMap[this];

  String? get label => labelMap[this];
}
