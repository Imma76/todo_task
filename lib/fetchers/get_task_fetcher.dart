class GetAllTask{
  static String getTask = """
query GetAllTasks(\$developer_id: String!) {
  tasks(where: {developer_id: {_eq: \$developer_id}}) {
    id
    developer_id
    description
    created_at
    isCompleted
    title
    updated_at
  }
}

""";
}