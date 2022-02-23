import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/constants.dart';
import 'package:todo_task/model/get_task_model.dart';
import 'package:todo_task/model/todo.dart';
import 'package:todo_task/ui/add_task.dart';
import 'package:todo_task/ui/task_viewer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool getData = false;
  List checkList = [];
  List<Todo> taskList = [];
  List<Todo> deletedTaskList = [];

  final GlobalKey<AnimatedListState> key = GlobalKey();

  final GlobalKey<AnimatedListState> deletekey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: const Text("Todo List"),
      ),
      backgroundColor: Colors.white,
      body: Consumer<GetTaskModel>(builder: (context, task, child) {
        for (int i = 0; i < task.taskList.length; i++) {
          taskList.add(Todo(
              title: task.taskList[i]['title'],
              description: task.taskList[i]['description'],
              id: task.taskList[i]['id']));
          checkList.add(false);
        }
        void insert(int index, var taskId) {
          
          int currentIndex = index - taskList.length;

         if(index < taskList.length - 1){
           print(index);
           taskList.length+=1
            // if(index <  taskList.length){
           
         //}
         deletedTaskList.add(taskId);
          //if(index <  taskList.length){
             key.currentState!.insertItem(
           taskList.length, 
           );
          //}
         }        }
        void removeItem(int index) {
          key.currentState!.removeItem(
            index,
            (context, animation) {
              return SizeTransition(
                sizeFactor: animation,  
                child: const Card(
                  child: Text("gone"),
                ),
              );
            },
          );

          setState(() {
            final taskId = taskList.removeAt(index);
            insert(index, taskId);
            //taskList.add(task);
            print(deletedTaskList.length);
          });
        }
        if (getData == false) {
          task.getTask(true);
          Future.delayed(const Duration(seconds: 3), () => getData = true);
        }
        return RefreshIndicator(
            onRefresh: () {
              task.getTask(false);

              return Future.delayed(const Duration(seconds: 3));
            },
            child: Column(
              children: [
                taskList.isNotEmpty
                    ? Expanded(
                        child: AnimatedList(
                            key: key,
                            initialItemCount: taskList.length,
                            itemBuilder: (_, index, context) {
                              return ListTile(
                                onTap: () {
                                  //     Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  //   TaskViewer(title:taskList[index].title, desc:taskList[index].description,id:'${task.taskList[index]["id"]}', isCompleted: task.taskList[index]["isCompleted"], )
                                  // )
                                  // );
                                },
                                leading: SizedBox(
                                  height: 44.sp,
                                  child: CircleAvatar(
                                    radius: 16.sp,
                                    backgroundColor: outerBorderColor,
                                    child: CircleAvatar(
                                      radius: 15.sp,
                                      backgroundColor: taskHeaderColor,
                                      child: Text('${index + 1}'),
                                    ),
                                  ),
                                ),
                                title: Text('${taskList[index].title}',
                                    style: TextStyle(
                                        decoration: checkList[index]
                                            ? TextDecoration.lineThrough
                                            : null)),
                                subtitle: Text(
                                  '${taskList[index].description}',
                                  style: TextStyle(
                                      decoration: checkList[index]
                                          ? TextDecoration.lineThrough
                                          : null),
                                ),
                                trailing: Checkbox(
                                  // tristate: taskList[index].isDone,
                                  activeColor: Colors.lightBlueAccent,
                                  value: false,
                                  //checkList[index],
                                  onChanged: (checkBoxCallBacks) {
                                    // setState(() {
                                    checkList[index] = checkBoxCallBacks!;
                                    //  final remove =  taskList.removeAt(index);
                                    //  taskList.add(remove);
                                    removeItem(index);
                                    //  key.currentState!.insertItem(taskList.length, duration:Duration(milliseconds: 5));
                                    //});
                                  },
                                ),
                              );
                            }),
                      )
                    : Expanded(
                        child: ListView(children: [
                          SizedBox(height: 100.h),
                          const Center(child: Text("TodoList is empty"))
                        ]),
                      ),
                // deletedTaskList.isNotEmpty
                //     ? Expanded(
                //         child: AnimatedList(
                //             key: deletekey,
                //             initialItemCount: deletedTaskList.length,
                //             itemBuilder: (_, index, context) {
                //               return ListTile(
                //                 onTap: () {
                //                   //     Navigator.push(context, MaterialPageRoute(builder: (context) =>
                //                   //   TaskViewer(title:taskList[index].title, desc:taskList[index].description,id:'${task.taskList[index]["id"]}', isCompleted: task.taskList[index]["isCompleted"], )
                //                   // )
                //                   // );
                //                 },
                //                 leading: SizedBox(
                //                   height: 44.sp,
                //                   child: CircleAvatar(
                //                     radius: 16.sp,
                //                     backgroundColor: outerBorderColor,
                //                     child: CircleAvatar(
                //                       radius: 15.sp,
                //                       backgroundColor: taskHeaderColor,
                //                       child: Text('${index + 1}'),
                //                     ),
                //                   ),
                //                 ),
                //                 title: Text('${deletedTaskList[index].title}',
                //                     style: TextStyle(
                //                         decoration: checkList[index]
                //                             ? TextDecoration.lineThrough
                //                             : null)),
                //                 subtitle: Text(
                //                   '${deletedTaskList[index].description}',
                //                   style: TextStyle(
                //                       decoration: checkList[index]
                //                           ? TextDecoration.lineThrough
                //                           : null),
                //                 ),
                //                 trailing: Checkbox(
                //                   // tristate: taskList[index].isDone,
                //                   activeColor: Colors.lightBlueAccent,
                //                   value: checkList[index],
                //                   onChanged: (checkBoxCallBacks) {
                //                     // setState(() {
                //                     checkList[index] = checkBoxCallBacks!;
                //                     //  final remove =  taskList.removeAt(index);
                //                     //  taskList.add(remove);
                //                     //removeItem(index);
                //                     //  key.currentState!.insertItem(taskList.length, duration:Duration(milliseconds: 5));
                //                     //});
                //                   },
                //                 ),
                //               );
                //             }),
                //       )
                //     : const SizedBox()
              ],
            ));
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTask(),
              ));
        },
        child: const Icon(Icons.add),
        backgroundColor: appColor,
      ),
    );
  }
}
