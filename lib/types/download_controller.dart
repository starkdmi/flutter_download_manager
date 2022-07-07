part of 'package:flutter_download_manager/widgets/download_url.dart';

class DownloadWidgetController {
  DownloadWidgetController._({
    required void Function() download,
    required void Function() cancel,
    required void Function() resume,
    required void Function() pause,
  }) : _download = download, _cancel = cancel, _resume = resume, _pause = pause;

  final void Function() _download;
  void download() { _download(); }

  final void Function() _pause;
  void pause() { _pause(); }

  final void Function() _resume;
  void resume() { _resume(); }

  final void Function() _cancel;
  void cancel() { _cancel(); }
}