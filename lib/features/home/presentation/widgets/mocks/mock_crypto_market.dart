import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MockCryptoMarket extends StatelessWidget {
  const MockCryptoMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090b),
      appBar: AppBar(
        title: Text(
          "Markets",
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMarketCard("Bitcoin", "BTC", "\$68,230", "+1.2%"),
          _buildMarketCard("Ethereum", "ETH", "\$3,890", "+2.4%"),
          _buildMarketCard("Solana", "SOL", "\$145", "-0.8%"),
          _buildMarketCard("Cardano", "ADA", "\$0.45", "+0.1%"),
          _buildMarketCard("Ripple", "XRP", "\$0.62", "-1.5%"),
        ],
      ),
    );
  }

  Widget _buildMarketCard(
    String name,
    String symbol,
    String price,
    String change,
  ) {
    bool isUp = change.startsWith('+');
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF18181b),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  symbol,
                  style: GoogleFonts.inter(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
          // Mini Chart Placeholder
          Container(
            width: 60,
            height: 30,
            color: isUp
                ? Colors.green.withOpacity(0.1)
                : Colors.red.withOpacity(0.1),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isUp ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  change,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
