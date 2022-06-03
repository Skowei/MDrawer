import 'package:get/get.dart';

//modules
import 'package:mdrawer/app/modules/error_page.dart';
import 'package:mdrawer/app/modules/home/view/home_page.dart';
import 'package:mdrawer/app/modules/about/view/about_view.dart';
import 'package:mdrawer/app/modules/project/view/project_view.dart';
import 'package:mdrawer/app/modules/project/bindings.dart';
import 'package:mdrawer/app/modules/task/bindings.dart';
import 'package:mdrawer/app/modules/task/view/test_view.dart';
//middlewares
// import 'package:mdrawer/app/core/middleware/auth.dart';

part 'package:mdrawer/app/routes/app_routes.dart';

class AppPages {
  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => HomeView(),
    ),
    GetPage(
      name: Routes.about,
      page: () => AboutView(),
      // middlewares: [
      //   AuthMiddleware(),
      // ],
    ),
    GetPage(
      name: Routes.task,
      page: () => TaskView(),
      binding: TaskBinding(),
    ),
    GetPage(
      name: Routes.projects,
      page: () => ProjectView(),
      binding: ProjectBinding(),
    ),
  ];

  static GetPage unknownView = GetPage(name: '/unknown', page: () => const UnknownView());
}
