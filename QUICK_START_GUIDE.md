# Quick Start Guide - ALU Student Academic Platform

## Installation & Launch

### Prerequisites
- Flutter SDK (version 3.10.7 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile testing)
- Windows/Mac/Linux for desktop testing

### Step 1: Get Dependencies
```bash
cd student_academic_platform
flutter pub get
```

### Step 2: Run the Application

**For Windows:**
```bash
flutter run -d windows
```

**For Android:**
```bash
flutter run -d android
```

**For iOS:**
```bash
flutter run -d ios
```

**For Web:**
```bash
flutter run -d web
```

## First Time Usage

### 1. **Adding Your First Assignment**
   - Tap the "Assignments" tab at the bottom
   - Click the yellow "+" button
   - Enter assignment title (e.g., "Math Project")
   - Select due date
   - Enter course name (e.g., "Calculus 101")
   - Choose priority (High/Medium/Low)
   - Click "Add"

### 2. **Scheduling Your First Session**
   - Tap the "Schedule" tab at the bottom
   - Click the yellow "+" button
   - Enter session title (e.g., "Linear Algebra Class")
   - Select session date
   - Select start and end times
   - Enter location (optional)
   - Choose session type (Class/Mastery Session/Study Group/PSL Meeting)
   - Click "Add"

### 3. **Tracking Attendance**
   - Go to "Schedule" tab
   - Click on a session's attendance toggle (circle icon)
   - Watch your overall attendance percentage update on the Dashboard

### 4. **Viewing Your Dashboard**
   - Tap the "Dashboard" tab (default when opening app)
   - View today's date and academic week
   - Check your attendance percentage
   - See today's scheduled sessions
   - Review upcoming assignments (next 7 days)

## App Screens Overview

### **Dashboard Tab** 📊
- **Top Section**: Current date and week number
- **Attendance Card**: Shows percentage with circular progress indicator
- **Alert Banner**: Red warning if attendance < 75%
- **Today's Classes**: All sessions scheduled for today
- **Upcoming Assignments**: Next 7 days of assignments
- **Color Coding**: 
  - Red = High Priority / At Risk
  - Yellow = Medium Priority
  - Green = Low Priority / Completed

### **Assignments Tab** 📝
- **Floating "+" Button**: Add new assignment
- **Pending Section**: Assignments not yet completed
- **Completed Section**: Finished assignments
- **Actions Per Assignment**:
  - Edit (pencil icon)
  - Mark Done (checkmark button)
  - Delete (trash icon)

### **Schedule Tab** 📅
- **Week Navigation**: Previous/Next arrows to change weeks
- **Today Button**: Quick return to current week
- **Sessions Listed by Date**: Grouped and organized
- **Attendance Circles**: Click to toggle present/absent
- **Actions Per Session**:
  - Edit (pencil icon)
  - Delete (trash icon)

## Common Tasks

### ✏️ Edit an Assignment
1. Go to "Assignments" tab
2. Find the assignment you want to edit
3. Click the "Edit" button
4. Modify the details
5. Click "Update"

### ✏️ Edit a Session
1. Go to "Schedule" tab
2. Find the session you want to edit
3. Click the "Edit" button
4. Modify the details
5. Click "Update"

### ⭐ Mark Assignment as Done
1. Go to "Assignments" tab
2. Find the pending assignment
3. Click "Mark Done"
4. Assignment moves to "Completed" section

### ✅ Record Attendance
1. Go to "Schedule" tab
2. Find the session
3. Click the circle icon (empty circle = not attended, filled circle = attended)
4. Attendance percentage updates automatically

### 🗑️ Delete Assignment/Session
1. Find the item to delete
2. Click the red trash/delete icon
3. Confirm in the dialog
4. Item is removed

## Data Persistence

✅ **All data is automatically saved locally on your device:**
- Assignments are saved immediately when created/edited
- Sessions are saved immediately when created/edited
- Attendance records are saved immediately when toggled
- Data persists even after closing and reopening the app
- No internet connection required

## Tips & Tricks

1. **Priority Management**: Set High priority for urgent assignments to highlight them
2. **Attendance Monitoring**: Check your Dashboard daily to keep track of attendance
3. **Session Organization**: Use location field for easy reference
4. **Week Navigation**: Use arrow buttons on Schedule tab to plan ahead
5. **Completion Tracking**: Mark assignments as done to reduce clutter

## Troubleshooting

### "No classes scheduled for today"
- This is normal if you haven't added any sessions for today
- Go to Schedule tab and add sessions

### "No assignments due soon"
- You don't have pending assignments in the next 7 days
- Go to Assignments tab to add new assignments

### "No sessions scheduled"
- You haven't created any sessions yet
- Click the "+" button on Schedule tab to add one

### App crashes on startup
- Try: `flutter clean` then `flutter run`
- Make sure all dependencies are installed: `flutter pub get`

### Data not saving
- Check device storage has free space
- Try restarting the app
- Clear app cache and try again

## App Behavior Notes

- ⏰ **Times are in 24-hour format** (0:00 to 23:59)
- 📅 **Dates support full year calendar** (past dates can be added for record-keeping)
- 🔄 **Attendance percentage** = (Sessions attended / Total sessions) × 100
- ⚠️ **Alert threshold** = Attendance < 75%
- 💾 **Auto-save** = Enabled on every action

## Color Reference

| Color | Usage |
|-------|-------|
| Navy Blue (#1A2B4A) | Primary color, AppBar, backgrounds |
| Gold/Yellow (#FFC700) | Accent, buttons, highlights |
| Red (#FF4444) | Danger, alerts, high priority |
| Green (#4CAF50) | Success, low priority, completed |
| Gray | Secondary text, disabled items |

## Support & Help

For issues or questions:
1. Check the DOCUMENTATION.md file for detailed feature information
2. Review IMPLEMENTATION_SUMMARY.md for technical details
3. Check your device storage and permissions
4. Ensure Flutter SDK is up to date

---

**Happy Academic Managing! 🎓**

*Last Updated: February 2026*
