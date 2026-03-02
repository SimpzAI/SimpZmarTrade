import 'package:flutter/material.dart';

import '../main.dart';
import '../services/app_prefs.dart';
import '../services/notification_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _backendController = TextEditingController();
  bool _remindersEnabled = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final backendUrl = await AppPrefs.getBackendUrl();
    final enabled = await AppPrefs.getRemindersEnabled();
    setState(() {
      _backendController.text = backendUrl ?? '';
      _remindersEnabled = enabled;
    });
  }

  Future<void> _saveBackend() async {
    final url = _backendController.text.trim();
    await AppPrefs.setBackendUrl(url.isEmpty ? null : url);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Backend URL saved')));
    }
  }

  Future<void> _toggleReminders(bool v) async {
    setState(() => _remindersEnabled = v);
    await AppPrefs.setRemindersEnabled(v);
    if (v) {
      await NotificationService.instance.scheduleDefaultReminders();
    } else {
      await NotificationService.instance.cancelAll();
    }
  }

  @override
  void dispose() {
    _backendController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = SimpSmarTradeApp.of(context);

    return ListView(
      children: [
        const SizedBox(height: 8),
        const ListTile(
          title: Text('Backend (Auto-generate) URL'),
          subtitle: Text('Paste backend base URL. Example: https://yourdomain.com'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _backendController,
            decoration: const InputDecoration(
              labelText: 'Backend URL',
              hintText: 'https://...',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _saveBackend(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: FilledButton.icon(
            onPressed: _saveBackend,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Save'),
          ),
        ),
        const Divider(height: 24),
        SwitchListTile(
          title: const Text('Intraday reminders (09:15 / 09:30 / 11:00 / 15:10)'),
          subtitle: const Text('Local notifications in IST'),
          value: _remindersEnabled,
          onChanged: _toggleReminders,
        ),
        const Divider(height: 24),
        ListTile(
          title: const Text('Theme'),
          subtitle: const Text('System / Light / Dark'),
          trailing: DropdownButton<ThemeMode>(
            value: appState.themeMode,
            items: const [
              DropdownMenuItem(value: ThemeMode.system, child: Text('System')),
              DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
              DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
            ],
            onChanged: (m) {
              if (m == null) return;
              appState.setThemeMode(m);
            },
          ),
        ),
        const Divider(height: 24),
        const ListTile(
          title: Text('Alert sounds'),
          subtitle: Text('This debug build includes simple built-in sounds.'),
        ),
      ],
    );
  }
}
