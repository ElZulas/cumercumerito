import '../../domain/entities/task.dart';
import '../../domain/repositories/tasks_repository.dart';
import '../datasources/tasks_remote_datasource.dart';
import '../../../../core/network/network_exceptions.dart';
import '../models/task_model.dart';

class TasksRepositoryImpl implements TasksRepository {
  TasksRepositoryImpl(this._remoteDataSource);

  final TasksRemoteDataSource _remoteDataSource;

  @override
  Future<Task> createTask(Task task) async {
    try {
      final taskModel = await _remoteDataSource.createTask(
        TaskModel(
          title: task.title,
          description: task.description,
          completed: task.completed,
        ),
      );
      return Task(
        id: taskModel.id,
        title: taskModel.title,
        description: taskModel.description,
        completed: taskModel.completed,
      );
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException('Failed to create task: $e');
    }
  }

  @override
  Future<Task> getTaskDetails(int taskId) async {
    try {
      final taskModel = await _remoteDataSource.getTaskDetails(taskId);
      return Task(
        id: taskModel.id,
        title: taskModel.title,
        description: taskModel.description,
        completed: taskModel.completed,
      );
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException('Failed to fetch task: $e');
    }
  }
}
