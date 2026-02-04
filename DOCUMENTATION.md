# ALU Student Academic Platform

A comprehensive mobile application that serves as a personal academic assistant for African Leadership University (ALU) students.

## Overview

This Flutter application helps students manage their academic responsibilities effectively by providing tools to:
- Track assignments with due dates and priorities
- Schedule academic sessions and classes
- Monitor attendance percentage in real-time
- View today's schedule at a glance
- Receive alerts when attendance falls below 75%

## Features

### 1. **Home Dashboard**
- **Current Date & Week**: Displays today's date and current academic week number
- **Attendance Tracking**: Visual progress indicator showing current attendance percentage
- **Risk Alert**: Red warning banner when attendance falls below 75%
- **Today's Classes**: Quick view of all scheduled sessions for today with attendance toggle
- **Pending Assignments**: List of assignments due within the next 7 days with priority indicators
- **Summary Cards**: Quick count of pending assignments

### 2. **Assignment Management System**
Create and manage assignments with the following features:
- **Add Assignments**: Create new assignments with:
  - Title (required)
  - Course name (required)
  - Due date (required, with date picker)
  - Priority level (High/Medium/Low, optional)
  
- **View Assignments**: 
  - Sorted by due date
  - Color-coded priority indicators
  - Separate sections for pending and completed assignments
  
- **Manage Assignments**:
  - Mark assignments as completed
  - Edit assignment details
  - Delete assignments when no longer needed

### 3. **Academic Session Scheduling**
Schedule and manage all academic sessions:
- **Add Sessions**: Create new sessions with:
  - Session title (required)
  - Date (required, with date picker)
  - Start time (required, with time picker)
  - End time (required, with time picker)
  - Location (optional)
  - Session type (Class, Mastery Session, Study Group, PSL Meeting)

- **View Schedule**:
  - Weekly calendar view with navigation
  - Sessions grouped by date
  - Quick access to current week or today
  
- **Manage Sessions**:
  - Toggle attendance for each session
  - Edit session details
  - Delete sessions when cancelled
  - Color-coded session types

### 4. **Attendance Tracking**
Automatic attendance management:
- **Track Attendance**: Click on session to mark as attended/absent
- **Calculate Percentage**: Automatically computes overall attendance percentage
- **Alert System**: Visual warning when attendance drops below 75%
- **Maintain History**: All attendance records are preserved

## Technical Stack

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: StatefulWidget
- **Data Persistence**: SharedPreferences
- **Date/Time**: intl package for formatting
- **IDs**: uuid package for unique identifiers

## Project Structure

```
lib/
├── main.dart                          # App entry point and main navigation
├── models/
│   └── data_models.dart              # Assignment, AcademicSession, and AttendanceRecord models
├── services/
│   └── data_service.dart             # Data persistence and business logic
├── screens/
│   ├── dashboard_screen.dart         # Dashboard view
│   ├── assignments_screen.dart       # Assignment management view
│   └── schedule_screen.dart          # Schedule management view
```

## Color Palette

- **Primary**: Navy Blue (#1A2B4A)
- **Accent**: Gold/Yellow (#FFC700)
- **Danger/Alert**: Red (#FF4444)
- **Success**: Green (#4CAF50)
- **Text**: Black/Dark Gray
- **Background**: White

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  shared_preferences: ^2.2.0
  intl: ^0.19.0
  uuid: ^4.0.0
```

## Installation & Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd student_academic_platform
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

   Or for specific platform:
   ```bash
   flutter run -d windows    # Windows
   flutter run -d ios        # iOS
   flutter run -d android    # Android
   ```

## Data Storage

The application uses **SharedPreferences** for local data persistence, which means:
- All data is stored locally on the device
- Data persists between app sessions
- No internet connection required
- Data is stored in key-value format

### Stored Data:
- List of assignments with all details
- List of academic sessions with all details
- Attendance records for each session

## Usage Guide

### Adding an Assignment
1. Navigate to the Assignments tab
2. Click the yellow floating action button (+)
3. Fill in the required fields (Title, Course, Due Date)
4. Optionally select a priority level
5. Click "Add"

### Managing Sessions
1. Navigate to the Schedule tab
2. Use arrow buttons to navigate between weeks
3. Click the yellow floating action button (+) to add new session
4. Fill in all required fields
5. Click the attendance toggle (circle icon) to mark attendance

### Viewing Dashboard
1. Navigate to the Dashboard tab
2. See all key metrics at a glance
3. Check today's classes and upcoming assignments
4. Monitor your attendance percentage

## Key Features Explained

### Priority Levels
- **High**: Red indicator - urgent assignments
- **Medium**: Yellow indicator - normal due date
- **Low**: Green indicator - less urgent

### Session Types
- **Class**: Regular class sessions
- **Mastery Session**: Focused mastery sessions
- **Study Group**: Collaborative study sessions
- **PSL Meeting**: Project Skills Learning meetings

### Attendance Alert
- Automatically shows red alert when attendance < 75%
- Uses visual circular progress indicator
- Color changes based on risk level

## Version

Version 1.0.0

## License

This project is developed for African Leadership University (ALU) students.

## Support

For issues or feature requests, please contact the development team.

---

**Last Updated**: February 2026
**Application Status**: Production Ready
