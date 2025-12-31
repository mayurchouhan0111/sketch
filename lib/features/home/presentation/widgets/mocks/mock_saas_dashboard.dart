import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MockSaasDashboard extends StatelessWidget {
  const MockSaasDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090b), // zinc-950
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Nexus Dashboard", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.search, color: Colors.white54), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications_none, color: Colors.white), onPressed: () {}),
          const Padding(
             padding: EdgeInsets.only(right: 16),
             child: CircleAvatar(radius: 16, backgroundColor: Colors.indigoAccent, child: Text("A", style: TextStyle(color: Colors.white, fontSize: 12))),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 800;
          final padding = isMobile ? 16.0 : 32.0;
          
          return SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // DASHBOARD TITLE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text("Overview", 
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF18181b),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFF27272a)),
                      ),
                      child: Text("Download", style: GoogleFonts.inter(color: Colors.white, fontSize: 12)),
                    )
                  ],
                ).animate().fadeIn().slideX(begin: -0.1, end: 0),
                
                const SizedBox(height: 24),

                // STAT GRID
                if (isMobile)
                  Column(
                    children: [
                      _buildStatCard("Total Revenue", "\$45,231.89", "+20.1% from last month", Icons.attach_money),
                      const SizedBox(height: 12),
                      _buildStatCard("Subscriptions", "+2350", "+180.1% from last month", Icons.people_outline),
                      const SizedBox(height: 12),
                      _buildStatCard("Sales", "+12,234", "+19% from last month", Icons.credit_card),
                      const SizedBox(height: 12),
                      _buildStatCard("Active Now", "+573", "+201 since last hour", Icons.show_chart),
                    ],
                  ).animate().fadeIn().slideY(begin: 0.1, end: 0)
                else
                  GridView.count(
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.8,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                       _buildStatCard("Total Revenue", "\$45,231.89", "+20.1% from last month", Icons.attach_money),
                       _buildStatCard("Subscriptions", "+2350", "+180.1% from last month", Icons.people_outline),
                       _buildStatCard("Sales", "+12,234", "+19% from last month", Icons.credit_card),
                       _buildStatCard("Active Now", "+573", "+201 since last hour", Icons.show_chart),
                    ],
                  ).animate().fadeIn().scale(),

                const SizedBox(height: 24),

                // MAIN CONTENT (Chart + Recent)
                if (isMobile)
                  Column(
                    children: [
                      _buildChartSection(height: 300),
                      const SizedBox(height: 24),
                      _buildRecentSalesSection(),
                    ],
                  ).animate(delay: 400.ms).fadeIn()
                else 
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: _buildChartSection(height: 400),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 3,
                        child: _buildRecentSalesSection(),
                      ),
                    ],
                  ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.1, end: 0),
                  
                const SizedBox(height: 80), // Bottom padding
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String sub, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF18181b), // zinc-900
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF27272a)), // zinc-800
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(title, 
                  style: GoogleFonts.inter(color: const Color(0xFFa1a1aa), fontSize: 13, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(icon, color: const Color(0xFFa1a1aa), size: 16),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: GoogleFonts.inter(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(sub, style: GoogleFonts.inter(color: const Color(0xFFa1a1aa), fontSize: 12)), 
            ],
          )
        ],
      ),
    );
  }

  Widget _buildChartSection({required double height}) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF18181b),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF27272a)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Overview", style: GoogleFonts.inter(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(12, (index) {
                final heightFactor = (index % 4 + 2) / 6.0 + (index % 3) * 0.1;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                         heightFactor: heightFactor > 1.0 ? 1.0 : heightFactor,
                         child: Container(color: Colors.indigoAccent, width: 20),
                      ),
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRecentSalesSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF18181b),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF27272a)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Recent Sales", style: GoogleFonts.inter(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
          Text("You made 265 sales this month.", style: GoogleFonts.inter(color: const Color(0xFFa1a1aa), fontSize: 14)),
          const SizedBox(height: 24),
          _buildRecentSale("Olivia Martin", "olivia.martin@email.com", "+\$1,999.00"),
          _buildRecentSale("Jackson Lee", "jackson.lee@email.com", "+\$39.00"),
          _buildRecentSale("Isabella Nguyen", "isabella.nguyen@email.com", "+\$299.00"),
          _buildRecentSale("William Kim", "will@email.com", "+\$99.00"),
          _buildRecentSale("Sofia Davis", "sofia.davis@email.com", "+\$39.00"),
        ],
      ),
    );
  }

  Widget _buildRecentSale(String name, String email, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: const Color(0xFF27272a), child: Text(name[0], style: const TextStyle(color: Colors.white))),
          const SizedBox(width: 16),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(name, style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14)),
              Text(email, style: GoogleFonts.inter(color: const Color(0xFFa1a1aa), fontSize: 13)),
            ]),
          ),
          Text(amount, style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
        ],
      ),
    );
  }
}