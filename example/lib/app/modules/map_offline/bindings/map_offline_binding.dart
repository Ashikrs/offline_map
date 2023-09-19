import 'package:get/get.dart';

import '../controllers/map_offline_controller.dart';

class MapOfflineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapOfflineController>(
      () => MapOfflineController(),
    );
  }
}
