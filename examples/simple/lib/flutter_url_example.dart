import 'package:flutter/material.dart';
import 'package:isolated_download_manager_flutter/isolated_download_manager_flutter.dart';
import 'package:isolated_download_manager/isolated_download_manager.dart';
import 'dart:io' show File;

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key}) : super();

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  static const String url =
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
  static const String path = "./BigBuckBunny.mp4";

  // controller isn't required, but used to access it outside of widget builder
  final _controller = DownloadWidgetController();

  @override
  void initState() {
    super.initState();
    DownloadManager.instance.init(isolates: 2);
  }

  @override
  void dispose() {
    DownloadManager.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text("DownloadUrlWidget"), actions: [
              IconButton(
                  onPressed: _reset, icon: const Icon(Icons.replay_rounded))
            ]),
            body: Center(
                child: DownloadUrlWidget(
                    url: url,
                    path: path,
                    controller: _controller,
                    builder:
                        (context, controller, state, progress, error, request) {
                      switch (state) {
                        case DownloadWidgetState.initial:
                          return IconButton(
                              onPressed: controller.download,
                              icon: const Icon(Icons.download_rounded));
                        case DownloadWidgetState.queued:
                        case DownloadWidgetState.downloading:
                          return Stack(alignment: Alignment.center, children: [
                            CircularProgressIndicator(
                                value: 1.0,
                                color: Colors.grey.withOpacity(0.2)),
                            CircularProgressIndicator(value: progress),
                            IconButton(
                                onPressed: controller.cancel,
                                icon: const Icon(Icons.close_rounded)),
                          ]);
                        case DownloadWidgetState.failed:
                          return IconButton(
                              onPressed: controller.download,
                              icon: const Icon(Icons.restart_alt_rounded));
                        case DownloadWidgetState.downloaded:
                          return const Icon(Icons.done_rounded);
                        default:
                          return const SizedBox();
                      }
                    }))));
  }

  void _reset() async {
    _controller.reset();
    final file = File(path);
    if (await file.exists()) await file.delete();
  }
}
