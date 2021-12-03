import '../model/environment_model.dart';
import 'run_app.dart';

Future<void> main() async {
  await mainBase(AppEnvironment.development);
}
