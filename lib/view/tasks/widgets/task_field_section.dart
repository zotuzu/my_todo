import 'package:flutter/material.dart';
import '../../../utils/strings.dart';

class TaskFieldSection extends StatelessWidget {
  final TextEditingController? taskControllerForTitle;
  final TextEditingController? taskControllerForSubtitle;
  final Function(String) onTitleChanged;
  final Function(String) onSubtitleChanged;
  final Function() onTimePressed;
  final Function() onDatePressed;
  final String timeDisplay;
  final String dateDisplay;

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
  });

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
                controller: taskControllerForTitle,
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
                  onTitleChanged(value);
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onChanged: onTitleChanged,
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
                controller: taskControllerForSubtitle,
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
                onFieldSubmitted: onSubtitleChanged,
                onChanged: onSubtitleChanged,
              ),
            ),
          ),

          /// Time Picker
          GestureDetector(
            onTap: onTimePressed,
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
                      child: Text(timeDisplay),
                    ),
                  )
                ],
              ),
            ),
          ),

          /// Date Picker
          GestureDetector(
            onTap: onDatePressed,
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
                      child: Text(dateDisplay),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
