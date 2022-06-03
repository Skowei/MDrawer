// import 'package:mdrawer/app/modules/task/data/task_data.dart';
import 'dart:io';

import 'package:mdrawer/app/modules/project/model/project.dart';
import 'package:mdrawer/app/modules/task/controller/task_controller.dart';
import 'package:mdrawer/app/routes/app_pages.dart';
import 'package:mdrawer/common.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class ProjectController extends GetxController with StateMixin<RxList<Project>> {
  Box<Project>? projectsBox;
  var uuid = Uuid();

  @override
  void onInit() async {
    super.onInit();

    // To imitate network connection
    await Future.delayed(const Duration(seconds: 1));

    // Get data and return status
    try {
      projectsBox = Hive.box('projects');
      RxList<Project> projects = RxList<Project>();
      projects.addAll(projectsBox!.values);

      change(projects, status: RxStatus.success());
    } catch (error) {
      change(null, status: RxStatus.error(error.toString()));
    }
  }

  void openProject(Project project) {
    Get.lazyPut<TaskController>(() => TaskController());
    final TaskController taskController = Get.find();
    taskController.openProject(project);
    Get.toNamed(Routes.task);
  }

  void addProject(String name, String description, Color color) {
    String id = uuid.v4();
    final project = Project(
      id: id,
      name: name,
      description: description,
      color: '#${color.value.toRadixString(16).padLeft(6, '0')}',
      table: id,
    );
    state!.add(project);
    projectsBox!.add(project);
    refresh();
  }

  void updateProject(Project current, Project project) {
    projectsBox!.putAt(state!.indexOf(current), project);
    state![state!.indexOf(current)] = project;
    refresh();
  }

  void swap(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    //swap state
    Project project = state![oldIndex];
    state!.remove(project);
    state!.insert(newIndex, project);
    //swap database
    final oldItem = projectsBox!.getAt(oldIndex);
    final newItem = projectsBox!.getAt(newIndex);
    projectsBox!.putAt(oldIndex, newItem!);
    projectsBox!.putAt(newIndex, oldItem!);

    refresh();
  }

  void deleteProject(Project project) {
    Project tmp = project;
    final int index = state!.indexOf(project);
    projectsBox!.deleteAt(index);
    state!.removeAt(index);

    Get.snackbar(
      "Deleted!",
      "Do you wish to undo?",
      snackPosition: SnackPosition.BOTTOM,
      showProgressIndicator: true,
      margin: const EdgeInsets.all(10.0),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      mainButton: TextButton(
        child: const Text("UNDO"),
        onPressed: () {
          if (Get.isSnackbarOpen == true) {
            if (index == state!.length) {
              projectsBox!.add(tmp);
            } else {
              projectsBox!.putAt(index, tmp);
            }
            state!.insert(index, tmp);
            refresh();
            Get.back();
          }
        },
      ),
    );
    refresh();
  }
}
