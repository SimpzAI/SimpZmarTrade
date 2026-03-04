import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home_screen.dart';
import 'services/notification_service.dart';
import 'models/trader_profile.dart';
import 'models/day_session.dart';
import 'models/trade.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final themeModeIndex =
      prefs.getInt('themeMode') ?? ThemeMode.system.index;
  final themeMode = ThemeMode.values[themeModeIndex];

  runApp(SimpSmarTradeApp(initialThemeMode: themeMode));

  // Initialize notifications AFTER UI loads
  Future.microtask(() async {
    try {
      await NotificationService.instance.initialize();
      await NotificationService.instance
          .scheduleDefaultRemindersIfEnabled();
    } catch (e) {
      debugPrint('Notification init error: $e');
    }
  });
}
class SimpSmarTradeApp extends StatefulWidget {
  const SimpSmarTradeApp({super.key, required this.initialThemeMode});

  final ThemeMode initialThemeMode;

  @override
  State<SimpSmarTradeApp> createState() => _SimpSmarTradeAppState();

  static _SimpSmarTradeAppState of(BuildContext context) {
    return context.findAncestorStateOfType<_SimpSmarTradeAppState>()!;
  }
}

class _SimpSmarTradeAppState extends State<SimpSmarTradeApp> {
  ThemeMode get themeMode => _themeMode;
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.initialThemeMode;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (mode == _themeMode) return;
    setState(() => _themeMode = mode);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', mode.index);
  }

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF00D1B2);

    return MaterialApp(
      title: 'SimpSmarTrade',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
