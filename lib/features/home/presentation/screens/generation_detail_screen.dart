import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

// MOCK WIDGET IMPORTS
import '../widgets/mocks/mock_crypto_dashboard.dart';
import '../widgets/mocks/mock_crypto_portfolio.dart';
import '../widgets/mocks/mock_crypto_swap.dart';
import '../widgets/mocks/mock_crypto_market.dart';
import '../widgets/mocks/mock_social_feed.dart';
import '../widgets/mocks/mock_saas_dashboard.dart';

import '../providers/dashboard_provider.dart';

enum CanvasTool { select, pan, zoom, media }

class GenerationDetailScreen extends ConsumerStatefulWidget {
  const GenerationDetailScreen({super.key});

  @override
  ConsumerState<GenerationDetailScreen> createState() =>
      _GenerationDetailScreenState();
}

class _GenerationDetailScreenState
    extends ConsumerState<GenerationDetailScreen> {
  final TransformationController _transformationController =
      TransformationController();
  CanvasTool _activeTool = CanvasTool.pan;

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  Widget _getMockWidget(String? widgetId) {
    switch (widgetId) {
      case 'mock_crypto_dashboard':
        return const MockCryptoDashboard();
      case 'mock_crypto_portfolio':
        return const MockCryptoPortfolio();
      case 'mock_crypto_swap':
        return const MockCryptoSwap();
      case 'mock_crypto_market':
        return const MockCryptoMarket();
      case 'mock_social_feed':
        return const MockSocialFeed();
      case 'mock_saas_dashboard':
        return const MockSaasDashboard();
      default:
        return Center(
          child: Text(
            "Widget ID not found: $widgetId",
            style: GoogleFonts.inter(
              color: const Color(0xFF71717A),
            ), // zinc-400
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isGenerating = ref.watch(isGeneratingProvider);
    final data = ref.watch(currentGenerationContentProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF09090B), // zinc-950
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 900;

          Widget buildContextPanel() {
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  right: isMobile
                      ? BorderSide.none
                      : const BorderSide(color: Color(0xFF27272A)), // zinc-800
                  bottom: isMobile
                      ? const BorderSide(color: Color(0xFF27272A))
                      : BorderSide.none,
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.1,
                      child: Lottie.asset(
                        'assets/animations/background.json',
                        fit: BoxFit.cover,
                        frameRate: FrameRate.max,
                      ),
                    ),
                  ),

                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        color: Colors.black.withOpacity(0.4),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.menu,
                                color: Color(0xFFA1A1AA),
                              ), // zinc-400
                              onPressed: () => Navigator.pop(context),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                data?['title'] ?? "New Project",
                                style: GoogleFonts.manrope(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(
                              Icons.share_outlined,
                              color: Colors.indigo,
                              size: 20,
                            ),
                            const SizedBox(width: 16),
                            const CircleAvatar(
                              radius: 12,
                              backgroundImage: NetworkImage(
                                "https://i.pravatar.cc/150?u=a042581f4e29026704d",
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(20),
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  radius: 14,
                                  backgroundColor: Colors.indigo,
                                  child: Icon(
                                    Icons.auto_awesome,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Sketch",
                                        style: GoogleFonts.manrope(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "I've generated the screens based on your request. The design features a modern noir theme with indigo accents.",
                                        style: GoogleFonts.manrope(
                                          color: const Color(0xFFD4D4D8),
                                          fontSize: 14,
                                          height: 1.5,
                                        ), // zinc-300
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 32),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  constraints: const BoxConstraints(
                                    maxWidth: 280,
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF18181B), // zinc-900
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: const Color(0xFF27272A),
                                    ), // zinc-800
                                  ),
                                  child: Text(
                                    "Refine the Dashboard layout and charts",
                                    style: GoogleFonts.manrope(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            if (isGenerating) ...[
                              const SizedBox(height: 32),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.indigo,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    "Generating variations...",
                                    style: GoogleFonts.manrope(
                                      color: const Color(0xFF71717A),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF18181B), // zinc-900
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFF27272A),
                          ), // zinc-800
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              style: GoogleFonts.manrope(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: "Describe your design update...",
                                hintStyle: GoogleFonts.manrope(
                                  color: const Color(0xFF52525B),
                                ), // zinc-500
                                border: InputBorder.none,
                              ),
                              maxLines: 3,
                              minLines: 1,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: Color(0xFFA1A1AA),
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF27272A),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.flash_on,
                                        size: 12,
                                        color: Colors.amber,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        "3x",
                                        style: GoogleFonts.manrope(
                                          color: Colors.white,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Colors.indigo,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

          Widget buildCanvasPanel() {
            return Stack(
              children: [
                InteractiveViewer(
                  transformationController: _transformationController,
                  boundaryMargin: const EdgeInsets.all(2000),
                  minScale: 0.1,
                  maxScale: 5.0,
                  panEnabled: _activeTool == CanvasTool.pan,
                  child: SizedBox(
                    width: 6000,
                    height: 6000,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            (data?['screens'] as List?)?.map<Widget>((screen) {
                              final String? widgetId = screen['widget_id'];

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                ),
                                child:
                                    Container(
                                          width: 375,
                                          height: 812,
                                          decoration: BoxDecoration(
                                            color: const Color(
                                              0xFF18181B,
                                            ), // zinc-900
                                            borderRadius: BorderRadius.circular(
                                              32,
                                            ),
                                            border: Border.all(
                                              color: const Color(0xFF27272A),
                                              width: 4,
                                            ), // zinc-800
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                  0.5,
                                                ),
                                                blurRadius: 50,
                                                offset: const Offset(0, 20),
                                              ),
                                            ],
                                          ),
                                          clipBehavior: Clip.antiAlias,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                height: 44,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 24,
                                                    ),
                                                color: Colors.black,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "9:41",
                                                      style:
                                                          GoogleFonts.manrope(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14,
                                                          ),
                                                    ),
                                                    const Icon(
                                                      Icons.battery_full,
                                                      size: 16,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  color: const Color(
                                                    0xFF09090B,
                                                  ), // zinc-950
                                                  child: widgetId != null
                                                      ? _getMockWidget(widgetId)
                                                      : const Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                                color: Colors
                                                                    .indigo,
                                                              ),
                                                        ),
                                                ),
                                              ),
                                              Container(
                                                height: 24,
                                                color: Colors.black,
                                                child: Center(
                                                  child: Container(
                                                    width: 120,
                                                    height: 4,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                        0xFF3F3F46,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            2,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                        .animate()
                                        .scale(
                                          duration: 400.ms,
                                          curve: Curves.easeOutBack,
                                        )
                                        .fadeIn(),
                              );
                            }).toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 32,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF18181B), // zinc-900
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF27272A),
                        ), // zinc-800
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildCanvasControl(Icons.near_me, CanvasTool.select),
                          const SizedBox(width: 8),
                          _buildCanvasControl(
                            Icons.pan_tool_outlined,
                            CanvasTool.pan,
                          ),
                          Container(
                            width: 1,
                            height: 24,
                            color: const Color(0xFF27272A),
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          _buildCanvasControl(Icons.search, CanvasTool.zoom),
                          const SizedBox(width: 8),
                          _buildCanvasControl(
                            Icons.image_outlined,
                            CanvasTool.media,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          if (isMobile) {
            return Stack(
              children: [
                Positioned.fill(child: buildCanvasPanel()),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 16,
                  right: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF18181B).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF27272A)),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.dashboard_customize_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 16,
                  left: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF18181B).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF27272A)),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child:
                      Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 20,
                          bottom: 50,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF09090B).withOpacity(0.95),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(32),
                          ),
                          border: const Border(
                            top: BorderSide(color: Color(0xFF27272A)),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.8),
                              blurRadius: 30,
                              offset: const Offset(0, -10),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: const Color(0xFF3F3F46),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.indigo,
                                  child: Icon(
                                    Icons.auto_awesome,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Sketch",
                                  style: GoogleFonts.manrope(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "V 2.0",
                                  style: GoogleFonts.manrope(
                                    color: const Color(0xFF52525B),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF18181B),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(0xFF27272A),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      style: GoogleFonts.manrope(
                                        color: Colors.white,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Describe layout updates...",
                                        hintStyle: GoogleFonts.manrope(
                                          color: const Color(0xFF52525B),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.arrow_upward_rounded,
                                      color: Colors.indigo,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ).animate().slideY(
                        begin: 1,
                        end: 0,
                        duration: 400.ms,
                        curve: Curves.easeOutExpo,
                      ),
                ),
              ],
            );
          } else {
            return Row(
              children: [
                Expanded(flex: 3, child: buildContextPanel()),
                Expanded(flex: 7, child: buildCanvasPanel()),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildCanvasControl(IconData icon, CanvasTool tool) {
    bool isActive = _activeTool == tool;
    return GestureDetector(
      onTap: () => setState(() => _activeTool = tool),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isActive ? Colors.indigo : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: isActive ? Colors.white : const Color(0xFFA1A1AA),
          size: 20,
        ),
      ),
    );
  }
}
