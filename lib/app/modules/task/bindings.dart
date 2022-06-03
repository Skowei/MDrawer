import 'package:get/get.dart';
import 'package:mdrawer/app/modules/task/controller/task_controller.dart';

class TaskBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskController>(() => TaskController());
  }
}
