Ready-to-use Flutter widgets to download files in isolates using [isolated_download_manager](https://pub.dev/packages/isolated_download_manager) package

## Preview



## Getting started

Include latest version from [pub.dev](https://pub.dev/packages/isolated_download_manager_flutter) to `pubspec.yaml`

## Usage

There are just two widgets - `DownloadWidget` and `DownloadUrlWidget`:

```dart
// using DownloadRequest object
DownloadWidget(
  request: request, 
  builder: (context, state, progress, error) {
    // UI goes here 
  }
);

// using just an url
DownloadUrlWidget(
  url: url, 
  path: path, 
  controller: controller, // optional
  builder: (context, controller, state, progress, error, request) {
    // UI goes here 
  }
);
```
Examples source code available at [example's directory](example/)

## Additional information

For resumable downloads [download_task](https://pub.dev/packages/download_task) package is used
