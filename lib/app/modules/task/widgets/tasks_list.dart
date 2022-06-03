import 'package:mdrawer/common.dart';
import 'package:mdrawer/app/modules/task/controller/task_controller.dart';
import 'package:mdrawer/app/modules/task/widgets/task_tile.dart';

class TasksList extends StatelessWidget {
  TasksList({super.key});

  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return taskController.obx(
      (state) => (ReorderableListView.builder(
        onReorder: (oldIndex, newIndex) {
          taskController.swap(oldIndex, newIndex);
        },
        itemBuilder: (context, index) {
          final task = state![index];
          return TaskTile(
            key: ValueKey(task),
            task: task,
            taskTitle: task.name,
            isChecked: task.isDone,
            taskColor: task.color,
            taskDescription: task.description,
            checkboxCallback: (checkboxState) {
              taskController.markTask(task);
            },
            // longPressCallback: () {
            //   taskController.deleteTask(task);
            // },
          );
        },
        itemCount: state!.length,
      )),
      onLoading: const Center(child: CircularProgressIndicator()),
      onEmpty: const Text('No data found'),
      onError: (error) => Text(error!),
    );
  }
}
