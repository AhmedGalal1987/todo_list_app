import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:todo_list_app/controllers/task_controller.dart';
import 'package:todo_list_app/models/task_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late TaskController taskController;

  setUp(() {
    taskController = TaskController();
    Get.put(taskController);
  });

  test('Adding a task', () {
    taskController.addTask('New Task');
    expect(taskController.tasks.length, 1);
    expect(taskController.tasks[0].title, 'New Task');
  });

  test('Toggling task completion', () {
    taskController.addTask('New Task');
    taskController.toggleTaskCompletion(0);
    expect(taskController.tasks[0].isCompleted, true);
    taskController.toggleTaskCompletion(0);
    expect(taskController.tasks[0].isCompleted, false);
  });
}
