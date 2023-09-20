// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ToDo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<TasksData> tasks = [];
  final TextEditingController textEditingController = TextEditingController();

  void _incrementCounter() {
    setState(() {
      // this.tasks.add(TasksData("Task $_counter", "4 : 20 PM", false));
      // _counter++;
      showAddTaskDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[...getTasksList()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(null), label: getLeftBottomBarIconText()),
          BottomNavigationBarItem(
            label: "ADD NEW +",
            icon: Icon(null),
          )
        ],
        onTap: bottomBarButtonTapped,
      ),
    );
  }

  String getLeftBottomBarIconText() => "$_counter  Tasks";

  void bottomBarButtonTapped(int index) {
    if (index == 1) {
      _incrementCounter();
    }
  }

  List<Widget> getTasksList() {
    List<Widget> tasksList = [];
    for (int i = 0; i < tasks.length; i++) {
      tasksList.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Checkbox(
                value: tasks[i].isSelected,
                onChanged: (bool? value) {
                  setState(() {
                    tasks[i].isSelected = !tasks[i].isSelected;
                  });
                },
              ),
              Text(
                tasks[i].taskName,
                style: TextStyle(
                  decoration: tasks[i].isSelected
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              )
            ]),
            Text(
              tasks[i].time,
            ),
          ],
        ),
      );
    }
    return tasksList;
  }

  void showAddTaskDialog(BuildContext context) {
    Dialog addTasksDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: SizedBox(
        height: 260.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Text("Add new task."),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  labelText: 'Enter Text...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 110,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          String taskName = textEditingController.text;
                          if (taskName.length < 5) {
                            return;
                          }
                          setState(() {
                            tasks.add(
                              TasksData(
                                taskName,
                                DateTime.now().toString(),
                                false,
                              ),
                            );
                            textEditingController.text = "";
                            _counter++;
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text("Add"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) => addTasksDialog,
    );
  }
}

class TasksData {
  String taskName;
  String time;
  bool isSelected;

  TasksData(this.taskName, this.time, this.isSelected);
}
