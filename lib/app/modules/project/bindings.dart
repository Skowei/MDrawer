import 'package:get/get.dart';
import 'package:mdrawer/app/modules/project/controller/project_controller.dart';

class ProjectBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectController>(() => ProjectController());
  }
}
