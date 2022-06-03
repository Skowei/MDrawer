import 'package:mdrawer/app/global_widgets/layouts/app/layout.dart';
import 'package:mdrawer/app/modules/project/widgets/project_list.dart';
import 'package:mdrawer/app/modules/project/widgets/project_form.dart';

import 'package:mdrawer/common.dart';

class ProjectView extends StatelessWidget {
  ProjectView({super.key});

  String? title = "My Projects";

  @override
  Widget build(BuildContext context) {
    title = AppLocalizations.of(context)!.page_projects;
    return AppLayout(
      title: title,
      appbar: AppBar(
        title: Text(title!),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.plus),
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return ProjectForm();
              },
            ),
          ),
        ],
      ),
      content: ProjectList(),
    );
  }
}
