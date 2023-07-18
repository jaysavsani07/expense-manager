import 'package:fimber/fimber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
//     print('''
// {
//   "provider": "${provider.name ?? provider.runtimeType}",
//   "newValue": "$newValue"
// }''');
  }

  @override
  void providerDidFail(ProviderBase<Object?> provider, Object error,
      StackTrace stackTrace, ProviderContainer container) {
    Fimber.e(provider.name??"Ok", ex: error, stacktrace: stackTrace);
    super.providerDidFail(provider, error, stackTrace, container);
  }
}
