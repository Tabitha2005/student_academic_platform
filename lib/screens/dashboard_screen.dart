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
      appBar: AppBar(
        title: const Text('Dashboard'),
        elevation: 0,
        centerTitle: true,
      ),
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: ALUTheme.cardWhite,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: ALUTheme.textDark.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentDate,
                        style: TextStyle(
                          fontSize: 14,
                          color: ALUTheme.textDark.withValues(alpha: 0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Week $weekNumber',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: ALUTheme.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                if (isAtRisk)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ALUTheme.warningRed,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: ALUTheme.warningRed.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.warning_rounded,
                          color: ALUTheme.cardWhite,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Attendance Alert',
                                style: TextStyle(
                                  color: ALUTheme.cardWhite,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Your attendance is below 75%. Attend more sessions!',
                                style: TextStyle(
                                  color: ALUTheme.cardWhite.withValues(
                                    alpha: 0.9,
                                  ),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                if (isAtRisk) const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: ALUTheme.cardWhite,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: ALUTheme.textDark.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Attendance',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ALUTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 90,
                                height: 90,
                                child: CircularProgressIndicator(
                                  value: attendancePercentage / 100,
                                  strokeWidth: 7,
                                  backgroundColor: ALUTheme.dividerGray
                                      .withValues(alpha: 0.2),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    isAtRisk
                                        ? ALUTheme.warningRed
                                        : ALUTheme.accentYellow,
                                  ),
                                ),
                              ),
                              Text(
                                '${attendancePercentage.toStringAsFixed(0)}%',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: ALUTheme.textDark,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isAtRisk ? 'You are at risk' : 'Excellent',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isAtRisk
                                        ? ALUTheme.warningRed
                                        : ALUTheme.successGreen,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  isAtRisk
                                      ? 'Attend more sessions'
                                      : 'Keep up the attendance',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: ALUTheme.textDark.withValues(
                                      alpha: 0.6,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: ALUTheme.cardWhite,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: ALUTheme.textDark.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ],
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
                              color: ALUTheme.textDark.withValues(alpha: 0.6),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '$pendingCount',
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: ALUTheme.textDark,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: ALUTheme.accentYellow.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.assignment,
                          color: ALUTheme.accentYellow,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Today's Sessions",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ALUTheme.textWhite,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                if (todaySessions.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: ALUTheme.cardWhite,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: ALUTheme.dividerGray.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: ALUTheme.textDark.withValues(alpha: 0.3),
                            size: 48,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No sessions scheduled today',
                            style: TextStyle(
                              color: ALUTheme.textDark.withValues(alpha: 0.5),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ...todaySessions.map((session) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ALUTheme.cardWhite,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: ALUTheme.textDark.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          )
                        ],
                        border: Border(
                          left: BorderSide(
                            color: ALUTheme.accentYellow,
                            width: 4,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            session.title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: ALUTheme.textDark,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: ALUTheme.textDark.withValues(alpha: 0.5),
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${appState.getFormattedTime(session.startTime)} - ${appState.getFormattedTime(session.endTime)}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ALUTheme.textDark.withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: ALUTheme.textDark.withValues(alpha: 0.5),
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  session.location.isNotEmpty
                                      ? session.location
                                      : 'No location specified',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: ALUTheme.textDark.withValues(alpha: 0.6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                const SizedBox(height: 24),
                Text(
                  'Upcoming Assignments (Next 7 Days)',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ALUTheme.textWhite,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                if (upcomingAssignments.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: ALUTheme.cardWhite,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: ALUTheme.dividerGray.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.assignment_turned_in,
                            color: ALUTheme.textDark.withValues(alpha: 0.3),
                            size: 48,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No upcoming assignments',
                            style: TextStyle(
                              color: ALUTheme.textDark.withValues(alpha: 0.5),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ...upcomingAssignments.map((assignment) {
                    final isUrgent =
                        assignment.dueDate.difference(now).inDays <= 1;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ALUTheme.cardWhite,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: ALUTheme.textDark.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          )
                        ],
                        border: Border(
                          left: BorderSide(
                            color: isUrgent
                                ? ALUTheme.warningRed
                                : ALUTheme.accentYellow,
                            width: 4,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  assignment.title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: ALUTheme.textDark,
                                  ),
                                ),
                              ),
                              if (isUrgent)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        ALUTheme.warningRed.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'Urgent',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: ALUTheme.warningRed,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                assignment.course,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: ALUTheme.textDark.withValues(
                                    alpha: 0.6,
                                  ),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: ALUTheme.textDark.withValues(
                                      alpha: 0.5,
                                    ),
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    appState.getFormattedDate(assignment.dueDate),
                                    style: TextStyle(
                                      fontSize: 13,
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
                        ],
                      ),
                    );
                  }),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
