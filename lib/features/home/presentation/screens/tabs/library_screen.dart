import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 800;
          final padding = isMobile ? 20.0 : 32.0;
          final crossAxisCount = constraints.maxWidth < 600
              ? 1
              : (constraints.maxWidth < 1100 ? 2 : 3);

          return Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // RESPONSIVE HEADER
                if (isMobile)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Library",
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          // Mobile "New Folder" Icon Button
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.create_new_folder_outlined,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Manage your generated designs and code.",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.white54,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Search Bar full width
                      Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF18181B),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.search,
                              color: Colors.white38,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                style: GoogleFonts.inter(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Search designs...",
                                  hintStyle: GoogleFonts.inter(
                                    color: Colors.white24,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).animate().fadeIn().slideY()
                else
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Library",
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Manage your generated designs and code.",
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: Colors.white54,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // Search Bar
                      Container(
                        width: 300,
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF18181B),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.search,
                              color: Colors.white38,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                style: GoogleFonts.inter(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Search designs...",
                                  hintStyle: GoogleFonts.inter(
                                    color: Colors.white24,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.only(
                                    bottom: 6,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Create Folder Btn
                      Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.create_new_folder_outlined,
                                color: Colors.black,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "New Folder",
                                style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ).animate().fadeIn().slideY(begin: -0.2, end: 0),

                const SizedBox(height: 40),

                // FOLDERS / COLLECTIONS
                Text(
                  "Collections",
                  style: GoogleFonts.inter(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildFolderCard(
                        "Mobile Apps",
                        "12 items",
                        Colors.blueAccent,
                      ),
                      _buildFolderCard(
                        "Web Dashboards",
                        "8 items",
                        Colors.purpleAccent,
                      ),
                      _buildFolderCard(
                        "Landing Pages",
                        "5 items",
                        Colors.pinkAccent,
                      ),
                      _buildFolderCard(
                        "Components",
                        "24 items",
                        Colors.orangeAccent,
                      ),
                    ],
                  ),
                ).animate(delay: 200.ms).fadeIn().slideX(begin: 0.1, end: 0),

                const SizedBox(height: 40),

                // RECENT PROJECTS GRID
                Text(
                  "Recent Projects",
                  style: GoogleFonts.inter(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 1.4,
                    padding: EdgeInsets.only(
                      bottom: isMobile ? 80 : 0,
                    ), // Padding for pill nav
                    children: [
                      _buildProjectCard(
                        "Fitness Tracker App",
                        "Mobile • Flutter",
                        "2 mins ago",
                        Icons.fitness_center,
                      ),
                      _buildProjectCard(
                        "Crypto Exchange",
                        "Web • React",
                        "2 hours ago",
                        Icons.currency_bitcoin,
                      ),
                      _buildProjectCard(
                        "SaaS CRM",
                        "Web • Vue",
                        "1 day ago",
                        Icons.pie_chart,
                      ),
                      _buildProjectCard(
                        "Music Player",
                        "Mobile • Swift",
                        "3 days ago",
                        Icons.music_note,
                      ),
                      _buildProjectCard(
                        "Travel Guide",
                        "Mobile • Kotlin",
                        "5 days ago",
                        Icons.flight,
                      ),
                      _buildProjectCard(
                        "E-Commerce Shop",
                        "Web • Next.js",
                        "1 week ago",
                        Icons.shopping_bag,
                      ),
                    ],
                  ).animate(delay: 400.ms).fadeIn().scale(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFolderCard(String title, String count, Color color) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF18181B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.folder, color: color, size: 32),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                count,
                style: GoogleFonts.inter(color: Colors.white38, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(
    String title,
    String type,
    String time,
    IconData icon,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF18181B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Preview Placeholder
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.02),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
              ),
              child: Center(child: Icon(icon, size: 48, color: Colors.white10)),
            ),
          ),

          // Info Overlay
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.9), Colors.transparent],
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Colors.greenAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            type,
                            style: GoogleFonts.inter(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  _buildMiniAction(Icons.code),
                  const SizedBox(width: 8),
                  _buildMiniAction(Icons.more_vert),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniAction(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.white70, size: 16),
    );
  }
}
