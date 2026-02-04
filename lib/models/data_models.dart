import 'package:flutter/material.dart';

enum PriorityLevel { high, medium, low }

enum SessionType { classSession, masterySession, studyGroup, pslMeeting }

class Assignment {
  final String id;
  final String title;
  final String courseName;
  final DateTime dueDate;
  final PriorityLevel priority;
  bool isCompleted;

  Assignment({
    required this.id,
    required this.title,
    required this.courseName,
    required this.dueDate,
    this.priority = PriorityLevel.medium,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'courseName': courseName,
      'dueDate': dueDate.toIso8601String(),
      'priority': priority.toString(),
      'isCompleted': isCompleted,
    };
  }

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'],
      title: json['title'],
      courseName: json['courseName'],
      dueDate: DateTime.parse(json['dueDate']),
      priority: PriorityLevel.values.firstWhere(
        (e) => e.toString() == json['priority'],
        orElse: () => PriorityLevel.medium,
      ),
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}

class AcademicSession {
  final String id;
  final String title;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String? location;
  final SessionType sessionType;
  bool isAttended;

  AcademicSession({
    required this.id,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.location,
    this.sessionType = SessionType.classSession,
    this.isAttended = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'startTime': '${startTime.hour}:${startTime.minute}',
      'endTime': '${endTime.hour}:${endTime.minute}',
      'location': location,
      'sessionType': sessionType.toString(),
      'isAttended': isAttended,
    };
  }

  factory AcademicSession.fromJson(Map<String, dynamic> json) {
    final startParts = (json['startTime'] as String).split(':');
    final endParts = (json['endTime'] as String).split(':');

    return AcademicSession(
      id: json['id'],
      title: json['title'],
      date: DateTime.parse(json['date']),
      startTime: TimeOfDay(
        hour: int.parse(startParts[0]),
        minute: int.parse(startParts[1]),
      ),
      endTime: TimeOfDay(
        hour: int.parse(endParts[0]),
        minute: int.parse(endParts[1]),
      ),
      location: json['location'],
      sessionType: SessionType.values.firstWhere(
        (e) => e.toString() == json['sessionType'],
        orElse: () => SessionType.classSession,
      ),
      isAttended: json['isAttended'] ?? false,
    );
  }
}

class AttendanceRecord {
  final String sessionId;
  final bool isPresent;

  AttendanceRecord({required this.sessionId, required this.isPresent});
}
