// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ConnectionInfo {
  late String host;
  late int port;
  late String username;
  late String password;

  ConnectionInfo(host, port, username, password) {
    setHost(host);
    setPort(port);
    setUsername(username);
    setPassword(password);
  }

  void setHost(String host) {
    if (host.isEmpty) throw Exception('Host cannot be empty');
    this.host = host;
  }

  void setUsername(String username) {
    if (username.isEmpty) throw Exception('Username cannot be empty');
    this.username = username;
  }

  void setPassword(String password) {
    if (password.isEmpty) throw Exception('Password cannot be empty');
    this.password = password;
  }

  void setPort(int port) {
    if (port < 0) throw Exception('Port must be a positive number');
    this.port = port;
  }

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

  factory ConnectionInfo.fromJson(String source) =>
      ConnectionInfo.fromMap(json.decode(source) as Map<String, dynamic>);
// #endregion

// #region: Equals
  @override
  bool operator ==(covariant ConnectionInfo other) {
    if (identical(this, other)) return true;

    return other.host == host &&
        other.port == port &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode {
    return host.hashCode ^
        port.hashCode ^
        username.hashCode ^
        password.hashCode;
  }
// #endregion
}
