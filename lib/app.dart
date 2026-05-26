import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'pages/home_page.dart';

class SchnurrPurrApp extends StatelessWidget {
  const SchnurrPurrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SchnurrPurr',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const HomePage(),
    );
  }
}
