import 'package:rxdart/rxdart.dart';

import '../../configurations/serviceLocator/locator.dart';

class EnvironmentBloc {
  final BehaviorSubject<EnvironmentModel> _environmentModel =
      BehaviorSubject<EnvironmentModel>();

  setValues() {
    _environmentModel.sink.add(locator<EnvironmentModel>());
  }

  Stream<EnvironmentModel> get environmentModel => _environmentModel.stream;

  EnvironmentModel get envModelValue => _environmentModel.stream.value;

  closeStream() {
    _environmentModel.close();
  }
}
