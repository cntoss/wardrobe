import 'package:get_it/get_it.dart';
import 'package:wardrobe/features/auth/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:wardrobe/features/auth/forgot_password/repository/forgot_password_repository.dart';


import '../../features/auth/login/bloc/login_bloc.dart';
import '../../features/auth/login/repository/login_repository.dart';
import '../../features/auth/register/bloc/register_bloc.dart';
import '../../features/auth/register/repository/register_repository.dart';
import '../../features/auth/splash/bloc/splash_bloc.dart';
import '../../features/auth/splash/repository/splash_repository.dart';
import '../../features/home/profile/profileIndex/repository/profileRepository.dart';
import '../../global/constants/helpers/ui_helper.dart';
import '../../global/constants/icons/iconFromAsset.dart';
import '../../global/widgets/static/bloc/staticDataBloc.dart';
import '../../global/widgets/static/repository/staticDataRepository.dart';
import "../../main/bloc/environmentBloc.dart";
import '../firebase/firebase_config.dart';
import '../repository/api.dart';
import '../theme/size_config.dart';

export '../../features/auth/login/bloc/login_bloc.dart';
export '../../features/auth/login/repository/login_repository.dart';
export '../../features/auth/register/bloc/register_bloc.dart';
export '../../features/auth/register/repository/register_repository.dart';
export '../../features/auth/splash/bloc/splash_bloc.dart';
export '../../features/auth/splash/repository/splash_repository.dart';
export '../../features/home/profile/profileIndex/bloc/profile_bloc.dart';
export '../../features/home/profile/profileIndex/repository/profileRepository.dart';
export '../../global/constants/helpers/ui_helper.dart';
export '../../global/constants/icons/iconFromAsset.dart';
export '../../global/widgets/static/repository/staticDataRepository.dart';
export "../../main/bloc/environmentBloc.dart";
export '../../main/model/environment_model.dart';
export '../firebase/firebase_config.dart';
export '../localStorage/secure_storage.dart';
export '../repository/api.dart';
export '../theme/size_config.dart';

GetIt locator = GetIt.instance;

void setLocator() {
  //*Singleton classes
  //?App Helpers
  locator.registerLazySingleton(() => SizeConfig());
  locator.registerLazySingleton(() => IconFromAsset());
  locator.registerLazySingleton(() => SplashBloc());
  locator.registerLazySingleton(() => UiHelper());
  locator.registerLazySingleton(() => FirebaseConfig());
  //?App Helpers

  //?BLoC
  locator.registerLazySingleton(() => EnvironmentBloc());
  locator.registerLazySingleton(() => LoginBloc());
  locator.registerLazySingleton(() => RegisterBloc());
  locator.registerLazySingleton(() => ForgotPasswordBloc());
  locator.registerLazySingleton(() => StaticDataBloc());

  //
  locator.registerLazySingleton(() => ApiRepository());
  locator.registerLazySingleton(() => SplashRepository());
  locator.registerLazySingleton(() => LoginRepository());
  locator.registerLazySingleton(() => RegisterRepository());
  locator.registerLazySingleton(() => ForgotPasswordRepository());

  locator.registerLazySingleton(() => StaticDataRepository());
  locator.registerLazySingleton(() => ProfileRepository());
  //*Singleton classes


  //*Factory classes
}
