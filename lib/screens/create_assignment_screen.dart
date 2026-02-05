import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../state/app_state.dart';
import '../models/assignment.dart';
import '../theme/alu_theme.dart';

class CreateAssignmentScreen extends StatefulWidget {
  final Assignment? assignmentToEdit;

  const CreateAssignmentScreen({super.key, this.assignmentToEdit});

  @override
  State<CreateAssignmentScreen> createState() => _CreateAssignmentScreenState();
}

class _CreateAssignmentScreenState extends State<CreateAssignmentScreen> {
  late TextEditingController _titleController;
  late TextEditingController _courseController;
  final _formKey = GlobalKey<FormState>();
  late DateTime _selectedDate;
  late String _selectedPriority;
  late String _selectedCategory;

  bool get isEditing => widget.assignmentToEdit != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.assignmentToEdit?.title ?? '',
    );
    _courseController = TextEditingController(
      text: widget.assignmentToEdit?.course ?? '',
    );
    _selectedDate = widget.assignmentToEdit?.dueDate ??
        DateTime.now().add(const Duration(days: 7));
    _selectedPriority = widget.assignmentToEdit?.priority ?? 'Medium';
    _selectedCategory = widget.assignmentToEdit?.category ?? 'Formative';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _courseController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveAssignment() {
    if (_formKey.currentState!.validate()) {
      final appState = Provider.of<AppState>(context, listen: false);

      if (isEditing) {
        final updatedAssignment = widget.assignmentToEdit!.copyWith(
          title: _titleController.text,
          course: _courseController.text,
          dueDate: _selectedDate,
          priority: _selectedPriority,
          category: _selectedCategory,
        );
        appState.updateAssignment(updatedAssignment);
      } else {
        final newAssignment = Assignment(
          id: const Uuid().v4(),
          title: _titleController.text,
          course: _courseController.text,
          dueDate: _selectedDate,
          priority: _selectedPriority,
          category: _selectedCategory,
        );
        appState.addAssignment(newAssignment);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isEditing
                ? 'Assignment updated successfully'
                : 'Assignment created successfully',
          ),
          backgroundColor: ALUTheme.successGreen,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatted = _selectedDate.toString().split(' ')[0];

    return Scaffold(
      backgroundColor: ALUTheme.primaryDark,
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Assignment' : 'Create Assignment'),
        elevation: 0,
        backgroundColor: ALUTheme.primaryDark,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Title',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ALUTheme.textWhite,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Assignment title',
                  filled: true,
                  fillColor: ALUTheme.cardWhite,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(12),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Title is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Course',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ALUTheme.textWhite,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _courseController,
                decoration: InputDecoration(
                  hintText: 'Course name',
                  filled: true,
                  fillColor: ALUTheme.cardWhite,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(12),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Course is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Due Date',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ALUTheme.textWhite,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _selectDate,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: ALUTheme.cardWhite,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(dateFormatted, style: const TextStyle(fontSize: 14)),
                      const Icon(Icons.calendar_today, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Priority',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ALUTheme.textWhite,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: ALUTheme.cardWhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: _selectedPriority,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: ['High', 'Medium', 'Low']
                      .map(
                        (priority) => DropdownMenuItem(
                          value: priority,
                          child: Text(priority),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPriority = value ?? 'Medium';
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Category',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ALUTheme.textWhite,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: ALUTheme.cardWhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: ['Formative', 'Summative']
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value ?? 'Formative';
                    });
                  },
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _saveAssignment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ALUTheme.accentYellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    isEditing ? 'Update Assignment' : 'Create Assignment',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ALUTheme.primaryDark,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
