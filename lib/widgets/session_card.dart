import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/alu_theme.dart';
import '../state/app_state.dart';
import '../models/academic_session.dart';

class SessionCard extends StatelessWidget {
  final AcademicSession session;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Function(bool) onToggleAttendance;

  const SessionCard({
    super.key,
    required this.session,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleAttendance,
  });

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        session.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: session.isPresent
                              ? ALUTheme.successGreen
                              : ALUTheme.textDark,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: ALUTheme.textDark.withValues(alpha: 0.6),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '${appState.getFormattedTime(session.startTime)} - ${appState.getFormattedTime(session.endTime)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: ALUTheme.textDark.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: ALUTheme.textDark.withValues(alpha: 0.6),
                          ),
                          SizedBox(width: 8),
                          Text(
                            session.location,
                            style: TextStyle(
                              fontSize: 12,
                              color: ALUTheme.textDark.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: ALUTheme.accentYellow.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    session.sessionType,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: ALUTheme.accentYellow,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Divider(height: 1),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => onToggleAttendance(!session.isPresent),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: session.isPresent
                              ? ALUTheme.successGreen.withValues(alpha: 0.2)
                              : ALUTheme.dividerGray.withValues(alpha: 0.3),
                        ),
                        child: Icon(
                          session.isPresent ? Icons.check : Icons.close,
                          color: session.isPresent
                              ? ALUTheme.successGreen
                              : ALUTheme.textDark.withValues(alpha: 0.5),
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      session.isPresent ? 'Present' : 'Absent',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: session.isPresent
                            ? ALUTheme.successGreen
                            : ALUTheme.textDark.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: onEdit,
                      child: Text(
                        'Edit',
                        style: TextStyle(color: ALUTheme.accentYellow),
                      ),
                    ),
                    TextButton(
                      onPressed: onDelete,
                      child: Text(
                        'Delete',
                        style: TextStyle(color: ALUTheme.warningRed),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
