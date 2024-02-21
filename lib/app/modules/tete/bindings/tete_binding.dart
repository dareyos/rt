import 'package:get/get.dart';

import '../controllers/tete_controller.dart';

class TeteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeteController>(
      () => TeteController(),
    );
  }
}
