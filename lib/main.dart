import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/core/core.dart';
import 'package:rider_mobile/features/onboarding/splash_screen.dart';
import 'package:rider_mobile/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: AppThemeData.lightTheme,
      navigatorObservers: [RouteLifecycleObserver.routeObserver],
      navigatorKey: MobileNavigationService.instance.navigatorKey,
      builder:
          (context, widget) => Navigator(
            key: AppFlushBar.navigatorKey,
            onGenerateRoute:
                (settings) => MaterialPageRoute(
                  builder: (context) => FlushBarLayer(child: widget!),
                ),
          ),
      onGenerateRoute: AppRouter.generateRoute,
      home: const SplashView(),
    );
  }
}
