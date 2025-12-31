import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MockSocialFeed extends StatelessWidget {
  const MockSocialFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090b),
      appBar: AppBar(
        backgroundColor: const Color(0xFF09090b),
        title: Text("Feed", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) => const Divider(color: Color(0xFF27272a), height: 1),
        itemBuilder: (context, index) => _buildPost(),
      ),
    );
  }

  Widget _buildPost() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(backgroundColor: Color(0xFF27272a), radius: 18),
              const SizedBox(width: 12),
              Text("shadcn", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold)),
              const Spacer(),
              const Icon(Icons.more_horiz, color: Color(0xFFa1a1aa)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: const Color(0xFF18181b),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(child: Icon(Icons.image, color: Color(0xFF27272a), size: 64)),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.favorite_border, color: Colors.white),
              const SizedBox(width: 16),
              const Icon(Icons.chat_bubble_outline, color: Colors.white),
              const SizedBox(width: 16),
              const Icon(Icons.send_outlined, color: Colors.white),
              const Spacer(),
              const Icon(Icons.bookmark_border, color: Colors.white),
            ],
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: GoogleFonts.inter(color: Colors.white),
              children: [
                const TextSpan(text: "shadcn ", style: TextStyle(fontWeight: FontWeight.bold)),
                const TextSpan(text: "Beautifully designed components that you can copy and paste into your apps."),
              ],
            ),
          ),
        ],
      ),
    );
  }
}