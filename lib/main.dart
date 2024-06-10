import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3Dモデリングテスト'),
      ),
      body: const Stack(
        alignment: Alignment.center,
        children: [
          ModelViewer(
            src: 'images/BestID5.glb', // 3Dモデルファイルのパス
            autoRotate: true,
            cameraControls: true,
            // cameraOrbit: '0deg 75deg 2.5m', // 初期のカメラ位置
            minCameraOrbit: 'auto 75deg auto', // 最小のカメラオービット
            maxCameraOrbit: 'auto 75deg auto', // 最大のカメラオービット
          ),
          AnimatedOverlay(),
        ],
      ),
    );
  }
}

class AnimatedOverlay extends StatefulWidget {
  const AnimatedOverlay({super.key});

  @override
  _AnimatedOverlayState createState() => _AnimatedOverlayState();
}

class _AnimatedOverlayState extends State<AnimatedOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 200).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: _animation.value,
      right: 0,
      left: 0,
      child: IgnorePointer(
        child: Column(
          children: [
            Image.asset(
              'images/ar1.png',
              width: 100,
              height: 100,
            ),
            Image.asset(
              'images/ar2.png',
              width: 100,
              height: 100,
            ),
            Image.asset(
              'images/ar6.png',
              width: 100,
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
