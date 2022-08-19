import 'package:flutter/material.dart';
import 'package:taskoo/dbhelper/dbhelper.dart';

class Taskoo extends StatefulWidget {
  const Taskoo({Key? key}) : super(key: key);

  @override
  State<Taskoo> createState() => _TaskooState();
}

class _TaskooState extends State<Taskoo> {
  final dbhelper = Databasehelper.instance;
  final titleController = TextEditingController();
  final taskController = TextEditingController();
  bool validated = true;
  String errMessage = "";
  String titleedited = "";
  String descedited = "";
  List<Widget> childern = [];
  var myTodos = [];

  void addTask() async {
    Map<String, dynamic> todo = {
      Databasehelper.columnTitle: titleedited,
      Databasehelper.columnDesc: descedited,
    };
    final id = await dbhelper.insert(todo);
    // print(id);
    Navigator.of(context, rootNavigator: true).pop();
    titleedited = "";
    descedited = "";
    setState(() {
      validated = true;
      errMessage = "";
    });
  }

  void showAlertDialog() {
    titleController.text = "";
    taskController.text = "";
    showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: const Text("Add Task"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      autofocus: true,
                      onChanged: (value) {
                        titleedited = value;
                      },
                      style: const TextStyle(fontSize: 20.0),
                      decoration: InputDecoration(
                        hintText: "Task Title",
                        hintStyle: const TextStyle(fontSize: 18),
                        errorText: validated ? null : errMessage,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    TextField(
                      controller: taskController,
                      autofocus: true,
                      onChanged: (value) {
                        descedited = value;
                      },
                      maxLines: 8,
                      style: const TextStyle(fontSize: 16.0),
                      decoration: const InputDecoration(
                        hintText: "Task Description",
                        hintStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ignore: deprecated_member_use
                        ElevatedButton(
                          onPressed: () {
                            if (titleController.text.isEmpty) {
                              setState(() {
                                errMessage = "Can be Empty";
                                validated = false;
                              });
                            } else if (titleController.text.length > 50) {
                              setState(() {
                                errMessage = "Too Many Characters";
                                validated = false;
                              });
                            } else {
                              addTask();
                            }
                          },
                          child: Text(
                            "Add",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
          );
        });
  }

  Future<bool> query() async {
    myTodos = [];
    childern = [];
    var allTodos = await dbhelper.queryAll();
    allTodos?.forEach((tasks) {
      myTodos.add(tasks.toString());
      childern.add(Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250,
                  child: Text(
                    tasks['title'], // Value
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    tasks['desc'], // Value
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                dbhelper.deleteTodo(tasks['id']);
                setState(() {});
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ));
    });
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snap) {
        if (snap.hasData == null) {
          return Center(
            child: Text("No Data"),
          );
        } else {
          if (myTodos.length == 0) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu),
                  color: Colors.black,
                ),
                elevation: 0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/taskoo_logo.png',
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Taskoo',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: showAlertDialog,
                child: Icon(Icons.add),
                backgroundColor: Colors.orange,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome To Taskoo!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'My Tasks',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/taskoo_done.png",
                              height: 300,
                              width: 300,
                            ),
                            const Text(
                              "All Tasks Done",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu),
                  color: Colors.black,
                ),
                elevation: 0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/taskoo_logo.png',
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Taskoo',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: showAlertDialog,
                child: Icon(Icons.add),
                backgroundColor: Colors.orange,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome To Taskoo!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'My Tasks',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: childern,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }
      },
      future: query(),
    );
  }
}
