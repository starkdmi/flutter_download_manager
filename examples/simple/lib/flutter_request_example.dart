import 'package:flutter/material.dart';
import 'package:isolated_download_manager_flutter/isolated_download_manager_flutter.dart';
import 'package:isolated_download_manager/isolated_download_manager.dart';
import 'dart:io' show File;

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({ super.key }) : super();

  @override 
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  static const String url = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
  static const String path = "./BigBuckBunny.mp4";

  DownloadRequest? _request;

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
        appBar: AppBar(
          title: const Text("DownloadWidget"),
          actions: [
            IconButton(onPressed: _reset, icon: const Icon(Icons.replay_rounded))
          ]
        ),
        body: Center(
          child: DownloadWidget(
            request: _request,
            builder: (context, state, progress, error) {
              switch (state) {
                case DownloadWidgetState.initial:
                  return IconButton(onPressed: _download, icon: const Icon(Icons.download_rounded));
                case DownloadWidgetState.queued:
                case DownloadWidgetState.downloading:
                  return Stack(alignment: Alignment.center, children: [
                    CircularProgressIndicator(value: 1.0, color: Colors.grey.withOpacity(0.2)),
                    CircularProgressIndicator(value: progress),
                    IconButton(onPressed: _cancel, icon: const Icon(Icons.close_rounded)),
                  ]);
                case DownloadWidgetState.failed:
                  return IconButton(onPressed: _download, icon: const Icon(Icons.restart_alt_rounded));
                case DownloadWidgetState.downloaded:
                  return const Icon(Icons.done_rounded);
                default:
                  return const SizedBox();
              }
            }
          )
        )
      )
    );
  }

  void _download() {
    setState(() => _request = DownloadManager.instance.download(url, path: path));
  }

  void _cancel() {
    _request?.cancel();
  }

  void _reset() async {
    _cancel();
    setState(() => _request = null);
    final file = File(path);
    if (await file.exists()) await file.delete();
  }
}