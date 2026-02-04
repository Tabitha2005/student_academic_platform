import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../theme/alu_theme.dart';
import '../widgets/announcement_card.dart';
import 'create_announcement_screen.dart';

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ALUTheme.primaryDark,
      appBar: AppBar(
        title: const Text('Announcements'),
        elevation: 0,
        backgroundColor: ALUTheme.primaryDark,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateAnnouncementScreen()),
          );
        },
        backgroundColor: ALUTheme.accentYellow,
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: Consumer<AppState>(
        builder: (context, appState, _) {
          final announcements = appState.announcements;

          if (announcements.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off,
                    size: 64,
                    color: ALUTheme.textWhite.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No announcements yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: ALUTheme.textWhite.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: announcements
                  .map(
                    (announcement) => AnnouncementCard(
                      announcement: announcement,
                      onDelete: () {
                        Provider.of<AppState>(
                          context,
                          listen: false,
                        ).deleteAnnouncement(announcement.id);
                      },
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
