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
import 'package:online_mentor/blocs/auth/auth_cubit.dart' as _i6;
import 'package:online_mentor/blocs/login/login_cubit.dart' as _i3;
import 'package:online_mentor/blocs/registration/registration_cubit.dart'
    as _i7;
import 'package:online_mentor/blocs/teachers/teachers_cubit.dart' as _i4;
import 'package:online_mentor/repositories/user_repository.dart' as _i5;

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
  gh.lazySingleton<_i3.LoginCubit>(() => _i3.LoginCubit());
  gh.lazySingleton<_i4.TeachersCubit>(() => _i4.TeachersCubit());
  gh.factory<_i5.UserRepository>(() => _i5.FirestoreUserRepository());
  gh.lazySingleton<_i6.AuthCubit>(() => _i6.AuthCubit(gh<_i3.LoginCubit>()));
  gh.lazySingleton<_i7.RegistrationCubit>(
      () => _i7.RegistrationCubit(gh<_i5.UserRepository>()));
  return getIt;
}
