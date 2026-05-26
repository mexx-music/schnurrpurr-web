import 'package:flutter/material.dart';
import '../sections/hero_section.dart';
import '../sections/app_section.dart';
import '../sections/pillow_section.dart';
import '../sections/knowledge_section.dart';
import '../sections/contact_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            HeroSection(),
            AppSection(),
            PillowSection(),
            KnowledgeSection(),
            ContactSection(),
          ],
        ),
      ),
    );
  }
}
