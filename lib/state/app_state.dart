import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/assignment.dart';
import '../models/academic_session.dart';
import '../models/announcement.dart';

/// AppState manages the global state of the application using the Provider pattern.
/// It handles data storage and business logic for assignments, sessions, and announcements.
class AppState extends ChangeNotifier {
  /// Internal storage for assignments.
  final List<Assignment> _assignments = [];
  
  /// Internal storage for academic sessions.
  final List<AcademicSession> _sessions = [];
  
  /// Internal storage for system announcements.
  final List<Announcement> _announcements = [];

  // --- Getters ---
  
  List<Assignment> get assignments => _assignments;
  List<AcademicSession> get sessions => _sessions;
  List<Announcement> get announcements => _announcements;

  // --- Assignment Methods ---

  /// Adds a new assignment to the list and notifies listeners to update the UI.
  void addAssignment(Assignment assignment) {
    _assignments.add(assignment);
    notifyListeners();
  }

  /// Updates an existing assignment by matching its unique ID.
  void updateAssignment(Assignment assignment) {
    final index = _assignments.indexWhere((a) => a.id == assignment.id);
    if (index != -1) {
      _assignments[index] = assignment;
      notifyListeners();
    }
  }

  /// Removes an assignment from the list based on its ID.
  void deleteAssignment(String id) {
    _assignments.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  /// Toggles the completion status of an assignment.
  void toggleAssignmentCompletion(String id) {
    final index = _assignments.indexWhere((a) => a.id == id);
    if (index != -1) {
      _assignments[index].isCompleted = !_assignments[index].isCompleted;
      notifyListeners();
    }
  }

  // --- Announcement Methods ---

  /// Inserts a new announcement at the top of the list.
  void addAnnouncement(Announcement announcement) {
    _announcements.insert(0, announcement);
    notifyListeners();
  }

  /// Removes an announcement by its ID.
  void deleteAnnouncement(String id) {
    _announcements.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  // --- Session Methods ---

  /// Adds a new academic session to the schedule.
  void addSession(AcademicSession session) {
    _sessions.add(session);
    notifyListeners();
  }

  /// Updates details of an existing session.
  void updateSession(AcademicSession session) {
    final index = _sessions.indexWhere((s) => s.id == session.id);
    if (index != -1) {
      _sessions[index] = session;
      notifyListeners();
    }
  }

  /// Cancels/removes a scheduled session.
  void deleteSession(String id) {
    _sessions.removeWhere((s) => s.id == id);
    notifyListeners();
  }

  /// Records whether a student was present or absent for a specific session.
  void markAttendance(String id, bool isPresent) {
    final index = _sessions.indexWhere((s) => s.id == id);
    if (index != -1) {
      _sessions[index].isPresent = isPresent;
      notifyListeners();
    }
  }

  // --- Filtering & Calculation Methods ---

  /// Returns a filtered list of assignments by category (e.g., Formative, Summative).
  List<Assignment> getAssignmentsByCategory(String category) {
    return _assignments.where((a) => a.category == category).toList();
  }

  /// Returns all assignments currently in state.
  List<Assignment> getAllAssignments() {
    return _assignments;
  }

  /// Calculates the overall attendance percentage.
  /// Used for the dashboard metric and the 75% risk warning.
  double calculateAttendancePercentage() {
    if (_sessions.isEmpty) return 0.0;
    int presentCount = _sessions.where((s) => s.isPresent).length;
    return (presentCount / _sessions.length) * 100;
  }

  /// Retrieves assignments that are not completed and due within the next 7 days.
  /// Sorted by due date for priority viewing.
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

  /// Returns sessions scheduled for the current calendar day.
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

  /// Counts assignments that have not been marked as completed.
  int getPendingAssignmentsCount() {
    return _assignments.where((a) => !a.isCompleted).length;
  }

  /// Calculates the percentage of assignments completed.
  double getAssignmentCompletionPercentage() {
    if (_assignments.isEmpty) return 0.0;
    int completedCount = _assignments.where((a) => a.isCompleted).length;
    return (completedCount / _assignments.length) * 100;
  }

  /// Calculates the current academic week number based on the year.
  int getWeekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  /// Formats a DateTime into a readable string (e.g., "Jan 21, 2024").
  String getFormattedDate(DateTime date) {
    return DateFormat("MMM d, yyyy").format(date);
  }

  /// Formats a TimeOfDay into a readable string (e.g., "10:30 AM").
  String getFormattedTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat("h:mm a").format(dt);
  }
}
