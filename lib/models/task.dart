import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
@HiveType(typeId: 0)
class Task with _$Task {
  const factory Task({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) String? description,
    @HiveField(3) required DateTime deadline,
    @HiveField(4) @Default(false) bool isDone,
    @HiveField(5) required DateTime createdAt,
    @HiveField(6) DateTime? completedAt,
  }) = _Task;

  factory Task.create({
    required String title,
    String? description,
    required DateTime deadline,
  }) {
    return Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      deadline: deadline,
      createdAt: DateTime.now(),
    );
  }
}

extension TaskExtension on Task {
  Task markAsCompleted() => copyWith(isDone: true, completedAt: DateTime.now());
  Task markAsNotCompleted() => copyWith(isDone: false, completedAt: null);
}
