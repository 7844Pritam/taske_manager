import 'package:dio/dio.dart';
import '../models/task_model.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'User-Agent': 'Flutter-App/1.0',
      },
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  );

  static Future<List<Task>> getTasks({int page = 1, int limit = 20}) async {
    try {
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/todos',
        queryParameters: {'_start': (page - 1) * limit, '_limit': limit},
      );
      return (response.data as List).map((e) => Task.fromJson(e)).toList();
    } catch (e) {
      print('Error fetching tasks: $e');
      if (e is DioException && e.response != null) {
        print('Response status: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
        print('Response headers: ${e.response?.headers}');
      }
      // Fallback to dummyjson.com if JSONPlaceholder fails
      try {
        final response = await _dio.get(
          'https://dummyjson.com/todos',
          queryParameters: {'skip': (page - 1) * limit, 'limit': limit},
        );
        return (response.data['todos'] as List)
            .map((e) => Task.fromJson(e))
            .toList();
      } catch (fallbackError) {
        throw Exception('Failed to load tasks: $e');
      }
    }
  }

  static Future<Task> createTask(Task task) async {
    try {
      final response = await _dio.post(
        'https://jsonplaceholder.typicode.com/todos',
        data: task.toJson(),
      );
      return Task.fromJson(response.data);
    } catch (e) {
      print('Error creating task: $e');
      throw Exception('Failed to create task: $e');
    }
  }

  static Future<Task> updateTask(Task task) async {
    try {
      final response = await _dio.put(
        'https://jsonplaceholder.typicode.com/todos/${task.id}',
        data: task.toJson(),
      );
      return Task.fromJson(response.data);
    } catch (e) {
      print('Error updating task: $e');
      throw Exception('Failed to update task: $e');
    }
  }

  static Future<Task> patchTask(
    int id, {
    bool? completed,
    String? title,
  }) async {
    try {
      final response = await _dio.patch(
        'https://jsonplaceholder.typicode.com/todos/$id',
        data: {
          if (completed != null) 'completed': completed,
          if (title != null) 'title': title,
        },
      );
      return Task.fromJson(response.data);
    } catch (e) {
      print('Error patching task: $e');
      throw Exception('Failed to patch task: $e');
    }
  }

  static Future<void> deleteTask(int id) async {
    try {
      await _dio.delete('https://jsonplaceholder.typicode.com/todos/$id');
    } catch (e) {
      print('Error deleting task: $e');
      throw Exception('Failed to delete task: $e');
    }
  }
}
