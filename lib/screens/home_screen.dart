import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_provider.dart';
import '../widgets/task_item.dart';
import 'add_task_screen.dart';
import '../theme/theme_provider.dart';
import 'task_detail_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8) {
        ref.read(taskProvider.notifier).fetchMoreTasks();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: isError ? Colors.red[400] : Colors.green[400],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskProvider);
    final isDark = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: isDark ? Colors.white : Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
        ),
        elevation: 4,
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [Colors.blueGrey[900]!, Colors.blueGrey[700]!]
                : [Colors.blue[100]!, Colors.blue[300]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: tasks.when(
          data: (taskList) => RefreshIndicator(
            onRefresh: () async {
              try {
                await ref.read(taskProvider.notifier).fetchTasks();
                _showSnackBar('Tasks refreshed successfully');
              } catch (e) {
                _showSnackBar('Failed to refresh tasks: $e', isError: true);
              }
            },
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: taskList.length + 1,
              itemBuilder: (context, index) {
                if (index == taskList.length) {
                  return ref.watch(taskProvider.notifier).hasMore
                      ? Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      : const SizedBox.shrink();
                }
                return AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: const Offset(0, 0.2),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent:
                                ModalRoute.of(context)!.animation ??
                                AlwaysStoppedAnimation(1.0),
                            curve: Curves.easeOut,
                          ),
                        ),
                    child: TaskItem(
                      task: taskList[index],
                      onTap: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>
                              TaskDetailScreen(task: taskList[index]),
                          transitionsBuilder: (_, animation, __, child) =>
                              SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              ),
                        ),
                      ),
                      onToggle: (completed) async {
                        try {
                          await ref
                              .read(taskProvider.notifier)
                              .toggleTaskCompletion(
                                taskList[index].id,
                                completed,
                              );
                          _showSnackBar('Task updated successfully');
                        } catch (e) {
                          _showSnackBar(
                            'Failed to update task: $e',
                            isError: true,
                          );
                        }
                      },
                      onDelete: () async {
                        try {
                          await ref
                              .read(taskProvider.notifier)
                              .deleteTask(taskList[index].id);
                          _showSnackBar('Task deleted successfully');
                        } catch (e) {
                          _showSnackBar(
                            'Failed to delete task: $e',
                            isError: true,
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          loading: () => Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          ),
          error: (e, _) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Failed to load tasks: $e',
                  style: TextStyle(
                    color: isDark ? Colors.red[300] : Colors.red[400],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  onPressed: () async {
                    try {
                      await ref.read(taskProvider.notifier).fetchTasks();
                      _showSnackBar('Tasks loaded successfully');
                    } catch (e) {
                      _showSnackBar('Failed to load tasks: $e', isError: true);
                    }
                  },
                  child: const Text('Retry', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTapDown: (_) => setState(() {}),
        onTapUp: (_) => setState(() {}),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()
            ..scale(ref.read(taskProvider.notifier).isLoading ? 0.9 : 1.0),
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: isDark ? Colors.white : Colors.black,
            onPressed: () => Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const AddTaskScreen(),
                transitionsBuilder: (_, animation, __, child) =>
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
              ),
            ),
            child: const Icon(Icons.add, size: 28),
          ),
        ),
      ),
    );
  }
}
