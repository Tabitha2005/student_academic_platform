import 'package:flutter/material.dart';

class AcademicSession {
  final String id;
  final String title;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String location;
  final String sessionType; // Class, Study Group, PSL, Mastery
  bool isPresent;

  AcademicSession({
    required this.id,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.sessionType,
    this.isPresent = false,
  });

  // Create a copy with some fields modified
  AcademicSession copyWith({
    String? id,
    String? title,
    DateTime? date,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    String? location,
    String? sessionType,
    bool? isPresent,
  }) {
    return AcademicSession(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      location: location ?? this.location,
      sessionType: sessionType ?? this.sessionType,
      isPresent: isPresent ?? this.isPresent,
    );
  }
}
