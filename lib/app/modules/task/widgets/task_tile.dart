import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mdrawer/app/modules/task/model/task.dart';
import 'package:mdrawer/app/modules/task/widgets/task_form.dart';
import 'package:mdrawer/common.dart';
import 'package:mdrawer/app/modules/task/controller/task_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskTile extends StatelessWidget {
  // ignore: annotate_overrides, overridden_fields
  final Key key;
  final bool? isChecked;
  final String? taskColor;
  final String? taskTitle;
  final String? taskDescription;
  final Function(bool?)? checkboxCallback;
  final Function()? longPressCallback;
  final Task? task;

  TaskTile(
      {required this.key,
      this.isChecked,
      this.taskTitle,
      this.taskColor,
      this.checkboxCallback,
      this.longPressCallback,
      this.taskDescription,
      this.task});

  final TaskController taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: key,
      tileColor: HexColor('$taskColor'),
      iconColor: Palette.gray[50],
      textColor: Palette.gray[50],
      selectedTileColor: Palette.gray[500],
      // leading: const FaIcon(FontAwesomeIcons.thumbtack),
      leading: Checkbox(
        value: isChecked,
        onChanged: checkboxCallback,
      ),
      title: Text(
        taskTitle!,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(decoration: isChecked! ? TextDecoration.lineThrough : null),
      ),
      // subtitle: Text(
      //   '$taskDescription',
      //   overflow: TextOverflow.ellipsis,
      //   style: TextStyle(
      //     decoration: isChecked! ? TextDecoration.lineThrough : null,
      //   ),
      // ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 24.0),
          IconButton(
            icon: const Icon(FontAwesomeIcons.eye, size: 18),
            onPressed: () => {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(taskTitle!),
                        const SizedBox(height: 12),
                        MarkdownBody(
                          data: taskDescription!,
                          onTapLink: (text, url, title) {
                            launch(url!);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            },
          ),
          const SizedBox(width: 8.0),
          IconButton(
            icon: const Icon(FontAwesomeIcons.penToSquare, size: 18),
            onPressed: () => {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return TaskForm(task: task);
                },
              ),
            },
          ),
          const SizedBox(width: 8.0),
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.eraser,
              size: 18,
            ),
            onPressed: () => {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(AppLocalizations.of(context)!.form_delete_task_info),
                        IconButton(
                          onPressed: () => {
                            taskController.deleteTask(task!),
                            Navigator.pop(context),
                          },
                          icon: Icon(FontAwesomeIcons.trash, size: 16, color: Palette.red[600]),
                        ),
                      ],
                    ),
                  );
                },
              ),
            },
          ),
          const SizedBox(width: 32.0),
        ],
      ),
      onLongPress: longPressCallback,
    );
  }
}
