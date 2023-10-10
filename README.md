# OFFLINE MAP

A APPLICATION FOR OFFLINE MAP, IN FLUTTER USING RASTER FILES OR .MAP FILES.

## Requirements

- FLUTTER ENVIRONMENT
- QGIS

## DEPENDENCIES

Import the following dependencies from pub.dev and go the basic package requirements as given in the pub.dev documents.

- get (getx pattern - optional)
- asset_fill
- latlong2

### FOR .MAP FILES

- mapsforge_flutter
- path_provider

### FOR RASTER FILES

- flutter_map

## Getting Start

### USING .MAP FILES

Import the following dependencies, as given in the above documents.

Download the .map file from the open source site and store it in the
asset folder in the lib folder in the the flutter project.

Using the mapsforge_flutter do the needed coding, which is given in the pub.dev [mapsforge_flutter](https://pub.dev/packages/mapsforge_flutter),also refer [flutter_maps](https://docs.fleaflet.dev/v/v6-preview/tile-servers/offline-mapping).

#### On the page controller initialize the view model and map model at the top

```dart
ViewModel? viewModel;
MapModel? mapModel;
```

#### Write a function to load the map inside the controller

```dart
Future<void> loadData() async {
    try {
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

      viewModel!.setMapViewPosition(40.18511118264506, 44.52407139202347);

      viewModel!.setZoomLevel(11);
      update();
    } catch (e) {
      if (kDebugMode) rethrow;
    }
  }
```

#### Call the onload function onInit() method

```dart
 @override
  void onInit() {
    loadData();
    super.onInit();
  }
```

#### On the View

```dart
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: GetBuilder<HomeController>(
        builder: (_) {
          if (_.mapModel == null || _.viewModel == null) {
            return const SizedBox();
          }
          return SizedBox(
            height: Get.height,
            width: Get.width,
            child: FlutterMapView(
              mapModel: _.mapModel!,
              viewModel: _.viewModel!,
            ),
          );
        },
      ),
    );
  }
```

### USING RASTER FILES (XYZ FILES)

Import the following dependencies, as given in the above documents.

Using QGIS application generate the RASTER FILES (XYZ FILES) and import insid the asset file as given in the sample code. Using the flutter_map do the needed coding, which is given in the pub.dev [flutter_map](https://pub.dev/packages/flutter_map).

Also import the paths to pubspec.yaml files using [asset_fill](https://pub.dev/packages/asset_fill).

#### ON THE OFFLINE MAP VIEW

```dart
class MapOfflineView extends GetView<MapOfflineController> {
  const MapOfflineView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offline Map')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child:
                  Text('This is an offline map that is showing sample region.'),
            ),
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(8.548824070866914, 76.91735867846106),
                  minZoom: 13,
                  maxZoom: 15,
                  zoom: 15,
                  children: [
                    TileLayer(
                      tileProvider: AssetTileProvider(),
                      maxZoom: 15,
                      urlTemplate: 'assets/map/tvm/{z}/{x}/{y}.png',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```
