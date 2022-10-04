part of 'package:isolated_download_manager_flutter/widgets/download_url.dart';

class DownloadWidgetController {
  DownloadWidgetController();

  void Function()? _download;
  void download() {
    _download?.call();
  }

  void Function()? _pause;
  void pause() {
    _pause?.call();
  }

  void Function()? _resume;
  void resume() {
    _resume?.call();
  }

  void Function()? _cancel;
  void cancel() {
    _cancel?.call();
  }

  void Function()? _reset;
  void reset() {
    _reset?.call();
  }
}
