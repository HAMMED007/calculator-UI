import 'package:get_it/get_it.dart';

import 'model/data_model.dart';

GetIt locator = GetIt.instance;

setupLocator() async {
  locator.registerSingleton<GetDeviceId>(GetDeviceId());
}
