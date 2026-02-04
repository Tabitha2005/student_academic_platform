# Quick Testing Guide

## How to Test the ALU Academic Assistant App

### Step 1: Sign Up
1. Enter any email (e.g., `student@alu.edu`)
2. **SELECT AT LEAST ONE COURSE** by tapping the large course cards
   - You should see the checkbox fill with yellow and a checkmark appears
   - Course text is large and readable (18px)
3. Tap **"Get Started"** button (yellow)
4. If you didn't select courses, you'll see an error message

### Step 2: Test Dashboard Screen
1. After sign-up, you're on the Dashboard screen
2. You'll see:
   - ✓ Current date and week number
   - ✓ Pending assignments count (starts at 0)
   - ✓ Assignment completion percentage (0% initially)
   - ✓ Attendance percentage (0% initially)
   - ✓ "Upcoming assignments" section (empty initially)
   - ✓ "Today's Sessions" section (empty initially)

### Step 3: Add an Assignment
1. Tap **Assignments** tab (2nd tab) at the bottom
2. Tap the **"+" button** (floating action button)
3. Fill in:
   - **Title**: e.g., "Math Homework"
   - **Course**: e.g., "Computer Science"
   - **Due Date**: Tap to pick a date (within next 7 days)
   - **Priority**: Choose High/Medium/Low
4. Tap **"Save"** button
5. You'll see the assignment appear in the Assignments screen

### Step 4: VERIFY DATA FLOW (Most Important!)
1. Go back to **Dashboard** tab (1st tab)
2. **YOU SHOULD NOW SEE:**
   - ✓ "Pending (1)" count increased
   - ✓ Your assignment appears in "Upcoming assignments"
   - ✓ Assignment completion percentage changed
   - ✓ Pending assignments count updated

**✓ IF YOU SEE THE ASSIGNMENT ON THE DASHBOARD, DATA FLOW IS WORKING!**

### Step 5: Complete an Assignment
1. Go to **Assignments** tab
2. On the assignment card, tap the **checkbox icon** to mark complete
3. The assignment moves from "Pending" to "Completed" section
4. Go to **Dashboard** tab
5. You should see:
   - ✓ Pending count decreased by 1
   - ✓ Completion percentage increased
   - ✓ Assignment removed from upcoming list

### Step 6: Add a Session
1. Tap **Schedule** tab (3rd tab)
2. Tap the **"+" button** (floating action button)
3. Fill in:
   - **Title**: e.g., "Math Lecture"
   - **Date**: Today's date (or future)
   - **Start Time**: e.g., 10:00 AM
   - **End Time**: e.g., 11:30 AM
   - **Location**: e.g., "Room 101"
   - **Type**: Class/Lab/Tutorial/etc
4. Tap **"Save"** button
5. Session appears on the calendar

### Step 7: Mark Attendance
1. On **Schedule** tab, find the session you created
2. Tap the **checkmark icon** on the session card
3. Mark it as "Present" (green) or "Absent" (red)
4. Go to **Dashboard** tab
5. Attendance percentage should update from 0% to ~50% (depending on present/absent)

### Step 8: Check Risk Status
1. Tap **Risk Status** tab (4th tab)
2. You should see:
   - ✓ **Attendance %**: Shows your attendance percentage
   - ✓ **Assignments Pending**: Count of incomplete assignments
   - ✓ **Completion %**: Percentage of completed assignments
   - ✓ **Risk Level**: Color indicator (Green < 75%, Red ≥ 75%)
   - ✓ **Status Message**: Recommendations based on your metrics

### Step 9: Edit & Delete
1. Go to **Assignments** tab
2. On any assignment, tap the **pencil icon** to edit
3. Change details and tap **"Save"**
4. Tap the **trash icon** to delete
5. Assignment is removed immediately
6. Check **Dashboard** - counts update automatically

### Step 10: Test Error Messages
1. Try clicking "Get Started" without entering email
2. You should see: "Please enter your email"
3. Try clicking "Get Started" without selecting courses
4. You should see: "Please select at least one course"
5. In assignment form, try saving with empty title
6. You should see: "Please fill all fields"

---

## What Should Work ✓

### Sign-Up Screen
- [ ] Large (32x32) checkboxes that are easy to click
- [ ] Course names in big, readable text (18px)
- [ ] Course icons (💻, 📊, ⚙️, 📚, 🌍) for visual identification
- [ ] Yellow highlight when course is selected
- [ ] Check mark appears when selected
- [ ] "Get Started" button works
- [ ] Error messages are clear
- [ ] Email validation works

### Navigation
- [ ] 4 tabs at bottom work
- [ ] Can switch between tabs smoothly
- [ ] Data persists when switching tabs

### Data Flow
- [ ] Add assignment → appears on Dashboard ⭐ CRITICAL
- [ ] Complete assignment → Completion % updates
- [ ] Add session → Attendance % calculates correctly
- [ ] Mark attendance → Dashboard updates
- [ ] Delete item → All counts update

### Dashboard
- [ ] Shows current date and week
- [ ] Shows pending count
- [ ] Shows completion %
- [ ] Shows attendance %
- [ ] Shows upcoming assignments (within 7 days)
- [ ] Shows today's sessions
- [ ] Shows red warning if attendance < 75%

### Assignments
- [ ] Can add assignments
- [ ] Can edit assignments
- [ ] Can delete assignments
- [ ] Can mark complete/incomplete
- [ ] Pending and Completed sections

### Schedule
- [ ] Can add sessions with date/time
- [ ] Can mark attendance
- [ ] Can edit sessions
- [ ] Can delete sessions
- [ ] Week navigation works

### Risk Status
- [ ] Displays all metrics
- [ ] Color coding works
- [ ] Shows appropriate messages

---

## Troubleshooting

### Problem: Assignment doesn't appear on Dashboard
1. Make sure you added it with a due date within next 7 days
2. Try switching to a different tab and back
3. Tap "r" in terminal to hot reload

### Problem: Attendance % doesn't update
1. Make sure you marked the session as "Present"
2. Check that session date is today
3. Refresh the dashboard

### Problem: App crashes
1. Run `flutter clean`
2. Run `flutter pub get`
3. Run `flutter run -d edge` again

### Problem: Can't click checkboxes on sign-up
1. Try scrolling down to see full course card
2. Tap in the middle of the checkbox area
3. Try full screen mode in browser

---

## Performance Tips

- The app works best on modern browsers (Chrome, Edge, Firefox)
- No data is saved after app closes (in-memory only)
- Works offline once loaded
- Responsive design works on phone/tablet/desktop

---

## Success Indicators ✓

Your app is working perfectly when:

1. ✓ Sign-up screen has large, visible, clickable checkboxes
2. ✓ Course text is readable (not cramped)
3. ✓ Adding an assignment shows it on Dashboard immediately
4. ✓ Completion % updates when you mark assignments complete
5. ✓ Attendance % updates when you mark sessions attended
6. ✓ All 4 navigation tabs work
7. ✓ No error messages in console
8. ✓ Data flow works smoothly across all screens

---

## Contact/Support

All code is clean, well-documented, and follows Flutter best practices.
Refer to IMPROVEMENTS.md for detailed technical documentation.
