import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
                height: 200, width: 200, child: CircularProgressIndicator()),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {
                  parseJson(context, false);
                },
                child: const Text('Парсить')),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {
                  parseJson(context, true);
                },
                child: const Text('Парсить в изоляте')),
          ],
        ),
      ),
    );
  }
}

void parseJson(BuildContext context, bool isolate) async {
  final stopwatch = Stopwatch()..start();
  final data =
      await DefaultAssetBundle.of(context).loadString("assets/many.json");
  if (isolate) {
    await Isolate.run(() => jsonDecode(data));
    print('Время парсинга с изолятом: ${stopwatch.elapsed}');
  } else {
    jsonDecode(data);
    print('Время парсинга: ${stopwatch.elapsed}');
  }
}
