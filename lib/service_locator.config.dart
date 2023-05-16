// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:online_mentor/blocs/auth/auth_cubit.dart' as _i7;
import 'package:online_mentor/blocs/login/login_cubit.dart' as _i4;
import 'package:online_mentor/blocs/profiile_edit/profile_edit_cubit.dart'
    as _i9;
import 'package:online_mentor/blocs/profile/profile_cubit.dart' as _i8;
import 'package:online_mentor/blocs/registration/registration_cubit.dart'
    as _i10;
import 'package:online_mentor/blocs/teachers/teachers_cubit.dart' as _i5;
import 'package:online_mentor/repositories/image_repository.dart' as _i3;
import 'package:online_mentor/repositories/user_repository.dart' as _i6;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.ImageRepository>(() => _i3.FirestoreImageRepository());
  gh.lazySingleton<_i4.LoginCubit>(() => _i4.LoginCubit());
  gh.lazySingleton<_i5.TeachersCubit>(() => _i5.TeachersCubit());
  gh.factory<_i6.UserRepository>(() => _i6.FirestoreUserRepository());
  gh.lazySingleton<_i7.AuthCubit>(() => _i7.AuthCubit(gh<_i4.LoginCubit>()));
  gh.lazySingleton<_i8.ProfileCubit>(() => _i8.ProfileCubit(
        gh<_i7.AuthCubit>(),
        gh<_i3.ImageRepository>(),
      ));
  gh.lazySingleton<_i9.ProfileEditCubit>(() => _i9.ProfileEditCubit(
        gh<_i6.UserRepository>(),
        gh<_i8.ProfileCubit>(),
      ));
  gh.lazySingleton<_i10.RegistrationCubit>(
      () => _i10.RegistrationCubit(gh<_i6.UserRepository>()));
  return getIt;
}
