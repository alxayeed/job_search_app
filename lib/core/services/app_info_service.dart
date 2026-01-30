import 'package:package_info_plus/package_info_plus.dart';

class AppInfoService {
  Future<AppVersion> getVersion() async {
    final info = await PackageInfo.fromPlatform();
    return AppVersion(
      version: info.version,
      buildNumber: info.buildNumber,
    );
  }
}

class AppVersion {
  final String version;
  final String buildNumber;

  const AppVersion({
    required this.version,
    required this.buildNumber,
  });

  String get formatted => 'v$version ($buildNumber)';

  @override
  String toString() => formatted;
}
