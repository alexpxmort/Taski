import 'package:flutter/material.dart';
import 'package:taski/presentation/screens/task_form_screen.dart';
import 'package:taski/widgets/header.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: HeaderWidget()),
      body: TaskFormScreen(),
    );
  }
}
