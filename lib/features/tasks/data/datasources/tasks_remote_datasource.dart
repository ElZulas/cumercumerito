import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/task_model.dart';
import '../../../../core/network/network_exceptions.dart';

class TasksRemoteDataSource {
  final DioClient _dioClient;

  TasksRemoteDataSource(this._dioClient);

  // POST: Create a new task
  Future<TaskModel> createTask(TaskModel task) async {
    try {
      final Response<dynamic> response = await _dioClient.post(
        '/posts', // JSONPlaceholder endpoint
        data: task.toJson(),
      );
      return TaskModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  // GET: Fetch task details
  Future<TaskModel> getTaskDetails(int taskId) async {
    try {
      final Response<dynamic> response = await _dioClient.get('/posts/$taskId');
      return TaskModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  // GET: Fetch all tasks
  Future<List<TaskModel>> getAllTasks() async {
    try {
      final Response<dynamic> response = await _dioClient.get('/posts');
      final data = response.data as List<dynamic>;
      return data
          .map((dynamic json) =>
              TaskModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }
}
