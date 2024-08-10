import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';

class HomeView extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());
  final TextEditingController textController = TextEditingController();
  final RxString errorMessage = ''.obs;

  HomeView({super.key}); // Error message variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: taskController.tasks.length,
                  itemBuilder: (context, index) {
                    final task = taskController.tasks[index];
                    return ListTile(
                      title: Text(task.title),
                      trailing: Checkbox(
                        value: task.isCompleted,
                        onChanged: (value) {
                          taskController.toggleTaskCompletion(index);
                        },
                      ),
                    );
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textController,
                        decoration: InputDecoration(
                          hintText: 'Enter task',
                          errorText: errorMessage.value.isNotEmpty
                              ? errorMessage.value
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (textController.text.isEmpty) {
                          errorMessage.value = 'This field is empty';
                        } else {
                          errorMessage.value = '';
                          taskController.addTask(textController.text);
                          textController.clear();
                        }
                      },
                      child: Text('Add'),
                    ),
                  ],
                ),
                Obx(() => errorMessage.value.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          errorMessage.value,
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : Container()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
