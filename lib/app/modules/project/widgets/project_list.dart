import 'package:mdrawer/app/modules/project/controller/project_controller.dart';
import 'package:mdrawer/app/modules/project/widgets/project_tile.dart';
import 'package:mdrawer/common.dart';
import 'package:mdrawer/app/modules/task/controller/task_controller.dart';
import 'package:mdrawer/app/modules/task/widgets/task_tile.dart';

class ProjectList extends StatelessWidget {
  ProjectList({super.key});

  final ProjectController projectController = Get.find();

  @override
  Widget build(BuildContext context) {
    return projectController.obx(
      (state) => (ReorderableListView.builder(
        // padding: EdgeInsets.all(20.0),
        onReorder: (oldIndex, newIndex) {
          projectController.swap(oldIndex, newIndex);
        },
        itemBuilder: (context, index) {
          final project = state![index];
          return ProjectTile(
            key: ValueKey(project),
            project: project,
            title: project.name,
            color: project.color,
            description: project.description,
            longPressCallback: () {
              projectController.openProject(project);
            },
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
