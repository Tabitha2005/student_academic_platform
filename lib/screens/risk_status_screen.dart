import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/alu_theme.dart';
import '../state/app_state.dart';

class RiskStatusScreen extends StatelessWidget {
  const RiskStatusScreen({super.key});

  Color _getRiskColor(double attendance, double assignments) {
    if (attendance < 75 || assignments < 50) {
      return ALUTheme.warningRed;
    } else if (attendance < 85 || assignments < 75) {
      return Color(0xFFFF9800);
    }
    return ALUTheme.successGreen;
  }

  String _getRiskStatus(double attendance, double assignments) {
    if (attendance < 75 || assignments < 50) {
      return 'AT RISK';
    } else if (attendance < 85 || assignments < 75) {
      return 'CAUTION';
    }
    return 'ON TRACK';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ALUTheme.primaryDark,
      appBar: AppBar(title: const Text('Risk Status'), elevation: 0),
      body: Consumer<AppState>(
        builder: (context, appState, _) {
          final attendance = appState.calculateAttendancePercentage();
          final assignments = appState.getAssignmentCompletionPercentage();
          final riskColor = _getRiskColor(attendance, assignments);
          final riskStatus = _getRiskStatus(attendance, assignments);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: riskColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        riskStatus,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: ALUTheme.cardWhite,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _getStatusMessage(riskStatus),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: ALUTheme.cardWhite.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Performance Metrics',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ALUTheme.textWhite,
                  ),
                ),
                const SizedBox(height: 16),
                _buildMetricCard(
                  'Attendance',
                  attendance,
                  attendance >= 75
                      ? ALUTheme.successGreen
                      : ALUTheme.warningRed,
                ),
                const SizedBox(height: 12),
                _buildMetricCard(
                  'Assignment Completion',
                  assignments,
                  assignments >= 75
                      ? ALUTheme.successGreen
                      : ALUTheme.warningRed,
                ),
                const SizedBox(height: 24),
                if (attendance < 75 || assignments < 50)
                  Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Support resources will be available here in the next update',
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.support_agent),
                        label: const Text('Get Help'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ALUTheme.accentYellow,
                          minimumSize: const Size(double.infinity, 48),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ALUTheme.cardWhite,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Risk Assessment',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ALUTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildRiskItem(
                        'Attendance < 75%',
                        attendance < 75,
                        'You need to attend more sessions to meet requirements',
                      ),
                      const SizedBox(height: 12),
                      _buildRiskItem(
                        'Low Assignment Completion',
                        assignments < 75,
                        'Complete more assignments to improve your standing',
                      ),
                      const SizedBox(height: 12),
                      _buildRiskItem(
                        'Combined Risk',
                        attendance < 75 || assignments < 50,
                        'Multiple areas need attention for academic success',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMetricCard(String label, double value, Color color) {
    final normalized = (value / 100).clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.all(16),
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
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: ALUTheme.textDark.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${value.toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  value: normalized,
                  strokeWidth: 4,
                  backgroundColor: ALUTheme.dividerGray.withValues(alpha: 0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              Text(
                '${value.toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String label, bool isAtRisk, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              isAtRisk ? Icons.warning : Icons.check_circle,
              color: isAtRisk ? ALUTheme.warningRed : ALUTheme.successGreen,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ALUTheme.textDark,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: ALUTheme.textDark.withValues(alpha: 0.6),
            ),
          ),
        ),
      ],
    );
  }

  String _getStatusMessage(String status) {
    switch (status) {
      case 'AT RISK':
        return 'You need immediate action to improve your academic standing';
      case 'CAUTION':
        return 'Monitor your progress and make improvements';
      case 'ON TRACK':
        return 'Keep up the great work!';
      default:
        return '';
    }
  }
}
