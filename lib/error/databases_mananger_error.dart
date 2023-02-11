class DatabasesManagerError implements Exception {
  final String message;

  DatabasesManagerError({required this.message});

  @override
  String toString() => message;
}
