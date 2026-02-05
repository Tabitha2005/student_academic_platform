import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../theme/alu_theme.dart';
import '../widgets/assignment_card.dart';
import 'create_assignment_screen.dart';

class AssignmentsScreen extends StatefulWidget {
  const AssignmentsScreen({super.key});

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ALUTheme.primaryDark,
      appBar: AppBar(
        title: const Text('Assignments'),
        elevation: 0,
        backgroundColor: ALUTheme.primaryDark,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateAssignmentScreen()),
          );
        },
        backgroundColor: ALUTheme.accentYellow,
        icon: const Icon(Icons.add, color: Colors.black),
        label: const Text(
          'Add Assignment',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<AppState>(
        builder: (context, appState, _) {
          return Column(
            children: [
              TabBar(
                controller: _tabController,
                labelColor: ALUTheme.accentYellow,
                unselectedLabelColor: ALUTheme.textWhite.withValues(alpha: 0.5),
                indicatorColor: ALUTheme.accentYellow,
                indicatorWeight: 4,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'Formative'),
                  Tab(text: 'Summative'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildAssignmentList(appState.getAllAssignments(), context),
                    _buildAssignmentList(
                      appState.getAssignmentsByCategory('Formative'),
                      context,
                    ),
                    _buildAssignmentList(
                      appState.getAssignmentsByCategory('Summative'),
                      context,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAssignmentList(List<dynamic> assignments, BuildContext context) {
    if (assignments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 72,
              color: ALUTheme.textWhite.withValues(alpha: 0.25),
            ),
            const SizedBox(height: 16),
            Text(
              'No assignments yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: ALUTheme.textWhite.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Tap the button below to add one',
              style: TextStyle(
                fontSize: 14,
                color: ALUTheme.textWhite.withValues(alpha: 0.4),
              ),
            ),
          ],
        ),
      );
    }

    final pendingAssignments = assignments
        .where((a) => !a.isCompleted)
        .toList();
    final completedAssignments = assignments
        .where((a) => a.isCompleted)
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (pendingAssignments.isNotEmpty) ...[
            Text(
              'Pending (${pendingAssignments.length})',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ALUTheme.textWhite,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            ...pendingAssignments.map((assignment) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AssignmentCard(
                  assignment: assignment,
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CreateAssignmentScreen(),
                      ),
                    );
                  },
                  onDelete: () {
                    Provider.of<AppState>(
                      context,
                      listen: false,
                    ).deleteAssignment(assignment.id);
                  },
                  onToggleComplete: () {
                    Provider.of<AppState>(
                      context,
                      listen: false,
                    ).toggleAssignmentCompletion(assignment.id);
                  },
                ),
              );
            }),
          ],
          if (completedAssignments.isNotEmpty) ...[
            if (pendingAssignments.isNotEmpty) const SizedBox(height: 28),
            Text(
              'Completed (${completedAssignments.length})',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ALUTheme.textWhite,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            ...completedAssignments.map((assignment) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AssignmentCard(
                  assignment: assignment,
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CreateAssignmentScreen(),
                      ),
                    );
                  },
                  onDelete: () {
                    Provider.of<AppState>(
                      context,
                      listen: false,
                    ).deleteAssignment(assignment.id);
                  },
                  onToggleComplete: () {
                    Provider.of<AppState>(
                      context,
                      listen: false,
                    ).toggleAssignmentCompletion(assignment.id);
                  },
                ),
              );
            }),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
