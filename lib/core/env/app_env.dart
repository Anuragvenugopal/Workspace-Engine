import 'package:envied/envied.dart';

part 'app_env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class AppEnv {
  @EnviedField(varName: 'API_BASE_URL')
  static final String apiBaseUrl = _AppEnv.apiBaseUrl;

  @EnviedField(varName: 'AUTH_TOKEN', obfuscate: true)
  static final String authToken = _AppEnv.authToken;
}
