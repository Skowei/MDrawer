import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mdrawer/app/modules/project/controller/project_controller.dart';
import 'package:mdrawer/app/modules/project/model/project.dart';
import 'package:mdrawer/common.dart';

class ProjectForm extends StatelessWidget {
  ProjectForm({super.key, project}) {
    if (project != null) this.project = project;
  }

  final _formKey = GlobalKey<FormState>();
  final ProjectController projectController = Get.find();

  Project? project;
  String? fieldRequired = "Field required";

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  bool isUpdate() => project != null;

  void changeColor(Color color) {
    pickerColor = color;
  }

  _nextFocus(FocusNode focusNode) {
    focusNode.requestFocus();
  }

  submitForm() {
    if (_formKey.currentState!.validate()) {
      final data = {
        'name': _nameController.text,
        'description': _descriptionController.text,
      };

      if (isUpdate()) {
        projectController.updateProject(
          project!,
          project!.copyWith(
            name: data['name'],
            description: data['description'],
            color: '#${pickerColor.value.toRadixString(16).padLeft(6, '0')}',
          ),
        );
      } else {
        projectController.addProject(data['name']!, data['description']!, pickerColor);
      }

      _formKey.currentState!.save();
      _formKey.currentState!.reset();
      _nextFocus(_nameFocusNode);

      Get.back();
    }
  }

  String? _validateInput(String? value) {
    if (value!.trim().isEmpty) {
      return fieldRequired;
    }
    return null;
  }

  void prepare() {
    _nameController.text = project!.name!;
    _descriptionController.text = project!.description!;
    pickerColor = HexColor(project!.color!);
    currentColor = HexColor(project!.color!);
  }

  @override
  Widget build(BuildContext context) {
    if (isUpdate()) prepare();
    fieldRequired = AppLocalizations.of(context)!.field_required;

    return AlertDialog(
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(isUpdate()
                  ? AppLocalizations.of(context)!.form_edit_project
                  : AppLocalizations.of(context)!.form_create_new_project),
              TextFormField(
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                focusNode: _nameFocusNode,
                onFieldSubmitted: (String value) {
                  _nextFocus(_descriptionFocusNode);
                },
                controller: _nameController,
                validator: _validateInput,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.form_enter_project_name,
                  labelText: AppLocalizations.of(context)!.form_project_name,
                ),
              ),
              TextFormField(
                minLines: 6,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
                focusNode: _descriptionFocusNode,
                onFieldSubmitted: (String value) {
                  submitForm();
                },
                controller: _descriptionController,
                validator: _validateInput,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.form_enter_project_description,
                  labelText: AppLocalizations.of(context)!.form_project_description,
                ),
              ),
              MaterialPicker(
                pickerColor: pickerColor,
                onColorChanged: changeColor,
                enableLabel: true,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  submitForm();
                },
                child: Text(
                  isUpdate()
                      ? AppLocalizations.of(context)!.form_edit_project
                      : AppLocalizations.of(context)!.form_add_project,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
