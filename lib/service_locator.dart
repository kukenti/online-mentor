import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:online_mentor/service_locator.config.dart';

final getIt = GetIt.instance;

@InjectableInit(asExtension: false)
Future<void> initDi() async {
  init(
    getIt,
  );
  return getIt.allReady();
}
