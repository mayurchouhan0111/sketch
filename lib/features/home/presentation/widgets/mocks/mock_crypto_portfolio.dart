import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MockCryptoPortfolio extends StatelessWidget {
  const MockCryptoPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090b),
      appBar: AppBar(
        title: Text("Portfolio", style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        actions: [IconButton(icon: const Icon(Icons.pie_chart_outline, color: Colors.white), onPressed: () {})],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // Donut Chart Placeholder
              Container(
                height: 200, width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.indigoAccent, width: 20),
                ),
                child: Center(
                  child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text("Total", style: GoogleFonts.inter(color: Colors.grey, fontSize: 12)),
                       Text("\$12.4k", style: GoogleFonts.inter(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                     ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              
              // Allocation List
               Expanded(
                child: ListView(
                  children: [
                    _buildAllocationTile("Bitcoin", "45%", Colors.orange),
                    _buildAllocationTile("Ethereum", "30%", Colors.blue),
                    _buildAllocationTile("Solana", "15%", Colors.purple),
                    _buildAllocationTile("USDC", "10%", Colors.green),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAllocationTile(String name, String percent, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF18181b),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF27272a)),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: color, radius: 6),
          const SizedBox(width: 12),
          Text(name, style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold)),
          const Spacer(),
          Text(percent, style: GoogleFonts.inter(color: Colors.white70)),
        ],
      ),
    );
  }
}
