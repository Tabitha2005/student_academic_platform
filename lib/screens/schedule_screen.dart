import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../theme/alu_theme.dart';
import '../state/app_state.dart';
import '../models/academic_session.dart';
import '../widgets/session_card.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late DateTime _weekStart;

  @override
  void initState() {
    super.initState();
    _weekStart = DateTime.now().subtract(
      Duration(days: DateTime.now().weekday - 1),
    );
  }

  void _showSessionDialog(AppState appState, {AcademicSession? session}) {
    showDialog(
      context: context,
      builder: (context) => SessionFormDialog(
        session: session,
        onSave: (newSession) {
          if (session == null) {
            appState.addSession(newSession);
          } else {
            appState.updateSession(newSession);
          }
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ALUTheme.primaryDark,
      appBar: AppBar(title: Text('Schedule'), elevation: 0),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            _showSessionDialog(Provider.of<AppState>(context, listen: false)),
        child: Icon(Icons.add),
      ),
      body: Consumer<AppState>(
        builder: (context, appState, _) {
          final weekEnd = _weekStart.add(Duration(days: 6));
          final weekSessions = appState.sessions
              .where(
                (s) =>
                    s.date.isAfter(_weekStart.subtract(Duration(days: 1))) &&
                    s.date.isBefore(weekEnd.add(Duration(days: 1))),
              )
              .toList();

          weekSessions.sort((a, b) => a.date.compareTo(b.date));

          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                color: ALUTheme.primaryDark,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: ALUTheme.textWhite),
                      onPressed: () {
                        setState(() {
                          _weekStart = _weekStart.subtract(Duration(days: 7));
                        });
                      },
                    ),
                    Column(
                      children: [
                        Text(
                          '${_weekStart.month}/${_weekStart.day} - ${weekEnd.month}/${weekEnd.day}',
                          style: TextStyle(
                            color: ALUTheme.textWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${_weekStart.year}',
                          style: TextStyle(
                            color: ALUTheme.textWhite.withValues(alpha: 0.7),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _weekStart = DateTime.now().subtract(
                                Duration(days: DateTime.now().weekday - 1),
                              );
                            });
                          },
                          child: Text(
                            'Today',
                            style: TextStyle(color: ALUTheme.accentYellow),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward,
                            color: ALUTheme.textWhite,
                          ),
                          onPressed: () {
                            setState(() {
                              _weekStart = _weekStart.add(Duration(days: 7));
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: weekSessions.isEmpty
                    ? Center(
                        child: Text(
                          'No sessions this week',
                          style: TextStyle(color: ALUTheme.textWhite),
                        ),
                      )
                    : SingleChildScrollView(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...weekSessions.map((session) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${session.date.month}/${session.date.day}/${session.date.year}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: ALUTheme.textWhite,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  SessionCard(
                                    session: session,
                                    onEdit: () => _showSessionDialog(
                                      appState,
                                      session: session,
                                    ),
                                    onDelete: () =>
                                        appState.deleteSession(session.id),
                                    onToggleAttendance: (isPresent) {
                                      appState.markAttendance(
                                        session.id,
                                        isPresent,
                                      );
                                    },
                                  ),
                                  SizedBox(height: 16),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SessionFormDialog extends StatefulWidget {
  final AcademicSession? session;
  final Function(AcademicSession) onSave;

  const SessionFormDialog({super.key, this.session, required this.onSave});

  @override
  State<SessionFormDialog> createState() => _SessionFormDialogState();
}

class _SessionFormDialogState extends State<SessionFormDialog> {
  late TextEditingController _titleController;
  late TextEditingController _locationController;
  late DateTime _selectedDate;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  late String _selectedType;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.session?.title ?? '');
    _locationController = TextEditingController(
      text: widget.session?.location ?? '',
    );
    _selectedDate = widget.session?.date ?? DateTime.now();
    _startTime = widget.session?.startTime ?? TimeOfDay(hour: 9, minute: 0);
    _endTime = widget.session?.endTime ?? TimeOfDay(hour: 10, minute: 0);
    _selectedType = widget.session?.sessionType ?? 'Class';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_titleController.text.isEmpty || _locationController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return;
    }

    if (_endTime.hour < _startTime.hour ||
        (_endTime.hour == _startTime.hour &&
            _endTime.minute < _startTime.minute)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('End time must be after start time')),
      );
      return;
    }

    final session = AcademicSession(
      id: widget.session?.id ?? const Uuid().v4(),
      title: _titleController.text,
      date: _selectedDate,
      startTime: _startTime,
      endTime: _endTime,
      location: _locationController.text,
      sessionType: _selectedType,
      isPresent: widget.session?.isPresent ?? false,
    );

    widget.onSave(session);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ALUTheme.cardWhite,
      title: Text(
        widget.session == null ? 'Add Session' : 'Edit Session',
        style: TextStyle(color: ALUTheme.textDark),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Title',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ALUTheme.textDark,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Session title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Date',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ALUTheme.textDark,
              ),
            ),
            SizedBox(height: 8),
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (date != null) setState(() => _selectedDate = date);
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: ALUTheme.dividerGray),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_selectedDate.month}/${_selectedDate.day}/${_selectedDate.year}',
                      style: TextStyle(color: ALUTheme.textDark),
                    ),
                    Icon(Icons.calendar_today, color: ALUTheme.accentYellow),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Start Time',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ALUTheme.textDark,
              ),
            ),
            SizedBox(height: 8),
            InkWell(
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: _startTime,
                );
                if (time != null) setState(() => _startTime = time);
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: ALUTheme.dividerGray),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _startTime.format(context),
                      style: TextStyle(color: ALUTheme.textDark),
                    ),
                    Icon(Icons.access_time, color: ALUTheme.accentYellow),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'End Time',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ALUTheme.textDark,
              ),
            ),
            SizedBox(height: 8),
            InkWell(
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: _endTime,
                );
                if (time != null) setState(() => _endTime = time);
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: ALUTheme.dividerGray),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _endTime.format(context),
                      style: TextStyle(color: ALUTheme.textDark),
                    ),
                    Icon(Icons.access_time, color: ALUTheme.accentYellow),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Location',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ALUTheme.textDark,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                hintText: 'Location',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Type',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ALUTheme.textDark,
              ),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedType,
              onChanged: (value) =>
                  setState(() => _selectedType = value ?? 'Class'),
              items: [
                'Class',
                'Study Group',
                'PSL',
                'Mastery',
              ].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(color: ALUTheme.warningRed)),
        ),
        ElevatedButton(onPressed: _submit, child: Text('Save')),
      ],
    );
  }
}
