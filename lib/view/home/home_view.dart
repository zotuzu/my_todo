import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:my_todo/utils/colors.dart';
import 'package:my_todo/view/home/widgets/add_task_button.dart';
import 'package:my_todo/view/home/widgets/slider.dart';

import 'widgets/home_app_bar.dart';

import '../../main.dart';
import '../../models/task.dart';
import '../../utils/constanst.dart';
import '../../view/home/widgets/task_widget.dart';
import '../../utils/strings.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<SliderDrawerState> dKey = GlobalKey<SliderDrawerState>();

  /// Checking Done Tasks
  int checkDoneTask(List<Task> task) {
    int i = 0;
    for (Task doneTasks in task) {
      if (doneTasks.isCompleted) {
        i++;
      }
    }
    return i;
  }

  /// Checking The Value Of the Circle Indicator
  dynamic valueOfTheIndicator(List<Task> task) {
    if (task.isNotEmpty) {
      return task.length;
    } else {
      return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);
    var textTheme = Theme.of(context).textTheme;

    return ValueListenableBuilder(
        valueListenable: base.dataStore.listenToTask(),
        builder: (ctx, Box<Task> box, Widget? child) {
          var tasks = box.values.toList();

          /// Sort Task List
          tasks.sort(((a, b) => a.createdAtDate.compareTo(b.createdAtDate)));

          return Scaffold(
            /// Floating Action Button
            floatingActionButton: const AddTaskButton(),

            /// Body
            body: SliderDrawer(
              isDraggable: false,
              key: dKey,
              animationDuration: 100,

              /// My AppBar
              appBar: HomeAppBar(
                drawerKey: dKey,
              ),

              /// My Drawer Slider
              slider: const MySlider(),

              /// Main Body
              child: _buildBody(
                tasks,
                base,
                textTheme,
              ),
            ),
          );
        });
  }

  /// Main Body
  Container _buildBody(
    List<Task> tasks,
    BaseWidget base,
    TextTheme textTheme,
  ) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: MyColors.secondaryGradientColor,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          /// Top Section Of Home page : Text, Progrss Indicator
          Container(
            margin: const EdgeInsets.only(left: 20, top: 10),
            decoration: const BoxDecoration(color: Colors.transparent),
            width: double.infinity,
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Texts
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(MyString.mainTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      "${checkDoneTask(tasks)} of ${tasks.length} task",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          /// Bottom ListView : Tasks
          SizedBox(
            width: double.infinity,
            height: 585,
            child: tasks.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: tasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      var task = tasks[index];

                      return Dismissible(
                        direction: DismissDirection.horizontal,
                        background: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete_outline,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(MyString.deletedTask,
                                style: TextStyle(
                                  color: Colors.red,
                                ))
                          ],
                        ),
                        onDismissed: (direction) {
                          base.dataStore.dalateTask(task: task);
                        },
                        key: Key(task.id),
                        child: TaskWidget(
                          task: tasks[index],
                        ),
                      );
                    },
                  )

                /// if All Tasks Done Show this Widgets
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Lottie
                      FadeIn(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Lottie.asset(
                            lottieURL,
                            animate: tasks.isNotEmpty ? false : true,
                          ),
                        ),
                      ),

                      /// Bottom Texts
                      FadeInUp(
                        from: 30,
                        child: const Text(MyString.doneAllTask),
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
