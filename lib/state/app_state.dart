import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/assignment.dart';
import '../models/academic_session.dart';
import '../models/announcement.dart';

class AppState extends ChangeNotifier {
  final List<Assignment> _assignments = [];
  final List<AcademicSession> _sessions = [];
  final List<Announcement> _announcements = [];

  // Getters
  List<Assignment> get assignments => _assignments;
  List<AcademicSession> get sessions => _sessions;
  List<Announcement> get announcements => _announcements;

  // Assignment Methods
  void addAssignment(Assignment assignment) {
    _assignments.add(assignment);
    notifyListeners();
  }

  void updateAssignment(Assignment assignment) {
    final index = _assignments.indexWhere((a) => a.id == assignment.id);
    if (index != -1) {
      _assignments[index] = assignment;
      notifyListeners();
    }
  }

  void deleteAssignment(String id) {
    _assignments.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  void toggleAssignmentCompletion(String id) {
    final assignment = _assignments.firstWhere(
      (a) => a.id == id,
      orElse: () => Assignment(
        id: '',
        title: '',
        course: '',
        dueDate: DateTime.now(),
        priority: 'Medium',
        category: 'Formative',
      ),
    );
    if (assignment.id.isNotEmpty) {
      assignment.isCompleted = !assignment.isCompleted;
      notifyListeners();
    }
  }

  // Announcement Methods
  void addAnnouncement(Announcement announcement) {
    _announcements.insert(0, announcement);
    notifyListeners();
  }

  void deleteAnnouncement(String id) {
    _announcements.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  // Session Methods
  void addSession(AcademicSession session) {
    _sessions.add(session);
    notifyListeners();
  }

  void updateSession(AcademicSession session) {
    final index = _sessions.indexWhere((s) => s.id == session.id);
    if (index != -1) {
      _sessions[index] = session;
      notifyListeners();
    }
  }

  void deleteSession(String id) {
    _sessions.removeWhere((s) => s.id == id);
    notifyListeners();
  }

  void markAttendance(String id, bool isPresent) {
    final session = _sessions.firstWhere(
      (s) => s.id == id,
      orElse: () => AcademicSession(
        id: '',
        title: '',
        date: DateTime.now(),
        startTime: TimeOfDay.now(),
        endTime: TimeOfDay.now(),
        location: '',
        sessionType: 'Class',
      ),
    );
    if (session.id.isNotEmpty) {
      session.isPresent = isPresent;
      notifyListeners();
    }
  }

  // Filtering Methods
  List<Assignment> getAssignmentsByCategory(String category) {
    return _assignments.where((a) => a.category == category).toList();
  }

  List<Assignment> getAllAssignments() {
    return _assignments;
  }

  // Calculation Methods
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
              a.dueDate.isAfter(now) &&
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
