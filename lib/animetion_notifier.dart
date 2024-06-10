import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final animationControllerProvider = StateNotifierProvider.autoDispose<
    AnimationControllerNotifier, AnimationController>((ref) {
  return AnimationControllerNotifier(ref);
});

class AnimationControllerNotifier extends StateNotifier<AnimationController> {
  AnimationControllerNotifier(this.ref)
      : super(AnimationController(
          duration: const Duration(seconds: 2),
          vsync: ref.read(vsyncProvider),
        )..repeat(reverse: true)) {
    ref.onDispose(() => state.dispose());
  }

  Ref ref;
}

final vsyncProvider = Provider.autoDispose<TickerProvider>((ref) {
  throw UnimplementedError();
});

final animationProvider = Provider.autoDispose<Animation<double>>((ref) {
  final controller = ref.watch(animationControllerProvider);
  return Tween<double>(begin: 0, end: 200).animate(controller)
    ..addListener(() {
      ref.state = ref.state;
    });
});
