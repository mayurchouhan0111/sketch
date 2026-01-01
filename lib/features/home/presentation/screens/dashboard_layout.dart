import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../widgets/generator_input_section.dart';
import '../widgets/sidebar_component.dart';
import 'tabs/explore_screen.dart';
import 'tabs/library_screen.dart';
import 'tabs/settings_screen.dart';
import '../providers/dashboard_provider.dart';

class DashboardLayout extends ConsumerWidget {
  const DashboardLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Basic Responsive Condition
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F), // Deep Object Black
      body: Stack(
        fit: StackFit.expand,
        children: [
          // GLOBAL ANIMATED BACKGROUND (Stars.json)
          Positioned.fill(
            child: RepaintBoundary(
              child: Lottie.asset(
                'assets/animations/Stars.json',
                fit: BoxFit.cover,
                frameRate: FrameRate.composition,
                renderCache: RenderCache.drawingCommands,
              ),
            ),
          ),

          // SEMI-TRANSPARENT OVERLAY
          Container(color: Colors.black.withOpacity(0.2)),

          // MAIN LAYOUT (Sidebar + Content)
          Row(
            children: [
              if (isDesktop) const SidebarComponent(),

              Expanded(
                child: SafeArea(
                  bottom:
                      false, // Allow content to go behind floating nav on bottom
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: isDesktop ? 0 : 100,
                    ), // clear nav bar on mobile
                    child: _buildBody(ref),
                  ),
                ),
              ),
            ],
          ),

          // FLOATING MOBILE NAVIGATION (The "Pill")
          if (!isDesktop)
            Positioned(
              bottom: 48, // Increased bottom padding per request
              left: 16,
              right: 16,
              child: _buildFloatingNavBar(ref),
            ),
        ],
      ),
    );
  }

  Widget _buildBody(WidgetRef ref) {
    final selectedTab = ref.watch(sidebarSelectionProvider);
    switch (selectedTab) {
      case DashboardTab.dashboard:
        return const GeneratorInputSection();
      case DashboardTab.explore:
        return const ExploreScreen();
      case DashboardTab.library:
        return const LibraryScreen();
      case DashboardTab.settings:
        return const SettingsScreen();
    }
  }

  Widget _buildFloatingNavBar(WidgetRef ref) {
    final selectedTab = ref.watch(sidebarSelectionProvider);
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF151515).withOpacity(0.9), // Dark glass
        borderRadius: BorderRadius.circular(100), // Pill shape
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildPillItem(
            ref,
            selectedTab,
            DashboardTab.dashboard,
            "Home",
            "https://api.iconify.design/solar:home-smile-bold.svg",
          ),
          _buildPillItem(
            ref,
            selectedTab,
            DashboardTab.explore,
            "Explore",
            "https://api.iconify.design/solar:compass-bold.svg",
          ),
          _buildPillItem(
            ref,
            selectedTab,
            DashboardTab.library,
            "Library",
            "https://api.iconify.design/solar:folder-with-files-bold.svg",
          ),
          _buildPillItem(
            ref,
            selectedTab,
            DashboardTab.settings,
            "Settings",
            "https://api.iconify.design/solar:settings-bold.svg",
          ),
        ],
      ),
    );
  }

  Widget _buildPillItem(
    WidgetRef ref,
    DashboardTab current,
    DashboardTab tab,
    String label,
    String iconUrl,
  ) {
    final isSelected = current == tab;
    return GestureDetector(
      onTap: () => ref.read(sidebarSelectionProvider.notifier).state = tab,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuint,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withOpacity(0.1)
              : Colors.transparent, // Active pill background
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Using SvgPicture.network
            SvgPicture.network(
              iconUrl,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.white : Colors.white38,
                BlendMode.srcIn,
              ),
              placeholderBuilder: (context) => Icon(
                Icons.circle,
                size: 20,
                color: Colors.white.withOpacity(0.1),
              ),
            ),

            // Expand Text if selected
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutQuint,
              child: isSelected
                  ? Row(
                      children: [
                        const SizedBox(width: 8),
                        Text(
                          label,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
