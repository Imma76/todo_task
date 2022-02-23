
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todo_task/constants.dart';
import 'package:todo_task/fetchers/update_task_fetcher.dart';
import 'package:todo_task/fetchers/url_endpoint.dart';

class UpdateTaskModel extends ChangeNotifier{

  bool _status = false;
  String _response = "";
  bool get getStatus => _status;
  String get getResponse => _response;
  List taskList = [];
  final Api api = Api();
 //add Task
  void updateTask({required String title,required String description, bool? isCompleted, String? id})async{
    _status = true;
    _response = "hold on....";
    
    ValueNotifier<GraphQLClient> _client = api.client();
    QueryResult result = await _client.value.mutate(MutationOptions(document: gql(UpdateTaskFetcher.updateTask,), variables: {
    
     'id':id,
     'payload':{"isCompleted":isCompleted,"title":title, "description":description}

    }));
    if(result.hasException){
      print(result.exception);
      _status = false;
      notifyListeners();
      if(result.exception!.graphqlErrors.isEmpty){
        
        _response = "No internet";
      }else{
        _response = result.exception!.graphqlErrors[0].message.toString();
      }
    }else{
      //print(result.data);
     // taskList = result.data!['tasks'];
      _status = false;
      _response = "tasks has been updated";
      notifyListeners();
    }
  }
  void clear(){
    _response = '';
    notifyListeners();
  }
}