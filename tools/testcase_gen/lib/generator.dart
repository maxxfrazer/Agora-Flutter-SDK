import 'dart:io';

import 'package:paraphrase/paraphrase.dart';

enum GeneratorConfigPlatform {
  Android,
  iOS,
  macOS,
  Windows,
  Linux,
}

extension GeneratorConfigPlatformExt on GeneratorConfigPlatform {
  String toPlatformExpression() {
    switch (this) {
      case GeneratorConfigPlatform.Android:
        return 'Platform.isAndroid';
      case GeneratorConfigPlatform.iOS:
        return 'Platform.isIOS';
      case GeneratorConfigPlatform.macOS:
        return 'Platform.isMacOS';
      case GeneratorConfigPlatform.Windows:
        return 'Platform.isWindows';
      case GeneratorConfigPlatform.Linux:
        return 'Platform.isLinux';
    }
  }
}

class GeneratorConfig {
  const GeneratorConfig({
    required this.name,
    this.donotGenerate = false,
    this.supportedPlatforms = const [
      GeneratorConfigPlatform.Android,
      GeneratorConfigPlatform.iOS,
      GeneratorConfigPlatform.macOS,
      GeneratorConfigPlatform.Windows,
      GeneratorConfigPlatform.Linux,
    ],
    this.shouldMockResult = false,
    this.shouldMockReturnCode = false,
  });
  final String name;
  final bool donotGenerate;
  final List<GeneratorConfigPlatform> supportedPlatforms;
  final bool shouldMockReturnCode;
  final bool shouldMockResult;
}

const List<GeneratorConfigPlatform> desktopPlatforms = [
  GeneratorConfigPlatform.macOS,
  GeneratorConfigPlatform.Windows,
  GeneratorConfigPlatform.Linux,
];

const List<GeneratorConfigPlatform> mobilePlatforms = [
  GeneratorConfigPlatform.Android,
  GeneratorConfigPlatform.iOS,
];

IOSink? openSink(String? output) {
  if (output == null) {
    return null;
  }
  IOSink sink;
  File file;
  if (output == 'stdout') {
    sink = stdout;
  } else {
    file = File(output);
    sink = file.openWrite();
  }
  return sink;
}

abstract class Generator {
  void generate(StringSink sink, ParseResult parseResult);

  IOSink? shouldGenerate(ParseResult parseResult);
}
