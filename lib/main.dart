import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final counterProvider = StateNotifierProvider<Counter, int>((_) => Counter());

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void increment() => state++;
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
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3Dモデリングテスト'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            const ModelViewer(
              src: 'images/BestID5.glb', // 3Dモデルファイルのパス
              alt: 'A 3D model',
              ar: true,
              autoRotate: true,
              cameraControls: true,
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: Image.asset(
                'images/ar1.png', // PNG画像ファイルのパス
                width: 100,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
