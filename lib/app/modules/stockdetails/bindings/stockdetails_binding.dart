import 'package:get/get.dart';

import '../controllers/stockdetails_controller.dart';

class StockdetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StockdetailsController>(
      () => StockdetailsController(),
    );
  }
}
