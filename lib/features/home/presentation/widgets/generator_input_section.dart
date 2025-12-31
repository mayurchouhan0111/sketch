import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../providers/dashboard_provider.dart';

class GeneratorInputSection extends ConsumerStatefulWidget {
  const GeneratorInputSection({super.key});

  @override
  ConsumerState<GeneratorInputSection> createState() =>
      _GeneratorInputSectionState();
}

class _GeneratorInputSectionState extends ConsumerState<GeneratorInputSection>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  bool _isListening = false;
  late final AnimationController _aiController;

  @override
  void initState() {
    super.initState();
    _aiController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    _aiController.dispose();
    super.dispose();
  }

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedPlatform = ref.watch(selectedPlatformProvider);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 720,
          ), // Tighter constraint for focus
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ULTRA MINIMAL HEADER
              Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        child: Text(
                          "Sketch AI 1.0",
                          style: GoogleFonts.manrope(
                            fontSize: 12,
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "Design anything.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.0,
                          letterSpacing: -2.0,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Describe your interface and let the AI build it pixel-perfect.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          color: Colors.white38,
                          height: 1.5,
                        ),
                      ),
                    ],
                  )
                  .animate()
                  .fade(duration: 800.ms)
                  .moveY(begin: 30, end: 0, curve: Curves.easeOutQuart),

              const SizedBox(height: 48),

              // GLASSMORPHIC INPUT FIELD
              ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: AnimatedContainer(
                        duration: 400.ms,
                        curve: Curves.easeOutExpo,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          // Match Lottie background color when listening to avoid "2 color" issue
                          color: _isListening
                              ? const Color(0xFF282828)
                              : Colors.black.withOpacity(0.6),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.zero,
                        child: Stack(
                          children: [
                            if (_isListening)
                              Positioned.fill(
                                child: Lottie.asset(
                                  'assets/animations/ai.json',
                                  key: ValueKey(_isListening),
                                  controller: _aiController,
                                  onLoaded: (composition) {
                                    _aiController
                                      ..duration = composition.duration
                                      ..reset()
                                      ..forward().then((_) {
                                        if (mounted && _isListening) {
                                          setState(() {
                                            _isListening = false;
                                          });
                                        }
                                      });
                                  },
                                  errorBuilder: (context, error, stackTrace) =>
                                      const SizedBox.shrink(),
                                  fit: BoxFit
                                      .contain, // Ensure full animation is visible and centered
                                  alignment: Alignment.center,
                                ),
                              ),

                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Platform Selector Minimalized (Always Visible)
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        // Hide Toggle when listening
                                        AnimatedSize(
                                          duration: 300.ms,
                                          curve: Curves.easeOutExpo,
                                          child: _isListening
                                              ? const SizedBox.shrink()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        right: 12,
                                                      ),
                                                  child: _buildPlatformToggle(
                                                    ref,
                                                    selectedPlatform,
                                                  ),
                                                ),
                                        ),

                                        const SizedBox(
                                          width: 12,
                                        ), // Replaced Spacer with fixed spacing
                                        // Hide Link/Image when listening
                                        if (!_isListening) ...[
                                          _buildMinimalActionButton(
                                            Icons.link,
                                            "Link",
                                          ).animate().fadeIn(),
                                          const SizedBox(width: 8),
                                          _buildMinimalActionButton(
                                            Icons.image_outlined,
                                            "Image",
                                          ).animate().fadeIn(),
                                          const SizedBox(width: 8),
                                        ],

                                        // Voice Button (Always Visible, animates state)
                                        GestureDetector(
                                          onTap: _toggleListening,
                                          child: Container(
                                            width: 32,
                                            height: 32,
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(
                                                0.05,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: _isListening
                                                ? Lottie.asset(
                                                    'assets/animations/voice_ui.json',
                                                    fit: BoxFit.contain,
                                                    errorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) {
                                                          return const Icon(
                                                            Icons.mic,
                                                            color: Colors
                                                                .redAccent,
                                                            size: 20,
                                                          ); // Fallback to red mic
                                                        },
                                                  )
                                                : const Icon(
                                                    Icons.mic_none_rounded,
                                                    color: Colors.white54,
                                                    size: 16,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  // Interactive Content Switcher (Fixed Height Stack)
                                  Stack(
                                    children: [
                                      // INPUT MODE (Text Field + Buttons)
                                      AnimatedOpacity(
                                        duration: 300.ms,
                                        opacity: _isListening ? 0.0 : 1.0,
                                        child: IgnorePointer(
                                          ignoring: _isListening,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 80,
                                                child: TextField(
                                                  controller: _controller,
                                                  style: GoogleFonts.manrope(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    height: 1.5,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  maxLines: null,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "E.g 'A futuristic dashboard for a crypto trading app...'",
                                                    hintStyle:
                                                        GoogleFonts.manrope(
                                                          fontSize: 18,
                                                          color: Colors.white24,
                                                        ),
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                  ),
                                                  onChanged: (val) =>
                                                      ref
                                                              .read(
                                                                promptInputProvider
                                                                    .notifier,
                                                              )
                                                              .state =
                                                          val,
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      final prompt =
                                                          _controller.text;
                                                      ref
                                                              .read(
                                                                promptInputProvider
                                                                    .notifier,
                                                              )
                                                              .state =
                                                          prompt;
                                                      GoRouter.of(
                                                        context,
                                                      ).push('/detail');
                                                      await startGeneration(
                                                        ref,
                                                        prompt,
                                                      );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 12,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                  0.2,
                                                                ),
                                                            blurRadius: 12,
                                                            offset:
                                                                const Offset(
                                                                  0,
                                                                  4,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            "Generate UI",
                                                            style:
                                                                GoogleFonts.manrope(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14,
                                                                ),
                                                          ),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          const Icon(
                                                            Icons
                                                                .arrow_forward_rounded,
                                                            color: Colors.black,
                                                            size: 16,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // VOICE MODE (Visualizer Placeholder)
                                      // The visualizer is the background Lottie.
                                      // We keep this empty to allow the background to show through clearly.
                                      if (_isListening)
                                        const Positioned.fill(
                                          child: SizedBox.shrink(),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .animate(delay: 200.ms)
                  .fadeIn(duration: 600.ms)
                  .scale(
                    begin: const Offset(0.95, 0.95),
                    end: const Offset(1, 1),
                    curve: Curves.easeOutExpo,
                  ),

              const SizedBox(height: 48),

              // Minimal Suggestions
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  _buildMinimalChip("💰 Crypto Wallet"),
                  _buildMinimalChip("🛍️ E-Commerce"),
                  _buildMinimalChip("📊 Saas Dashboard"),
                  _buildMinimalChip("🎵 Music Player"),
                ],
              ).animate(delay: 400.ms).fadeIn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMinimalActionButton(IconData icon, String tooltip) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.white54, size: 16),
    );
  }

  Widget _buildMinimalChip(String label) {
    return GestureDetector(
      onTap: () {
        _controller.text = label.substring(3); // Remove emoji
        ref.read(promptInputProvider.notifier).state = _controller.text;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Text(
          label,
          style: GoogleFonts.manrope(
            color: Colors.white60,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildPlatformToggle(WidgetRef ref, String current) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleItem(
            ref,
            "App",
            Icons.phone_iphone_rounded,
            current == "App",
          ),
          _buildToggleItem(
            ref,
            "Web",
            Icons.desktop_mac_rounded,
            current == "Web",
          ),
        ],
      ),
    );
  }

  Widget _buildToggleItem(
    WidgetRef ref,
    String label,
    IconData icon,
    bool isActive,
  ) {
    return GestureDetector(
      onTap: () => ref.read(selectedPlatformProvider.notifier).state = label,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuint,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? Colors.indigoAccent : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: isActive
              ? null
              : Border.all(color: Colors.transparent), // Layout stability
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.indigoAccent.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Icon(
                  icon,
                  size: 18,
                  color: isActive ? Colors.white : Colors.white38,
                )
                .animate(target: isActive ? 1 : 0)
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.2, 1.2),
                  duration: 200.ms,
                  curve: Curves.easeOutBack,
                )
                .then()
                .scale(
                  begin: const Offset(1.2, 1.2),
                  end: const Offset(1, 1),
                  duration: 200.ms,
                ),

            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : Colors.white38,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String tooltip) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Icon(icon, color: Colors.white70, size: 20),
    );
  }

  Widget _buildPromptCard(
    IconData icon,
    String title,
    String subtitle,
    Color accent,
  ) {
    return GestureDetector(
      onTap: () {
        _controller.text = "$title: $subtitle";
        ref.read(promptInputProvider.notifier).state = _controller.text;
      },
      child: Container(
        width: 260,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF18181B),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: accent, size: 24),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: GoogleFonts.spaceGrotesk(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: GoogleFonts.inter(
                color: Colors.white38,
                fontSize: 13,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
