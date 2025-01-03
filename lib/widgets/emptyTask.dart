import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taski/presentation/screens/task_form_screen.dart';
import 'package:taski/widgets/create-taskButton.dart';

class EmptyTaskWidget extends StatelessWidget {
  void showTaskModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the modal to use full height if needed
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {
                      // Handle checkbox state change
                    },
                  ),
                  Text(
                    "What's in your mind?",
                    style: TextStyle(
                        color: Color(0xFFC6CFDC),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Expanded(
                      child: TaskFormScreen(
                    isModal: true,
                  )),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/images/task_icon.svg', // Caminho para o SVG
              height: 80.0, // Altura do SVG
              width: 82.0,
              fit: BoxFit.cover, // Ajusta o SVG para cobrir o espaço
            ),
            SizedBox(width: 20),
            Center(
                child: Text(
              'You have no task listed.',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color(0xFF8D9CB8)),
            )),
            CreateTaskButton(onPress: () {
              showTaskModal(context);
            })
          ],
        ));
  }
}
