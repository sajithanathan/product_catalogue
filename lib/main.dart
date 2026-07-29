import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/product_provider.dart';
import 'screens/product_list_screen.dart';
import 'utils/theme.dart';

void main() {
  runApp(const JuiceApp());
}

class JuiceApp extends StatefulWidget {
  const JuiceApp({super.key});

  @override
  State<JuiceApp> createState() => _JuiceAppState();
}

class _JuiceAppState extends State<JuiceApp> {
  bool _isDark = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _isDark = prefs.getBool('isDark') ?? false;
      });
    } catch (e) {
      _isDark = false;
    }
  }

  void _toggleTheme() async {
    setState(() {
      _isDark = !_isDark;
    });
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDark', _isDark);
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider()..loadProducts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Juice Catalogue',
        theme: _isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
        home: ProductListScreen(
          onThemeToggle: _toggleTheme,
          isDark: _isDark,
        ),
      ),
    );
  }
}