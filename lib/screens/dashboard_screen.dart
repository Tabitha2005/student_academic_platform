import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../theme/alu_theme.dart';
import '../state/app_state.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ALUTheme.primaryDark,
      appBar: AppBar(title: Text('Dashboard'), elevation: 0),
      body: Consumer<AppState>(
        builder: (context, appState, _) {
          final now = DateTime.now();
          final currentDate = DateFormat('EEEE, MMMM d, yyyy').format(now);
          final weekNumber = appState.getWeekNumber(now);
          final todaySessions = appState.getTodaySessions();
          final upcomingAssignments = appState.getUpcomingAssignments();
          final attendancePercentage = appState.calculateAttendancePercentage();
          final pendingCount = appState.getPendingAssignmentsCount();
          final isAtRisk = attendancePercentage < 75;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ALUTheme.cardWhite,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentDate,
                        style: TextStyle(
                          fontSize: 14,
                          color: ALUTheme.textDark.withValues(alpha: 0.7),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Week $weekNumber',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ALUTheme.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                if (isAtRisk)
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ALUTheme.warningRed,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning,
                          color: ALUTheme.cardWhite,
                          size: 24,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Your attendance is below 75%. Take action now!',
                            style: TextStyle(
                              color: ALUTheme.cardWhite,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (isAtRisk) SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ALUTheme.cardWhite,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Attendance',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ALUTheme.textDark,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: CircularProgressIndicator(
                                  value: attendancePercentage / 100,
                                  strokeWidth: 6,
                                  backgroundColor: ALUTheme.dividerGray
                                      .withValues(alpha: 0.3),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    isAtRisk
                                        ? ALUTheme.warningRed
                                        : ALUTheme.accentYellow,
                                  ),
                                ),
                              ),
                              Text(
                                '${attendancePercentage.toStringAsFixed(0)}%',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: ALUTheme.textDark,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              isAtRisk
                                  ? 'You are at risk. Attend more sessions!'
                                  : 'Great! Keep up the attendance.',
                              style: TextStyle(
                                fontSize: 14,
                                color: ALUTheme.textDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ALUTheme.cardWhite,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pending Assignments',
                            style: TextStyle(
                              fontSize: 14,
                              color: ALUTheme.textDark.withValues(alpha: 0.7),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '$pendingCount',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: ALUTheme.textDark,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.assignment,
                        color: ALUTheme.accentYellow,
                        size: 48,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Today's Sessions",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ALUTheme.textWhite,
                  ),
                ),
                SizedBox(height: 8),
                if (todaySessions.isEmpty)
                  Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: ALUTheme.cardWhite,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'No sessions scheduled today',
                        style: TextStyle(
                          color: ALUTheme.textDark.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                  )
                else
                  ...todaySessions.map((session) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: ALUTheme.cardWhite,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            session.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: ALUTheme.textDark,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '${appState.getFormattedTime(session.startTime)} - ${appState.getFormattedTime(session.endTime)} • ${session.location}',
                            style: TextStyle(
                              fontSize: 12,
                              color: ALUTheme.textDark.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                SizedBox(height: 16),
                Text(
                  'Upcoming Assignments (Next 7 Days)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ALUTheme.textWhite,
                  ),
                ),
                SizedBox(height: 8),
                if (upcomingAssignments.isEmpty)
                  Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: ALUTheme.cardWhite,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'No upcoming assignments',
                        style: TextStyle(
                          color: ALUTheme.textDark.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                  )
                else
                  ...upcomingAssignments.map((assignment) {
                    final isUrgent =
                        assignment.dueDate.difference(now).inDays <= 1;
                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: ALUTheme.cardWhite,
                        borderRadius: BorderRadius.circular(12),
                        border: isUrgent
                            ? Border.all(color: ALUTheme.warningRed, width: 2)
                            : Border.all(color: ALUTheme.dividerGray),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            assignment.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: ALUTheme.textDark,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                assignment.course,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ALUTheme.textDark.withValues(
                                    alpha: 0.6,
                                  ),
                                ),
                              ),
                              Text(
                                appState.getFormattedDate(assignment.dueDate),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: isUrgent
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isUrgent
                                      ? ALUTheme.warningRed
                                      : ALUTheme.textDark.withValues(
                                          alpha: 0.6,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
              ],
            ),
          );
        },
      ),
    );
  }
}
