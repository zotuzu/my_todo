import 'package:flutter/material.dart';

import 'package:my_todo/models/task.dart';
import 'package:my_todo/utils/colors.dart';
import 'package:my_todo/utils/strings.dart';

class TaskBottomButton extends StatelessWidget {
  final bool isTaskAlreadyExist;
  final Function() onDeletePressed;
  final Function() onAddUpdatePressed;
  final Task? task;

  const TaskBottomButton({
    super.key,
    required this.isTaskAlreadyExist,
    required this.onDeletePressed,
    required this.onAddUpdatePressed,
    this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: isTaskAlreadyExist
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceEvenly,
        children: [
          isTaskAlreadyExist
              ? Container()
              : Container(
                  width: 150,
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: MyColors.primaryColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minWidth: 150,
                    height: 55,
                    onPressed: onDeletePressed,
                    color: Colors.white,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.close,
                          color: MyColors.primaryColor,
                        ),
                        SizedBox(width: 5),
                        Text(
                          MyString.deleteTask,
                          style: TextStyle(
                            color: MyColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            minWidth: 150,
            height: 55,
            onPressed: onAddUpdatePressed,
            color: MyColors.primaryColor,
            child: Text(
              isTaskAlreadyExist
                  ? MyString.addTaskString
                  : MyString.updateTaskString,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
