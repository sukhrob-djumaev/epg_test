import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class IConnectivityService {
  Future<bool> get hasInternetConnection;
  Stream<bool> get connectionChanges;
}

final class ConnectivityService implements IConnectivityService {
  final InternetConnection _connection = InternetConnection();

  @override
  Future<bool> get hasInternetConnection async => await _connection.hasInternetAccess;

  @override
  Stream<bool> get connectionChanges => _connection.onStatusChange.map((event) => event == InternetStatus.connected);
}
