import 'package:flutter/material.dart';
import 'package:isolated_download_manager_flutter/types/download_state.dart';
import 'package:isolated_download_manager/isolated_download_manager.dart';

part 'package:isolated_download_manager_flutter/types/download_controller.dart';

/// Builder function for each state of file downloading
/// [DownloadRequest] stored and controlled internally, by providing the [DownloadWidgetController] interface
class DownloadUrlWidget extends StatefulWidget {
  const DownloadUrlWidget(
      {super.key,
      required this.builder,
      required this.url,
      this.path,
      this.controller,
      this.manager})
      : super();

  /// Builder is required to build the UI based on current download state
  final Widget Function(
    BuildContext context,
    DownloadWidgetController controller,
    DownloadWidgetState state,
    double? progress,
    Object? error,
    DownloadRequest? request,
  ) builder;

  /// File url
  final String url;

  /// Destination file location
  final String? path;

  /// Manager instanse, if not provided the default one is used
  final DownloadManager? manager;

  /// Controller, if not provided the default one is used
  final DownloadWidgetController? controller;

  @override
  State<DownloadUrlWidget> createState() => _DownloadUrlWidgetState();
}

class _DownloadUrlWidgetState extends State<DownloadUrlWidget> {
  late DownloadManager manager;
  late DownloadWidgetController controller;
  DownloadRequest? request;

  @override
  void initState() {
    super.initState();
    manager = widget.manager ?? DownloadManager.instance;

    controller = widget.controller ?? DownloadWidgetController();
    controller._download = _download;
    controller._cancel = _cancel;
    controller._resume = _resume;
    controller._pause = _pause;
    controller._reset = _reset;
  }

  @override
  Widget build(BuildContext context) {
    if (request == null) {
      return widget.builder(context, controller, DownloadWidgetState.initial,
          null, null, request);
    }

    return StreamBuilder(
        stream: request!.events,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return widget.builder(context, controller,
                DownloadWidgetState.failed, null, null, request);
          }

          if (snapshot.hasData) {
            final data = snapshot.data!;
            if (data is double) {
              return widget.builder(context, controller,
                  DownloadWidgetState.downloading, data, null, request);
            }

            switch (data as DownloadState) {
              case DownloadState.queued:
                return widget.builder(context, controller,
                    DownloadWidgetState.queued, null, null, request);
              case DownloadState.started:
              case DownloadState.resumed:
                return widget.builder(context, controller,
                    DownloadWidgetState.downloading, null, null, request);
              case DownloadState.paused:
                return widget.builder(
                    context,
                    controller,
                    DownloadWidgetState.paused,
                    request!.progress,
                    null,
                    request);
              case DownloadState.cancelled:
                return widget.builder(context, controller,
                    DownloadWidgetState.initial, null, null, request);
              case DownloadState.finished:
                return widget.builder(context, controller,
                    DownloadWidgetState.downloaded, 1.0, null, request);
            }
          }

          return widget.builder(context, controller,
              DownloadWidgetState.initial, null, null, request);
        });
  }

  void _download() =>
      setState(() => request = manager.download(widget.url, path: widget.path));
  void _pause() => request?.pause();
  void _resume() => request?.resume();
  void _cancel() => request?.cancel();
  void _reset() {
    _cancel();
    setState(() => request = null);
  }
}
