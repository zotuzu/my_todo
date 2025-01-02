import 'package:flutter/material.dart';
import '../../../utils/strings.dart';
import 'package:intl/intl.dart';

class TaskFieldSection extends StatefulWidget {
  final TextEditingController? taskControllerForTitle;
  final TextEditingController? taskControllerForSubtitle;
  final Function(String) onTitleChanged;
  final Function(String) onSubtitleChanged;
  final Function() onTimePressed;
  final Function() onDatePressed;
  final String timeDisplay;
  final String dateDisplay;
  final Function(DateTime? selectedReminderTime) onReminderTimeSelected;
  final DateTime? initialReminderTime;

  const TaskFieldSection({
    super.key,
    required this.taskControllerForTitle,
    required this.taskControllerForSubtitle,
    required this.onTitleChanged,
    required this.onSubtitleChanged,
    required this.onTimePressed,
    required this.onDatePressed,
    required this.timeDisplay,
    required this.dateDisplay,
    required this.onReminderTimeSelected,
    this.initialReminderTime,
  });

  @override
  State<TaskFieldSection> createState() => _TaskFieldSectionState();
}

class _TaskFieldSectionState extends State<TaskFieldSection> {
  bool _hasAlarm = false;
  DateTime? _alarmTime;

  @override
  void initState() {
    super.initState();
    _alarmTime = widget.initialReminderTime;
    _hasAlarm = widget.initialReminderTime != null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 535,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title TextField
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 30,
            ),
            child: ListTile(
              title: TextFormField(
                controller: widget.taskControllerForTitle,
                cursorHeight: 32,
                maxLines: null,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: MyString.titleOfTitleTextField,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                onFieldSubmitted: (value) {
                  widget.onTitleChanged(value);
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onChanged: (value) {
                  widget.onTitleChanged(value);
                },
              ),
            ),
          ),

          const SizedBox(height: 10),

          /// Note TextField
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              title: TextFormField(
                controller: widget.taskControllerForSubtitle,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counter: Container(),
                  hintText: MyString.addNote,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                onFieldSubmitted: widget.onSubtitleChanged,
                onChanged: widget.onSubtitleChanged,
              ),
            ),
          ),

          /// Time Picker
          GestureDetector(
            onTap: widget.onTimePressed,
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(MyString.timeString),
                  ),
                  Expanded(child: Container()),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 80,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade100,
                    ),
                    child: Center(
                      child: Text(widget.timeDisplay),
                    ),
                  )
                ],
              ),
            ),
          ),

          /// Date Picker
          GestureDetector(
            onTap: widget.onDatePressed,
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(MyString.dateString),
                  ),
                  Expanded(child: Container()),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 140,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade100,
                    ),
                    child: Center(
                      child: Text(widget.dateDisplay),
                    ),
                  )
                ],
              ),
            ),
          ),

          /// Alarm Section
          _buildAlarmSection()
        ],
      ),
    );
  }

  Widget _buildAlarmSection() {
    return Column(
      children: [
        SwitchListTile(
          title: const Text('Set Reminder'),
          value: _hasAlarm,
          onChanged: (value) {
            setState(() {
              _hasAlarm = value;
              if (!value) {
                _alarmTime = null;
              }
            });
          },
        ),
        if (_hasAlarm)
          GestureDetector(
            onTap: _selectAlarmTime,
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('Reminder Time'),
                  ),
                  Expanded(child: Container()),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 140,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade100,
                    ),
                    child: Center(
                      child: Text(
                        _alarmTime != null
                            ? DateFormat('MMM dd, yyyy hh:mm a')
                                .format(_alarmTime!)
                            : 'Select Time',
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _selectAlarmTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _alarmTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
        widget.onReminderTimeSelected(_alarmTime);
      }
    }
  }
}
