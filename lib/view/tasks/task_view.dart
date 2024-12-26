// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:my_todo/main.dart';
import 'package:my_todo/models/task.dart';
import 'package:my_todo/utils/constanst.dart';

import 'widgets/task_bottom_button.dart';
import 'widgets/task_field_section.dart';
import 'widgets/task_top_section.dart';

// ignore: must_be_immutable
class TaskView extends StatefulWidget {
  TaskView({
    super.key,
    required this.taskControllerForTitle,
    required this.taskControllerForSubtitle,
    required this.task,
  });

  TextEditingController? taskControllerForTitle;
  TextEditingController? taskControllerForSubtitle;
  final Task? task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  var title;
  var subtitle;
  DateTime? time;
  DateTime? date;

  /// Show Selected Time As String Format
  String showTime(DateTime? time) {
    if (widget.task?.createdAtTime == null) {
      if (time == null) {
        return DateFormat('hh:mm a').format(DateTime.now()).toString();
      } else {
        return DateFormat('hh:mm a').format(time).toString();
      }
    } else {
      return DateFormat('hh:mm a')
          .format(widget.task!.createdAtTime)
          .toString();
    }
  }

  /// Show Selected Time As DateTime Format
  DateTime showTimeAsDateTime(DateTime? time) {
    if (widget.task?.createdAtTime == null) {
      if (time == null) {
        return DateTime.now();
      } else {
        return time;
      }
    } else {
      return widget.task!.createdAtTime;
    }
  }

  /// Show Selected Date As String Format
  String showDate(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateFormat.yMMMEd().format(DateTime.now()).toString();
      } else {
        return DateFormat.yMMMEd().format(date).toString();
      }
    } else {
      return DateFormat.yMMMEd().format(widget.task!.createdAtDate).toString();
    }
  }

  // Show Selected Date As DateTime Format
  DateTime showDateAsDateTime(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateTime.now();
      } else {
        return date;
      }
    } else {
      return widget.task!.createdAtDate;
    }
  }

  /// If any Task Already exist return TRUE otherWise FALSE
  bool isTaskAlreadyExistBool() {
    if (widget.taskControllerForTitle?.text == null &&
        widget.taskControllerForSubtitle?.text == null) {
      return true;
    } else {
      return false;
    }
  }

  /// If any task already exist app will update it otherwise the app will add a new task
  dynamic isTaskAlreadyExistUpdateTask() {
    if (widget.taskControllerForTitle?.text != null &&
        widget.taskControllerForSubtitle?.text != null) {
      try {
        widget.taskControllerForTitle?.text = title;
        widget.taskControllerForSubtitle?.text = subtitle;

        // widget.task?.createdAtDate = date!;
        // widget.task?.createdAtTime = time!;

        widget.task?.save();
        Navigator.of(context).pop();
      } catch (error) {
        nothingEnterOnUpdateTaskMode(context);
      }
    } else {
      if (title != null && subtitle != null) {
        var task = Task.create(
          title: title,
          createdAtTime: time,
          createdAtDate: date,
          subtitle: subtitle,
        );
        BaseWidget.of(context).dataStore.addTask(task: task);
        Navigator.of(context).pop();
      } else {
        emptyFieldsWarning(context);
      }
    }
  }

  /// Delete Selected Task
  dynamic deleteTask() {
    return widget.task?.delete();
  }

  void _onDatePressed() {
    showDatePicker(
      context: context,
      initialDate: showDateAsDateTime(date),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030, 3, 5),
    ).then((selectedDate) {
      if (selectedDate != null) {
        setState(() {
          if (widget.task?.createdAtDate == null) {
            date = selectedDate;
          } else {
            widget.task!.createdAtDate = selectedDate;
          }
        });
      }
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  void _onTimePressed() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(showTimeAsDateTime(time)),
    ).then((selectedTime) {
      if (selectedTime != null) {
        final DateTime selectedDateTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          selectedTime.hour,
          selectedTime.minute,
        );
        setState(() {
          if (widget.task?.createdAtTime == null) {
            time = selectedDateTime;
          } else {
            widget.task!.createdAtTime = selectedDateTime;
          }
        });
      }
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  /// new / update Task Text
  Widget _buildTopText(TextTheme textTheme) {
    return TaskTopSection(
      isTaskAlreadyExist: isTaskAlreadyExistBool(),
    );
  }

  /// Middle Two TextFileds And Time And Date Selection Box
  Widget _buildMiddleTextFieldsANDTimeAndDateSelection(
      BuildContext context, TextTheme textTheme) {
    return TaskFieldSection(
      taskControllerForTitle: widget.taskControllerForTitle,
      taskControllerForSubtitle: widget.taskControllerForSubtitle,
      onTitleChanged: (value) {
        setState(() => title = value);
      },
      onSubtitleChanged: (value) {
        setState(() => subtitle = value);
      },
      onTimePressed: _onTimePressed,
      onDatePressed: _onDatePressed,
      timeDisplay: showTime(time),
      dateDisplay: showDate(date),
    );
  }

  /// All Bottom Buttons
  Widget _buildBottomButtons(BuildContext context) {
    return TaskBottomButton(
      isTaskAlreadyExist: isTaskAlreadyExistBool(),
      onDeletePressed: () {
        deleteTask();
        Navigator.pop(context);
      },
      onAddUpdatePressed: () {
        isTaskAlreadyExistUpdateTask();
      },
      task: widget.task,
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// new / update Task Text
                  _buildTopText(textTheme),

                  /// Middle Two TextFileds, Time And Date Selection Box
                  _buildMiddleTextFieldsANDTimeAndDateSelection(
                      context, textTheme),

                  /// All Bottom Buttons
                  _buildBottomButtons(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
