import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';
import 'dart:convert';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? tasksJson = prefs.getStringList('tasks');
    if (tasksJson != null) {
      tasks.value =
          tasksJson.map((task) => Task.fromJson(jsonDecode(task))).toList();
    }
  }

  void addTask(String title) {
    tasks.add(Task(title: title));
    saveTasks();
  }

  void toggleTaskCompletion(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted;
    tasks.refresh();
    saveTasks();
  }

  void saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasksJson =
        tasks.map((task) => jsonEncode(task.toJson())).toList();
    prefs.setStringList('tasks', tasksJson);
  }
}
