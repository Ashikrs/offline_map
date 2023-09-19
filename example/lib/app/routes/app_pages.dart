import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/map_offline/bindings/map_offline_binding.dart';
import '../modules/map_offline/views/map_offline_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.MAP_OFFLINE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAP_OFFLINE,
      page: () => const MapOfflineView(),
      binding: MapOfflineBinding(),
    ),
  ];
}
