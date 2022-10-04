Ready-to-use Flutter widgets to download files in isolates using [isolated_download_manager](https://pub.dev/packages/isolated_download_manager) package

## Preview

![Flutter Download Manager - iPhone 14 Pro Max](https://user-images.githubusercontent.com/21260939/193834026-52c81596-cdbd-40cd-a487-ba6d8dfb2edd.png)

## Getting started

Include latest version from [pub.dev](https://pub.dev/packages/isolated_download_manager_flutter) to `pubspec.yaml`

## Usage

There are just two widgets:
- **DownloadWidget** - to represent UI of `DownloadRequest` object state.
  ```dart
  DownloadWidget(
    request: request, 
    builder: (context, state, progress, error) {
      // UI goes here 
    }
  )
  ```
  [Full example code](example/flutter_request_example.dart)

- **DownloadUrlWidget** - simplified version where `DownloadRequest` is stored internally (accessed via builder).
  ```dart
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
  The controller allows to access task outside of widget builder's body.
  [Full example code](example/flutter_url_example.dart)

Feature-rich example available at [complex example directory](example/complex)
