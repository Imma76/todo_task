
class UpdateTaskFetcher{
static String updateTask = """
mutation UpdateTask(\$payload: tasks_set_input = {}, \$id: uuid!) {
  update_tasks_by_pk(pk_columns: {id: \$id}, _set: \$payload) {
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
