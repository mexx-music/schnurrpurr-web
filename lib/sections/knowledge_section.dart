import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class KnowledgeSection extends StatelessWidget {
  const KnowledgeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;

    return Container(
      width: double.infinity,
      color: AppColors.surface,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 960),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: isWide ? 96 : 64,
            ),
            child: Column(
              children: [
                const _SectionLabel(label: 'Background'),
                const SizedBox(height: 12),
                Text(
                  'Why purring works',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isWide ? 38 : 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 56),
                isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Expanded(
                            child: _KnowledgeCard(
                              quote:
                                  '"Many people experience cat purring as calming and comforting."',
                              body:
                                  'The low-frequency sound of a purr — typically between 25 and 150 Hz — is something many people find deeply soothing. Whether it reminds us of quiet moments with a beloved pet or simply triggers a sense of safety, the effect can be powerful.',
                            ),
                          ),
                          SizedBox(width: 32),
                          Expanded(
                            child: _KnowledgeCard(
                              quote:
                                  '"A sound for the end of the day — or the beginning of sleep."',
                              body:
                                  'SchnurrPurr does not make medical claims. We offer a sensory experience designed to help you slow down, breathe more easily, and create space for rest. Think of it as a gentle ritual, not a remedy.',
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: const [
                          _KnowledgeCard(
                            quote:
                                '"Many people experience cat purring as calming and comforting."',
                            body:
                                'The low-frequency sound of a purr — typically between 25 and 150 Hz — is something many people find deeply soothing. Whether it reminds us of quiet moments with a beloved pet or simply triggers a sense of safety, the effect can be powerful.',
                          ),
                          SizedBox(height: 24),
                          _KnowledgeCard(
                            quote:
                                '"A sound for the end of the day — or the beginning of sleep."',
                            body:
                                'SchnurrPurr does not make medical claims. We offer a sensory experience designed to help you slow down, breathe more easily, and create space for rest. Think of it as a gentle ritual, not a remedy.',
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _KnowledgeCard extends StatelessWidget {
  final String quote;
  final String body;

  const _KnowledgeCard({required this.quote, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 3,
            decoration: BoxDecoration(
              color: AppColors.gold,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            quote,
            style: const TextStyle(
              color: AppColors.gold,
              fontSize: 16,
              fontStyle: FontStyle.italic,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            body,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: const TextStyle(
        color: AppColors.gold,
        fontSize: 13,
        letterSpacing: 4,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
