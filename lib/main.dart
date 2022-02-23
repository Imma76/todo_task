import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/model/add_task_model.dart';


import 'fetchers/url_endpoint.dart';
import 'model/delete_task_model.dart';
import 'model/get_task_model.dart';
import 'model/update_task_model.dart';
import 'ui/home_page.dart';
void main() async{
  await initHiveForFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //var httpLink = HttpLink( "https://todolistassessment.hasura.app/v1/graphql");
  //ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(link:HttpLink("https://todolistassessment.hasura.app/v1/graphql"), cache: InMemoryStore() ));
  // This widget is the root of your application.
 Api api = Api();
  @override
  Widget build(BuildContext context) {
    return
      GraphQLProvider(
        client: api.client(),
        child: ScreenUtilInit(
           builder: () {
             return MultiProvider(
               providers:[
                 ChangeNotifierProvider(create: (_)=>AddTaskModel(),),
                 ChangeNotifierProvider(create: (_)=>GetTaskModel(),),
                 ChangeNotifierProvider(create: (_)=>DeleteTaskModel(),),
                 ChangeNotifierProvider(create: (_)=> UpdateTaskModel(),),

                 
               ],
               child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  home: const HomePage(),
        
          ),
           
             );
      
           },
           designSize:const Size(360, 800),
      
         ),
      );
  }
}
