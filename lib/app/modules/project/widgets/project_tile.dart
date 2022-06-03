import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mdrawer/app/modules/project/controller/project_controller.dart';
import 'package:mdrawer/app/modules/project/model/project.dart';
import 'package:mdrawer/app/modules/project/widgets/project_form.dart';
import 'package:mdrawer/common.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectTile extends StatelessWidget {
  // ignore: annotate_overrides, overridden_fields
  final Key key;
  final String? color;
  final String? title;
  final String? description;
  final Project? project;
  final Function()? longPressCallback;

  ProjectTile({
    required this.key,
    this.title,
    this.color,
    this.description,
    this.project,
    this.longPressCallback,
  });

  final ProjectController projectController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: key,
      tileColor: HexColor('$color'),
      iconColor: Palette.gray[50],
      textColor: Palette.gray[50],
      onTap: longPressCallback,
      selectedTileColor: Palette.gray[500],
      leading: const FaIcon(FontAwesomeIcons.tableColumns),
      title: Text(
        title!,
        overflow: TextOverflow.ellipsis,
      ),
      // subtitle: Text(
      //   '$description',
      //   overflow: TextOverflow.ellipsis,
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
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(title!),
                          const SizedBox(height: 10),
                          MarkdownBody(
                            data: description!,
                            onTapLink: (text, url, title) {
                              launch(url!);
                            },
                          ),
                        ],
                      ),
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
                  return ProjectForm(project: project);
                },
              ),
            },
          ),
          const SizedBox(width: 8.0),
          IconButton(
            icon: const Icon(FontAwesomeIcons.eraser, size: 18),
            onPressed: () => {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(AppLocalizations.of(context)!.form_delete_project_info),
                        const SizedBox(height: 16),
                        IconButton(
                          onPressed: () => {
                            projectController.deleteProject(project!),
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
    );
  }
}
