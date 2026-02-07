import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/assignment.dart';
import '../models/academic_session.dart';
import '../models/announcement.dart';


class AppState extends ChangeNotifier {
  static const String _keyAssignments = 'assignments';
  static const String _keySessions = 'sessions';
  static const String _keyAnnouncements = 'announcements';

  final List<Assignment> _assignments = [];
  final List<AcademicSession> _sessions = [];
  final List<Announcement> _announcements = [];

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    
    final assignmentsJson = prefs.getString(_keyAssignments);
    if (assignmentsJson != null) {
      final List<dynamic> assignmentsList = json.decode(assignmentsJson);
      _assignments.clear();
      _assignments.addAll(
        assignmentsList.map((json) => Assignment.fromJson(json)).toList(),
      );
    }

    final sessionsJson = prefs.getString(_keySessions);
    if (sessionsJson != null) {
      final List<dynamic> sessionsList = json.decode(sessionsJson);
      _sessions.clear();
      _sessions.addAll(
        sessionsList.map((json) => AcademicSession.fromJson(json)).toList(),
      );
    }

    final announcementsJson = prefs.getString(_keyAnnouncements);
    if (announcementsJson != null) {
      final List<dynamic> announcementsList = json.decode(announcementsJson);
      _announcements.clear();
      _announcements.addAll(
        announcementsList.map((json) => Announcement.fromJson(json)).toList(),
      );
    }

    notifyListeners();
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();

    final assignmentsJson = json.encode(
      _assignments.map((a) => a.toJson()).toList(),
    );
    await prefs.setString(_keyAssignments, assignmentsJson);

    final sessionsJson = json.encode(
      _sessions.map((s) => s.toJson()).toList(),
    );
    await prefs.setString(_keySessions, sessionsJson);

    final announcementsJson = json.encode(
      _announcements.map((a) => a.toJson()).toList(),
    );
    await prefs.setString(_keyAnnouncements, announcementsJson);
  }

  List<Assignment> get assignments => _assignments;
  List<AcademicSession> get sessions => _sessions;
  List<Announcement> get announcements => _announcements;

  void addAssignment(Assignment assignment) {
    _assignments.add(assignment);
    _saveData();
    notifyListeners();
  }

  void updateAssignment(Assignment assignment) {
    final index = _assignments.indexWhere((a) => a.id == assignment.id);
    if (index != -1) {
      _assignments[index] = assignment;
      _saveData();
      notifyListeners();
    }
  }


  void deleteAssignment(String id) {
    _assignments.removeWhere((a) => a.id == id);
    _saveData();
    notifyListeners();
  }

  void toggleAssignmentCompletion(String id) {
    final index = _assignments.indexWhere((a) => a.id == id);
    if (index != -1) {
      _assignments[index].isCompleted = !_assignments[index].isCompleted;
      _saveData();
      notifyListeners();
    }
  }

  void addAnnouncement(Announcement announcement) {
    _announcements.insert(0, announcement);
    _saveData();
    notifyListeners();
  }


  void deleteAnnouncement(String id) {
    _announcements.removeWhere((a) => a.id == id);
    _saveData();
    notifyListeners();
  }

  void addSession(AcademicSession session) {
    _sessions.add(session);
    _saveData();
    notifyListeners();
  }

  void updateSession(AcademicSession session) {
    final index = _sessions.indexWhere((s) => s.id == session.id);
    if (index != -1) {
      _sessions[index] = session;
      _saveData();
      notifyListeners();
    }
  }

  void deleteSession(String id) {
    _sessions.removeWhere((s) => s.id == id);
    _saveData();
    notifyListeners();
  }

  void markAttendance(String id, bool isPresent) {
    final index = _sessions.indexWhere((s) => s.id == id);
    if (index != -1) {
      _sessions[index].isPresent = isPresent;
      _saveData();
      notifyListeners();
    }
  }

  List<Assignment> getAssignmentsByCategory(String category) {
    return _assignments.where((a) => a.category == category).toList();
  }

  List<Assignment> getAllAssignments() {
    return _assignments;
  }

  double calculateAttendancePercentage() {
    if (_sessions.isEmpty) return 0.0;
    int presentCount = _sessions.where((s) => s.isPresent).length;
    return (presentCount / _sessions.length) * 100;
  }

  List<Assignment> getUpcomingAssignments() {
    final now = DateTime.now();
    final sevenDaysLater = now.add(Duration(days: 7));

    return _assignments
        .where(
          (a) =>
              !a.isCompleted &&
              a.dueDate.isAfter(now.subtract(const Duration(minutes: 1))) &&
              a.dueDate.isBefore(sevenDaysLater),
        )
        .toList()
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  List<AcademicSession> getTodaySessions() {
    final now = DateTime.now();
    return _sessions
        .where(
          (s) =>
              s.date.year == now.year &&
              s.date.month == now.month &&
              s.date.day == now.day,
        )
        .toList()
      ..sort(
        (a, b) => a.startTime.toString().compareTo(b.startTime.toString()),
      );
  }

  int getPendingAssignmentsCount() {
    return _assignments.where((a) => !a.isCompleted).length;
  }

  double getAssignmentCompletionPercentage() {
    if (_assignments.isEmpty) return 0.0;
    int completedCount = _assignments.where((a) => a.isCompleted).length;
    return (completedCount / _assignments.length) * 100;
  }
  
  int getWeekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }
  
  String getFormattedDate(DateTime date) {
    return DateFormat("MMM d, yyyy").format(date);
  }
  
  String getFormattedTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat("h:mm a").format(dt);
  }
}
