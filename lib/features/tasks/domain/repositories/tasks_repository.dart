import '../entities/task.dart';

abstract class TasksRepository {
  Future<Task> createTask(Task task);
  Future<Task> getTaskDetails(int taskId);
}
