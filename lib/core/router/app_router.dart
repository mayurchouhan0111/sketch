import 'package:go_router/go_router.dart';

import '../../features/home/presentation/screens/dashboard_layout.dart';
import '../../features/home/presentation/screens/generation_detail_screen.dart';
import '../../features/home/presentation/screens/splash_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardLayout(),
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) => const GenerationDetailScreen(),
    ),
  ],
);
