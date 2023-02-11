class DatabaseConnectionError implements Exception {
  final String message;

  DatabaseConnectionError({required this.message});

  @override
  String toString() => message;
}
