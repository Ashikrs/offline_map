import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mapsforge_flutter/core.dart';
import 'package:mapsforge_flutter/maps.dart';

class HomeController extends GetxController {
  ViewModel? viewModel;
  MapModel? mapModel;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  Future<void> loadData() async {
    try {
      // final downloadsDir =
      //     await getExternalStorageDirectories(type: StorageDirectory.downloads);
      // final ByteData data1 =
      //     await rootBundle.load('${downloadsDir?.first.path}/india.map');
      // print(downloadsDir);
      final ByteData data = await rootBundle.load('assets/armenia.map');
      final Uint8List bytes = data.buffer.asUint8List();
      MapFile mapFile = await MapFile.using(bytes, null, null);
      SymbolCache symbolCache = FileSymbolCache();
      DisplayModel displayModel = DisplayModel();
      RenderTheme renderTheme = await RenderThemeBuilder.create(
        displayModel,
        "assets/render_themes/defaultrender.xml",
      );
      JobRenderer jobRenderer = MapDataStoreRenderer(
        mapFile,
        renderTheme,
        symbolCache,
        true,
      );
      TileBitmapCache bitmapCache =
          await FileTileBitmapCache.create(jobRenderer.getRenderKey());
      mapModel = MapModel(
        displayModel: displayModel,
        renderer: jobRenderer,
        symbolCache: symbolCache,
        tileBitmapCache: bitmapCache,
      );

      viewModel = ViewModel(displayModel: displayModel);

      // viewModel!.setMapViewPosition(8.51046, 76.96239);
      viewModel!.setMapViewPosition(40.18511118264506, 44.52407139202347);

      viewModel!.setZoomLevel(11);
      update();
    } catch (e) {
      if (kDebugMode) rethrow;
    }
  }
}
