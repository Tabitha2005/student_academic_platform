import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/alu_theme.dart';
import '../state/app_state.dart';
import '../models/assignment.dart';

class AssignmentCard extends StatelessWidget {
  final Assignment assignment;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleComplete;

  const AssignmentCard({
    super.key,
    required this.assignment,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleComplete,
  });

  Color _getPriorityColor() {
    switch (assignment.priority) {
      case 'High':
        return ALUTheme.warningRed;
      case 'Medium':
        return ALUTheme.accentYellow;
      case 'Low':
        return ALUTheme.successGreen;
      default:
        return ALUTheme.accentYellow;
    }
  }

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
                Checkbox(
                  value: assignment.isCompleted,
                  onChanged: (_) => onToggleComplete(),
                  activeColor: ALUTheme.successGreen,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        assignment.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ALUTheme.textDark,
                          decoration: assignment.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        assignment.course,
                        style: TextStyle(
                          fontSize: 14,
                          color: ALUTheme.textDark.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getPriorityColor().withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    assignment.priority,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _getPriorityColor(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: ALUTheme.accentYellow.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    assignment.category,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: ALUTheme.accentYellow,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  appState.getFormattedDate(assignment.dueDate),
                  style: TextStyle(
                    fontSize: 12,
                    color: ALUTheme.textDark.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
      ),
    );
  }
}
