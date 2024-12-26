import 'package:flutter/material.dart';
import '../../../utils/strings.dart';

class TaskTopSection extends StatelessWidget {
  final bool isTaskAlreadyExist;

  const TaskTopSection({
    super.key,
    required this.isTaskAlreadyExist,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 32,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 70,
              child: Divider(
                thickness: 2,
              ),
            ),
            RichText(
              text: TextSpan(
                text: isTaskAlreadyExist
                    ? MyString.addNewTask
                    : MyString.updateCurrentTask,
                style: const TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                children: const [
                  TextSpan(
                    text: MyString.taskStrnig,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 70,
              child: Divider(
                thickness: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
