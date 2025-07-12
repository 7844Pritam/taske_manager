import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../services/api_service.dart';

final taskProvider =
    StateNotifierProvider<TaskNotifier, AsyncValue<List<Task>>>((ref) {
      return TaskNotifier();
    });

class TaskNotifier extends StateNotifier<AsyncValue<List<Task>>> {
  TaskNotifier() : super(const AsyncValue.loading()) {
    fetchTasks();
  }

  int _currentPage = 1;
  final int _pageSize = 20;
  bool _hasMore = true;

  bool get hasMore => _hasMore;
  bool get isLoading => state.isLoading; // Added isLoading getter

  Future<void> fetchTasks() async {
    state = const AsyncValue.loading();
    try {
      final data = await ApiService.getTasks(page: 1, limit: _pageSize);
      _currentPage = 1;
      _hasMore = data.length == _pageSize;
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow; // Rethrow for SnackBar in UI
    }
  }

  Future<void> fetchMoreTasks() async {
    if (!_hasMore || state.isLoading) return;
    try {
      final newData = await ApiService.getTasks(
        page: _currentPage + 1,
        limit: _pageSize,
      );
      _currentPage++;
      _hasMore = newData.length == _pageSize;
      state = AsyncValue.data([...state.value ?? [], ...newData]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> addTask(Task task) async {
    try {
      final newTask = await ApiService.createTask(task);
      state = AsyncValue.data([...state.value ?? [], newTask]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      final updatedTask = await ApiService.updateTask(task);
      state = AsyncValue.data([
        for (final t in state.value ?? [])
          t.id == updatedTask.id ? updatedTask : t,
      ]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> toggleTaskCompletion(int id, bool completed) async {
    try {
      final updatedTask = await ApiService.patchTask(id, completed: completed);
      state = AsyncValue.data([
        for (final t in state.value ?? [])
          t.id == updatedTask.id ? updatedTask : t,
      ]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await ApiService.deleteTask(id);
      state = AsyncValue.data([
        for (final t in state.value ?? [])
          if (t.id != id) t,
      ]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}
