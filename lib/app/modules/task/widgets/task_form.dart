import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mdrawer/app/modules/task/model/task.dart';
import 'package:mdrawer/common.dart';
import 'package:mdrawer/app/modules/task/controller/task_controller.dart';

class TaskForm extends StatelessWidget {
  TaskForm({super.key, task}) {
    if (task != null) this.task = task;
  }

  final _formKey = GlobalKey<FormState>();
  final TaskController taskController = Get.find();

  Task? task;

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  void changeColor(Color color) => pickerColor = color;

  _nextFocus(FocusNode focusNode) => focusNode.requestFocus();

  bool isUpdate() => task != null;

  submitForm() {
    if (_formKey.currentState!.validate()) {
      final data = {
        'name': _nameController.text,
        'description': _descriptionController.text,
      };

      if (isUpdate()) {
        taskController.updateTask(
          task!,
          task!.copyWith(
            name: data['name'],
            description: data['description'],
            color: '#${pickerColor.value.toRadixString(16).padLeft(6, '0')}',
          ),
        );
      } else {
        taskController.addTask(data['name']!, data['description']!, pickerColor);
      }

      _formKey.currentState!.save();
      _formKey.currentState!.reset();
      _nextFocus(_nameFocusNode);

      Get.back();
    }
  }

  String? _validateInput(String? value) {
    if (value!.trim().isEmpty) {
      return 'Field required';
    }
    return null;
  }

  void prepare() {
    _nameController.text = task!.name!;
    _descriptionController.text = task!.description!;
    pickerColor = HexColor(task!.color!);
    currentColor = HexColor(task!.color!);
  }

  @override
  Widget build(BuildContext context) {
    if (isUpdate()) prepare();

    return AlertDialog(
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(isUpdate()
                  ? AppLocalizations.of(context)!.form_edit_task
                  : AppLocalizations.of(context)!.form_add_task),
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
                  hintText: AppLocalizations.of(context)!.form_enter_task_name,
                  labelText: AppLocalizations.of(context)!.form_task_name,
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
                  hintText: AppLocalizations.of(context)!.form_enter_task_description,
                  labelText: AppLocalizations.of(context)!.form_task_description,
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
                child: Text(isUpdate()
                    ? AppLocalizations.of(context)!.form_edit_task
                    : AppLocalizations.of(context)!.form_add_task),
              )
            ],
          ),
        ),
      ),
    );
  }
}
