part of 'package:isolated_download_manager_flutter/widgets/download_url.dart';

/// Controller allows to expose the object outside of builder's body
class DownloadWidgetController {
  DownloadWidgetController();

  /// Interface to start the downloading
  void Function()? _download;
  void download() {
    _download?.call();
  }

  /// Interface to pause the downloading
  void Function()? _pause;
  void pause() {
    _pause?.call();
  }

  /// Interface to continue the downloading
  void Function()? _resume;
  void resume() {
    _resume?.call();
  }

  /// Interface to cancel the downloading
  void Function()? _cancel;
  void cancel() {
    _cancel?.call();
  }

  /// Interface to reset the [DownloadRequest] stored in widget internally
  void Function()? _reset;
  void reset() {
    _reset?.call();
  }
}
