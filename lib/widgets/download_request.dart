import 'package:flutter/material.dart';
import 'package:flutter_download_manager/types/download_state.dart';
import 'package:isolated_download_manager/download_manager.dart';

/// Builder function for each state of file downloading
/// You take control of [DownloadRequest] storing and controlling the download process
/// Warning: Request's event stream shouldn't be in use
class DownloadWidget extends StatelessWidget {
  const DownloadWidget({ super.key, required this.builder, this.request }) : super();
  
  final Widget Function(BuildContext context, DownloadWidgetState state, double? progress, Object? error) builder;
  final DownloadRequest? request;

  @override
  Widget build(BuildContext context) {
    if (request == null) {
      return builder(context, DownloadWidgetState.initial, null, null);
    }

    return StreamBuilder(
      stream: request!.events, 
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return builder(context, DownloadWidgetState.failed, null, snapshot.error);
        }

        if (snapshot.hasData) {
          final data = snapshot.data!;
          if (data is double) {
            return builder(context, DownloadWidgetState.downloading, data, null);
          }

          switch (data as DownloadState) {
            case DownloadState.queued:
              return builder(context, DownloadWidgetState.queued, null, null);
            case DownloadState.started:
            case DownloadState.resumed:
              return builder(context, DownloadWidgetState.downloading, null, null);
            case DownloadState.paused:
              return builder(context, DownloadWidgetState.paused, request!.progress, null);
            case DownloadState.cancelled:
              return builder(context, DownloadWidgetState.initial, null, null);
            case DownloadState.finished:
              return builder(context, DownloadWidgetState.downloaded, 1.0, null);
          }
        }

        return builder(context, DownloadWidgetState.initial, null, null);
      }
    );
  }
}