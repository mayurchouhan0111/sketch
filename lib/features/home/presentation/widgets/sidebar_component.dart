import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/dashboard_provider.dart';

class SidebarComponent extends ConsumerWidget {
  const SidebarComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(sidebarSelectionProvider);

    return Container(
      width: 280,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3), // Glassmorphic Transparent
        border: Border(
          right: BorderSide(
            color: const Color(0xFF27272a).withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header / Logo Area
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                const Icon(
                      Icons.auto_awesome_mosaic,
                      color: Colors.indigoAccent,
                      size: 28,
                    )
                    .animate(onPlay: (c) => c.repeat())
                    .shimmer(duration: 2.seconds, delay: 1.seconds),
                const SizedBox(width: 12),
                Text(
                  "Sketch",
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -1.0,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withOpacity(0.2), // Indigo accent
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "BETA",
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: Colors.indigo[300], // Indigo informational
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Navigation Items
          _buildNavItem(
            context,
            ref,
            CupertinoIcons.rectangle_grid_2x2_fill,
            "Dashboard",
            DashboardTab.dashboard,
            currentTab,
          ),
          _buildNavItem(
            context,
            ref,
            CupertinoIcons.compass,
            "Explore",
            DashboardTab.explore,
            currentTab,
          ),
          _buildNavItem(
            context,
            ref,
            CupertinoIcons.layers_alt,
            "Library",
            DashboardTab.library,
            currentTab,
          ),

          const Spacer(),

          // User Profile at bottom
          GestureDetector(
            onTap: () => ref.read(sidebarSelectionProvider.notifier).state =
                DashboardTab.settings,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: const Border(
                  top: BorderSide(color: Color(0xFF27272a)),
                ), // zinc-800
                color: currentTab == DashboardTab.settings
                    ? const Color(0xFF18181b)
                    : Colors.transparent, // zinc-900
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.indigo,
                    child: Text(
                      "AI",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Pro User",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.settings,
                    size: 18,
                    color: currentTab == DashboardTab.settings
                        ? Colors.white
                        : const Color(0xFF71717a), // zinc-400
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    WidgetRef ref,
    IconData icon,
    String label,
    DashboardTab tab,
    DashboardTab currentTab,
  ) {
    final isActive = tab == currentTab;

    // Animated Container for smooth background transition
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500), // Slower, premium feel
      curve: Curves.fastOutSlowIn, // Elegant curve
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        // Gradient Highlight for active tab
        gradient: isActive
            ? LinearGradient(
                colors: [
                  Colors.indigo.withOpacity(0.15),
                  Colors.indigo.withOpacity(0.01),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive ? Colors.indigo.withOpacity(0.2) : Colors.transparent,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Colors.indigoAccent.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            ref.read(sidebarSelectionProvider.notifier).state = tab;
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ), // Slightly taller for click area
            child: Row(
              children: [
                // Animated Icon with Color transition
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  child: Icon(
                    icon,
                    size: 20,
                    color: isActive
                        ? Colors.indigoAccent
                        : const Color(0xFF71717a),
                  ),
                ),
                const SizedBox(width: 12),

                // Text with standard clean font
                Expanded(
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 400),
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      color: isActive ? Colors.white : const Color(0xFFa1a1aa),
                    ),
                    child: Text(label),
                  ),
                ),

                // Active State Indicator (Glowing Dot or Arrow)
                if (isActive)
                  Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.indigoAccent,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.indigoAccent.withOpacity(0.8),
                              blurRadius: 8,
                            ), // Stronger glow
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .scale(duration: 400.ms, curve: Curves.easeOutBack),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
