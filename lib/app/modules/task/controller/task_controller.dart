import 'package:mdrawer/app/modules/project/model/project.dart';
// import 'package:mdrawer/app/modules/task/data/task_data.dart';
import 'package:mdrawer/app/modules/task/model/task.dart';
import 'package:mdrawer/common.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class TaskController extends GetxController with StateMixin<RxList<Task>> {
  Box<Task>? tasksBox;
  late Project project = const Project();
  var uuid = const Uuid();

  @override
  void onInit() async {
    super.onInit();
    Hive.openBox<Task>(project.table);
    prepare();
  }

  get title => project.name;
  // get tablesCount => project.tables.length;

  void prepare() async {
    change(RxList<Task>(), status: RxStatus.loading());
    // To imitate network connection
    await Hive.openBox<Task>(project.table);
    await Future.delayed(
      const Duration(seconds: 1),
    );
    // Get data and return status
    try {
      // currently using only one table;
      tasksBox = Hive.box(project.table);
      RxList<Task> tasks = RxList<Task>();
      tasks.addAll(tasksBox!.values);

      change(tasks, status: RxStatus.success());
    } catch (error) {
      change(null, status: RxStatus.error(error.toString()));
    }
  }

  void addTask(String name, String description, Color color) {
    String id = uuid.v4();
    final task = Task(
      id: id,
      name: name,
      description: description,
      color: '#${color.value.toRadixString(16).padLeft(6, '0')}',
      tableId: id,
    );
    state!.add(task);
    tasksBox!.add(task);
    refresh();
  }

  void markTask(Task task) {
    tasksBox!.putAt(state!.indexOf(task), task.copyWith(isDone: !task.isDone));
    state![state!.indexOf(task)] = task.copyWith(isDone: !task.isDone);
    refresh();
  }

  void updateTask(Task current, Task task) {
    tasksBox!.putAt(state!.indexOf(current), task);
    state![state!.indexOf(current)] = task;
    refresh();
  }

  void swap(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    //swap state
    Task task = state![oldIndex];
    state!.remove(task);
    state!.insert(newIndex, task);
    //swap database
    final oldItem = tasksBox!.getAt(oldIndex);
    final newItem = tasksBox!.getAt(newIndex);
    tasksBox!.putAt(oldIndex, newItem!);
    tasksBox!.putAt(newIndex, oldItem!);

    refresh();
  }

  void deleteTask(Task task) {
    Task tmp = task;
    final int index = state!.indexOf(task);
    tasksBox!.deleteAt(index);
    state!.removeAt(index);

    Get.snackbar(
      "Deleted task!",
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
              tasksBox!.add(tmp);
            } else {
              tasksBox!.putAt(index, tmp);
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

  // Project

  void openProject(Project project) {
    this.project = project;
    prepare();
    refresh();
  }
}
