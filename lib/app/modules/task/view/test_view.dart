import 'package:mdrawer/app/global_widgets/layouts/app/layout.dart';
import 'package:mdrawer/app/modules/task/controller/task_controller.dart';
import 'package:mdrawer/app/modules/task/widgets/task_form.dart';
import 'package:mdrawer/common.dart';
import 'package:mdrawer/app/modules/task/widgets/tasks_list.dart';

class TaskView extends StatelessWidget {
  TaskView({super.key});

  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: taskController.title,
      appbar: AppBar(
        title: Text(taskController.title),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.plus),
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return TaskForm();
              },
            ),
          ),
        ],
      ),
      content: TasksList(),
      // content: DefaultTabController(
      //   length: taskController.tablesCount,
      //   child: Column(
      //     children: [
      //       TabBar(
      //         tabs: tabs(),
      //         //[
      //         // Tab(icon: Icon(Icons.flight)),
      //         // Tab(icon: Icon(Icons.directions_transit)),
      //         // Tab(icon: Icon(Icons.directions_car)),
      //         // Tab(icon: Icon(Icons.flight)),
      //         // Tab(icon: Icon(Icons.directions_transit)),
      //         // Tab(icon: Icon(Icons.directions_car)),
      //         // Tab(icon: Icon(Icons.flight)),
      //         // Tab(icon: Icon(Icons.directions_transit)),
      //         // Tab(icon: Icon(Icons.directions_car)),
      //         //],
      //       ),
      //       Expanded(
      //         child: TabBarView(
      //           children: [
      //             // TasksList(),
      //             // TasksList(),
      //             // Icon(Icons.directions_car, size: 350),
      //             // Icon(Icons.flight, size: 350),
      //             // Icon(Icons.directions_transit, size: 350),
      //             // Icon(Icons.directions_car, size: 350),
      //             // Icon(Icons.flight, size: 350),
      //             // Icon(Icons.directions_transit, size: 350),
      //             // Icon(Icons.directions_car, size: 350),
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
