import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todo_task/constants.dart';




class Api{
  ValueNotifier<GraphQLClient> client(){
    final HttpLink httpLink = HttpLink(
    url,
    defaultHeaders: {
      'x-hasura-admin-secret':token,
    },
  );
    final AuthLink authLink = AuthLink(
    getToken: ()  => 'Bearer $token',
    // OR
    // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>', 
   );

    ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(link: httpLink,
     cache: GraphQLCache(store:HiveStore())));
    return client;
  }
}