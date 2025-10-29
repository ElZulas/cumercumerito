import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_task_manager/core/network/dio_client.dart';
import 'package:smart_task_manager/core/network/network_exceptions.dart';
import 'package:smart_task_manager/features/tasks/data/datasources/tasks_remote_datasource.dart';
import 'package:smart_task_manager/features/tasks/data/repositories/tasks_repository_impl.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task.dart';
import 'package:smart_task_manager/features/tasks/domain/repositories/tasks_repository.dart';

final dioClientProvider = Provider<DioClient>((ref) => DioClient());

final tasksRemoteDataSourceProvider = Provider<TasksRemoteDataSource>(
  (ref) => TasksRemoteDataSource(ref.read(dioClientProvider)),
);

final tasksRepositoryProvider = Provider<TasksRepository>(
  (ref) => TasksRepositoryImpl(ref.read(tasksRemoteDataSourceProvider)),
);

final tasksProvider = Provider<TasksController>(
  (ref) => TasksController(ref.read(tasksRepositoryProvider)),
);

class TasksController {
  TasksController(this._repository);

  final TasksRepository _repository;

  Future<void> createTask(String title, String description) async {
    try {
      await _repository.createTask(
        Task(title: title, description: description),
      );
    } on NetworkException {
      rethrow;
    }
  }
}
