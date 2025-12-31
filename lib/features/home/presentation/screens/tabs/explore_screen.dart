import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data
    final designs = [
      {
        "title": "Neon NFT Marketplace",
        "description":
            "Dark mode marketplace with purple accents and glassmorphism cards.",
        "author": "@crypto_king",
        "likes": "2.4k",
        "color": Colors.purple,
      },
      {
        "title": "Minimalist Habit Tracker",
        "description":
            "Clean white interface with green progress rings and soft shadows.",
        "author": "@design_daily",
        "likes": "1.8k",
        "color": Colors.green,
      },
      {
        "title": "AI Analytics Dashboard",
        "description":
            "Complex data visualization with heatmap and line charts.",
        "author": "@data_wizard",
        "likes": "3.1k",
        "color": Colors.blue,
      },
      {
        "title": "Cyberpunk Social Feed",
        "description": "Glitch effect typography with high contrast borders.",
        "author": "@runner_2049",
        "likes": "950",
        "color": Colors.pink,
      },
      {
        "title": "Meditation App",
        "description": "Soft pastel gradients with rounded organic shapes.",
        "author": "@calm_flow",
        "likes": "4.2k",
        "color": Colors.orange,
      },
      {
        "title": "SaaS CRM Landing",
        "description": "Corporate blue tones with structured pricing tables.",
        "author": "@startup_joe",
        "likes": "1.2k",
        "color": Colors.indigo,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 800;
          final padding = isMobile ? 20.0 : 32.0;

          return SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Responsive Header
                if (isMobile)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Explore",
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Discover what the community is building.",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.white54,
                        ),
                      ),
                      const SizedBox(height: 24),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildFilterChip("Trending", true),
                            const SizedBox(width: 8),
                            _buildFilterChip("Newest", false),
                            const SizedBox(width: 8),
                            _buildFilterChip("Top Rated", false),
                          ],
                        ),
                      ),
                    ],
                  ).animate().fade().slideX()
                else
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Explore",
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Discover what the community is building.",
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: Colors.white54,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // Filter Buttons (Visual Only)
                      _buildFilterChip("Trending", true),
                      const SizedBox(width: 8),
                      _buildFilterChip("Newest", false),
                      const SizedBox(width: 8),
                      _buildFilterChip("Top Rated", false),
                    ],
                  ).animate().fade().slideX(begin: -0.1, end: 0),

                const SizedBox(height: 32),

                // List View (Rows)
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: designs.length,
                  separatorBuilder: (c, i) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final item = designs[index];
                    return _buildDesignRow(item, index);
                  },
                ),

                // Extra padding for mobile nav bar
                if (isMobile) const SizedBox(height: 80),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive ? Colors.transparent : Colors.white.withOpacity(0.1),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: isActive ? Colors.black : Colors.white70,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildDesignRow(Map<String, dynamic> item, int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF18181B), // Zinc-900
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Small Thumbnail (Left)
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: (item['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.image_outlined,
              color: (item['color'] as Color).withOpacity(0.6),
              size: 32,
            ),
          ),

          const SizedBox(width: 20),

          // Info (Right)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item['title'],
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(Icons.more_horiz, color: Colors.white24, size: 20),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item['description'],
                  style: GoogleFonts.inter(fontSize: 13, color: Colors.white54),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.white10,
                      child: Text(
                        (item['author'] as String)
                            .substring(1, 2)
                            .toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item['author'],
                      style: GoogleFonts.inter(
                        color: Colors.white38,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.favorite_border,
                      size: 14,
                      color: Colors.white38,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item['likes'],
                      style: GoogleFonts.inter(
                        color: Colors.white60,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate(delay: (index * 50).ms).fadeIn().slideX(begin: 0.1, end: 0);
  }
}
