import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapsforge_flutter/core.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
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
}
