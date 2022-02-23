import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/constants.dart';
import 'package:todo_task/model/add_task_model.dart';
import 'package:todo_task/model/delete_task_model.dart';

class AddTask extends StatelessWidget {
 AddTask({Key? key, }) : super(key: key);

  

  // @override
  // void dispose() {
  //   titleController.dispose();
  //   descController.dispose();
  //   super.dispose();
  // }
  
    final titleController = TextEditingController();
  final descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const  Text("Create Task"),backgroundColor: appColor,
       ),
      body: Padding(
        padding:  EdgeInsets.all(16.0.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 19.h,),
           
           Text("Title", style: TextStyle(fontSize: 14.sp),),
           SizedBox(height: 8.h,),
           Container(
             height: 48.h,width:324.w,
             decoration: BoxDecoration( color: const Color(0xffF5F5F5),borderRadius: BorderRadius.circular(8)),
             child:  TextField(
               controller: titleController,
               decoration:const InputDecoration(
                 //fillColor: Color(0xffF5F5F5),
                 border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), 
                borderSide: BorderSide.none,
                 )),
                 
             )
             ),
          SizedBox(height: 16.h,),
           
            Text("Description", style: TextStyle(fontSize: 14.sp),),
           SizedBox(height: 8.h,),
           Container(
             height: 96.h,width:328.w,
             decoration: BoxDecoration( color: const Color(0xffF5F5F5),borderRadius: BorderRadius.circular(8)),
             child:  TextField(
               controller: descController,
               decoration: const InputDecoration(
                 //fillColor: Color(0xffF5F5F5),
                 border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), 
                borderSide: BorderSide.none,
                 )),
                 
             ),
        
             ),
             SizedBox(height: 24.h,),
           
             Consumer<AddTaskModel>(
               
               builder: (context,task , child) {
                 WidgetsBinding.instance!.addPostFrameCallback((_) {
                    if(task.getResponse != ""){
                      // ignore: unnecessary_string_interpolations
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(task.getResponse)));
                       task.clear();
                 
                      }
                     
                  //  if(task.getResponse == "task has been added"){
                  //        titleController.clear();
                  //        descController.clear();
                  //     }
                    
                   });
                 return TextButton(onPressed: task.getStatus == true? null:(){
                   
                   if(titleController.text.isNotEmpty && descController.text.isNotEmpty){
                     task.addTask(title: titleController.text.trim(), desc: descController.text.trim());                     
                    }
        
                 }, child: task.getStatus == true? const Text("loading....."): const Text("Save"), style: TextButton.styleFrom(fixedSize: Size(328.w, 48.h), primary: Colors.white, backgroundColor: appColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.sp))),);
               }
             ),
          ],),
        ),
      ),
    );
  }
}