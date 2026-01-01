import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 800;
          final padding = isMobile ? 20.0 : 40.0;

          return SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  "Settings",
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ).animate().fade().slideX(begin: -0.1, end: 0),

                const SizedBox(height: 32),

                // USER PROFILE CARD
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF6366F1).withOpacity(0.2),
                        const Color(0xFF8B5CF6).withOpacity(0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 32,
                        backgroundImage: NetworkImage(
                          "https://i.pravatar.cc/150?u=a042581f4e29026704d",
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Alex Designer",
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "alex@designcode.io",
                              style: GoogleFonts.inter(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.indigoAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "PRO",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate(delay: 100.ms).fade().slideY(begin: 0.1, end: 0),

                const SizedBox(height: 32),

                // GENERAL SETTINGS
                Text(
                  "General",
                  style: GoogleFonts.inter(
                    color: Colors.white54,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSettingsTile(
                  icon: Icons.dark_mode_outlined,
                  title: "Dark Mode",
                  subtitle: "System default",
                  trailing: Switch(
                    value: true,
                    onChanged: (v) {},
                    activeThumbColor: Colors.indigoAccent,
                  ),
                ),
                const SizedBox(height: 12),
                _buildSettingsTile(
                  icon: Icons.notifications_none_rounded,
                  title: "Notifications",
                  subtitle: "On",
                  trailing: Switch(
                    value: true,
                    onChanged: (v) {},
                    activeThumbColor: Colors.indigoAccent,
                  ),
                ),

                const SizedBox(height: 32),

                // ABOUT
                Text(
                  "About",
                  style: GoogleFonts.inter(
                    color: Colors.white54,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSettingsTile(
                  icon: Icons.info_outline,
                  title: "Version",
                  subtitle: "1.0.0 (Beta)",
                  trailing: const SizedBox(),
                ),

                if (isMobile) const SizedBox(height: 100), // Nav bar padding
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF18181B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white70, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(color: Colors.white38, fontSize: 13),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
