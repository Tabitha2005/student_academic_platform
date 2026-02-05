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
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border(
            left: BorderSide(
              color: _getPriorityColor(),
              width: 5,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: onToggleComplete,
                    child: Container(
                      width: 24,
                      height: 24,
                      margin: const EdgeInsets.only(right: 12, top: 0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: assignment.isCompleted
                              ? ALUTheme.successGreen
                              : ALUTheme.textDark.withValues(alpha: 0.3),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(6),
                        color: assignment.isCompleted
                            ? ALUTheme.successGreen
                            : Colors.transparent,
                      ),
                      child: assignment.isCompleted
                          ? const Icon(
                              Icons.check,
                              color: ALUTheme.cardWhite,
                              size: 16,
                            )
                          : null,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          assignment.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: ALUTheme.textDark,
                            decoration: assignment.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            decorationThickness: 2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          assignment.course,
                          style: TextStyle(
                            fontSize: 13,
                            color: ALUTheme.textDark.withValues(alpha: 0.6),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getPriorityColor().withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          assignment.priority,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: _getPriorityColor(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              ALUTheme.accentYellow.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          assignment.category,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: ALUTheme.accentYellow,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: ALUTheme.textDark.withValues(alpha: 0.5),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        appState.getFormattedDate(assignment.dueDate),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ALUTheme.textDark.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text('Edit'),
                    style: TextButton.styleFrom(
                      foregroundColor: ALUTheme.accentYellow,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  TextButton.icon(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_outline, size: 16),
                    label: const Text('Delete'),
                    style: TextButton.styleFrom(
                      foregroundColor: ALUTheme.warningRed,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
