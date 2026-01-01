
class GeminiService {
  // Using Mock Data specifically requested by user to ensure UI stability
  static const String _apiKey = 'MOCK_KEY_FOR_DEMO';

  Future<Map<String, dynamic>> generateUiSpecs(
    String userPrompt,
    String platform,
  ) async {
    // Simulate Network Delay
    await Future.delayed(const Duration(milliseconds: 1000));

    // Return rich mock data based on simple keyword matching
    if (userPrompt.toLowerCase().contains('crypto') ||
        userPrompt.toLowerCase().contains('finance')) {
      return _cryptoMock;
    } else if (userPrompt.toLowerCase().contains('social') ||
        userPrompt.toLowerCase().contains('chat')) {
      return _socialMock;
    } else {
      return _defaultMock; // SaaS / Dashboard Style
    }
  }

  // MOCK DATA: NATIVE WIDGET MAPPING
  static final _cryptoMock = {
    "title": "Nova Wallet",
    "subtitle": "Next-gen DeFi Portfolio",
    "context_points": [
      "Dark aesthetics for premium finance feel",
      "Green accents for positive trend indication",
      "Native Flutter Widgets for smooth performance",
    ],
    "screens": [
      {
        "name": "Dashboard",
        "description": "Main asset overview",
        "widget_id": "mock_crypto_dashboard",
        "color": 0xFF000000,
      },
      {
        "name": "Portfolio",
        "description": "Detailed asset breakdown",
        "widget_id": "mock_crypto_portfolio",
        "color": 0xFF18181B,
      },
      {
        "name": "Swap",
        "description": "Token exchange interface",
        "widget_id": "mock_crypto_swap",
        "color": 0xFF18181B,
      },
      {
        "name": "Market",
        "description": "Live price charts",
        "widget_id": "mock_crypto_market",
        "color": 0xFF000000,
      },
    ],
  };

  static final _socialMock = {
    "title": "Pulse Connect",
    "subtitle": "Real-time community feed",
    "context_points": [
      "Staggered feed layout",
      "High contrast typography",
      "Native List Performance",
    ],
    "screens": [
      {
        "name": "Feed",
        "description": "Main activity stream",
        "widget_id": "mock_social_feed",
        "color": 0xFF000000,
      },
      {
        "name": "Explore",
        "description": "Discover new content",
        "widget_id": "mock_social_feed",
        "color": 0xFF18181B,
      },
      {
        "name": "Profile",
        "description": "User gallery",
        "widget_id": "mock_social_feed",
        "color": 0xFF000000,
      },
      {
        "name": "Notifications",
        "description": "Activity updates",
        "widget_id": "mock_social_feed",
        "color": 0xFF18181B,
      },
    ],
  };

  static final _defaultMock = {
    "title": "Nexus Dashboard",
    "subtitle": "Analytics & Overview",
    "context_points": ["Grid layout", "Clean lists", "Native Chart Widgets"],
    "screens": [
      {
        "name": "Overview",
        "description": "Key business metrics",
        "widget_id": "mock_saas_dashboard",
        "color": 0xFF000000,
      },
      {
        "name": "Analytics",
        "description": "Traffic reports",
        "widget_id": "mock_saas_dashboard",
        "color": 0xFF18181B,
      },
      {
        "name": "Customers",
        "description": "User management",
        "widget_id": "mock_saas_dashboard",
        "color": 0xFF000000,
      },
      {
        "name": "Settings",
        "description": "Platform configuration",
        "widget_id": "mock_saas_dashboard",
        "color": 0xFF18181B,
      },
    ],
  };
}
