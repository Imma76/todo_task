
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todo_task/constants.dart';
import 'package:todo_task/fetchers/add_task_fetcher.dart';
import 'package:todo_task/fetchers/url_endpoint.dart';

class AddTaskModel extends ChangeNotifier{

  bool _status = false;
  String _response = "";
  bool get getStatus => _status;
  String get getResponse => _response;

  final Api api = Api();
 //add Task
  void addTask({required String title, required String desc})async{
    _status = true;
    _response = "hold on....";
    notifyListeners();
    ValueNotifier<GraphQLClient> _client = api.client();
    QueryResult result = await _client.value.mutate(MutationOptions(document: gql(AddTaskFetcher.addTask,), variables: {
     'title':title,
     'description':desc, 
     'developer_id':developer_id,

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
      print(result.data);
      _status = false;
      _response = "task has been added";
      notifyListeners();
    }
  }
  void clear(){
    _response = '';
    notifyListeners();
  }
}