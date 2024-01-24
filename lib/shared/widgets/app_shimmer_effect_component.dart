import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmerEffectComponent extends StatelessWidget {
  const AppShimmerEffectComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.onSurface.withOpacity(.3),
        highlightColor: Theme.of(context).colorScheme.onSurface.withOpacity(.01),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Container(
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(.1),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(.1),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(.1),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(.1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
