import 'package:todo_task/constants.dart';

class AddTaskFetcher{
  static String addTask = """

  mutation InsertTask(\$description: String!, \$developer_id: String!, \$title: String!) {
  insert_tasks_one(object: {title: \$title, developer_id: \$developer_id, description: \$description}) {
    created_at
    description
    developer_id
    id
    isCompleted
    title
    updated_at
  }
}
    """;

}