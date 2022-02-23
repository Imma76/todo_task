class DeleteTaskFetcher{
  static String deleteTask = """
  mutation DeleteTask(\$id: uuid = "") {
  delete_tasks_by_pk(id: \$id) {
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