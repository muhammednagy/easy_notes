import 'package:easy_notes/services/api/CRUDModel.dart';
import 'package:easy_notes/services/api/api.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => Api('notes'));
  locator.registerLazySingleton(() => CRUDModel());
}
