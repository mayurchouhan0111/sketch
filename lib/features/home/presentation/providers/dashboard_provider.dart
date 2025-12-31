import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/gemini_service.dart';
import '../../domain/entities/generation_item.dart';
import '../../data/repositories/generation_repository.dart';

// Repository Provider
final generationRepositoryProvider = Provider<GenerationRepository>((ref) {
  return GenerationRepository();
});

// Future Provider for fetching history
final recentGenerationsProvider = FutureProvider<List<GenerationItem>>((ref) async {
  final repo = ref.watch(generationRepositoryProvider);
  return repo.getRecentGenerations();
});

// State for the Platform Toggle (App vs Web)
final selectedPlatformProvider = StateProvider<String>((ref) => 'App');

// State for the Input Text
final promptInputProvider = StateProvider<String>((ref) => '');

// State for the current generation being viewed/created
final currentGenerationContentProvider = StateProvider<Map<String, dynamic>?>((ref) => null);

// ENUMS
enum DashboardTab { dashboard, explore, library, settings }

// STATE PROVIDERS
final sidebarSelectionProvider = StateProvider<DashboardTab>((ref) => DashboardTab.dashboard);

final isDesktopProvider = StateProvider<bool>((ref) => true);

// EXISTING PROVIDERS
final isGeneratingProvider = StateProvider<bool>((ref) => false);

// Action: Start Generation
Future<void> startGeneration(WidgetRef ref, String prompt) async {
  ref.read(isGeneratingProvider.notifier).state = true;
  ref.read(currentGenerationContentProvider.notifier).state = null;
  
  final platform = ref.read(selectedPlatformProvider);
  final service = GeminiService(); 
  
  try {
    // Call Real Gemini API
    final result = await service.generateUiSpecs(prompt, platform);
    ref.read(currentGenerationContentProvider.notifier).state = result;
  } catch (e) {
    print("Generation Error: $e");
    // Fallback error state if needed, but service handles internal fallbacks
  } finally {
    ref.read(isGeneratingProvider.notifier).state = false;
  }
}
