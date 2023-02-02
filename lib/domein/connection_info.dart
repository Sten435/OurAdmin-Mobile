// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ConnectionInfo {
  late String _host;
  String get host => _host;

  late int _port;
  int get port => _port;

  late String _username;
  String get username => _username;

  late String _password;
  String get password => _password;

  ConnectionInfo(host, port, username, password) {
    setHost(host);
    setPort(port);
    setUsername(username);
    setPassword(password);
  }

// #region: Host
  void setHost(String host) {
    if (host.isEmpty) throw Exception('Host cannot be empty');
    _host = host;
  }
// #endregion

// #region: Username
  void setUsername(String username) {
    if (username.isEmpty) throw Exception('Username cannot be empty');
    _username = username;
  }
// #endregion

// #region: Password
  void setPassword(String password) {
    if (password.isEmpty) throw Exception('Password cannot be empty');
    _password = password;
  }
// #endregion

// #region: Port
  void setPort(int port) {
    if (port < 0) throw Exception('Port must be a positive number');
    _port = port;
  }
// #endregion

// #region: Mappers
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'host': host,
      'port': port,
      'username': username,
      'password': password,
    };
  }

  factory ConnectionInfo.fromMap(Map<String, dynamic> map) {
    return ConnectionInfo(
      map['host'] as String,
      map['port'] as int,
      map['username'] as String,
      map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConnectionInfo.fromJson(String source) => ConnectionInfo.fromMap(json.decode(source) as Map<String, dynamic>);
// #endregion
}
