# Quick Reference Card

## Running the App

```bash
# Web (Edge)
flutter run -d edge

# Web (Chrome)
flutter run -d chrome

# Android
flutter run -d emulator-5554

# Clean build
flutter clean && flutter pub get && flutter run
```

## Key Files

| File | Purpose |
|------|---------|
| `lib/main.dart` | App entry point & navigation |
| `lib/state/app_state.dart` | State management (ChangeNotifier) |
| `lib/screens/signup_screen.dart` | Course registration (IMPROVED UI) |
| `lib/screens/dashboard_screen.dart` | Metrics overview |
| `lib/screens/assignments_screen.dart` | Assignment CRUD |
| `lib/screens/schedule_screen.dart` | Calendar & attendance |
| `lib/screens/risk_status_screen.dart` | Risk assessment |

## AppState Methods

### Assignments
```dart
appState.addAssignment(assignment)
appState.updateAssignment(assignment)
appState.deleteAssignment(id)
appState.toggleAssignmentCompletion(id)
appState.getUpcomingAssignments()      // Next 7 days
appState.getPendingAssignmentsCount()
appState.getAssignmentCompletionPercentage()
```

### Sessions
```dart
appState.addSession(session)
appState.updateSession(session)
appState.deleteSession(id)
appState.markAttendance(id, isPresent)
appState.getTodaySessions()
appState.calculateAttendancePercentage()
```

### Utilities
```dart
appState.getWeekNumber(date)
appState.getFormattedDate(date)
appState.getFormattedTime(time)
```

## Creating a Consumer Widget

```dart
Consumer<AppState>(
  builder: (context, appState, _) {
    return Column(
      children: [
        Text('Count: ${appState.getPendingAssignmentsCount()}'),
        // Data from appState automatically updates when state changes
      ],
    );
  }
)
```

## Modifying State (No Rebuild of Caller)

```dart
Provider.of<AppState>(context, listen: false).addAssignment(assignment);
// This won't rebuild the current widget, but will rebuild Consumer widgets
```

## Data Models

### Assignment
- `id` (UUID)
- `title`
- `course`
- `dueDate` (DateTime)
- `priority` ("High", "Medium", "Low")
- `isCompleted` (bool)

### AcademicSession
- `id` (UUID)
- `title`
- `date` (DateTime)
- `startTime` (TimeOfDay)
- `endTime` (TimeOfDay)
- `location`
- `sessionType` ("Class", "Lab", "Tutorial", etc.)
- `isPresent` (bool)

## Color Scheme

| Color | Code | Constant |
|-------|------|----------|
| Primary Navy | #1A2B4A | `ALUTheme.primaryDark` |
| Accent Gold | #FFC700 | `ALUTheme.accentYellow` |
| Warning Red | #FF4444 | `ALUTheme.warningRed` |
| Success Green | #4CAF50 | `ALUTheme.successGreen` |
| White | #FFFFFF | `ALUTheme.textWhite` |

## Navigation

**4 Tabs** (after sign-up):
1. 📊 Dashboard
2. 📝 Assignments
3. 📅 Schedule
4. ⚠️ Risk Status

## Keyboard Shortcuts (in Flutter)

```
r = Hot reload
R = Hot restart
h = Show all commands
d = Detach (leave app running)
q = Quit
```

## Common Tasks

### Add a New Screen
1. Create file in `lib/screens/my_screen.dart`
2. Use `Consumer<AppState>` to access data
3. Add to BottomNavigationBar in `main.dart`

### Add a New Calculation
1. Add method to `AppState`
2. Call `notifyListeners()` at end
3. Use in any Consumer widget

### Fix Compilation Error
```bash
flutter clean
flutter pub get
flutter run
```

## Testing Data Flow

**Quick Test**: Add assignment → Check Dashboard
- Assignment should appear immediately
- Proves Provider is working

**Debugging**: 
- Check console for errors
- Verify Consumer widget wraps your screen
- Confirm notifyListeners() is called

## Performance Tips

- Use `Provider.of(listen: false)` when not rebuilding
- Only wrap screens with Consumer, not entire subtrees
- Use filtered/sorted getters to avoid in-widget filtering
- Remember: Consumer rebuilds only when data changes

## File Locations

```
project/
├── lib/
│   ├── main.dart
│   ├── models/ (assignment.dart, academic_session.dart)
│   ├── state/ (app_state.dart)
│   ├── screens/ (5 screens)
│   ├── widgets/ (cards)
│   └── theme/ (alu_theme.dart)
├── pubspec.yaml
├── README.md
├── TESTING.md
├── ARCHITECTURE.md
└── IMPROVEMENTS.md
```

## Documentation Guide

| Document | For | Topics |
|----------|-----|--------|
| README.md | Everyone | Overview, setup, features |
| TESTING.md | QA/Users | How to test everything |
| ARCHITECTURE.md | Developers | How it's built |
| IMPROVEMENTS.md | Technical | What was changed |
| DELIVERY_SUMMARY.md | Stakeholders | What's delivered |

## Dependencies

```yaml
provider: ^6.1.0        # State management
intl: ^0.19.0           # Date/time formatting
uuid: ^4.0.0            # Unique IDs
```

## Success Indicators ✓

- ✓ Sign-up has large, visible checkboxes
- ✓ Course text is readable
- ✓ Adding assignment shows on Dashboard
- ✓ Attendance updates are instant
- ✓ All 4 tabs work
- ✓ No console errors
- ✓ 60 FPS performance

## Troubleshooting

| Issue | Solution |
|-------|----------|
| App won't launch | `flutter clean && flutter pub get` |
| Data doesn't update | Check Consumer wraps screen |
| Checkbox not clickable | Check z-index, use GestureDetector |
| Slow performance | Check notifyListeners() frequency |
| Can't see assignment | Verify due date < 7 days |

## Need Help?

1. Check [TESTING.md](TESTING.md) for step-by-step guide
2. Check [ARCHITECTURE.md](ARCHITECTURE.md) for technical details
3. Check [README.md](README.md) for overview
4. Review code comments in lib/

---

**Quick Start Command**:
```bash
cd student_academic_platform
flutter pub get
flutter run -d edge
```

**That's it!** The app will launch in Microsoft Edge.
