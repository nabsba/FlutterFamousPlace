class ResponseGraphql<T> {
  final int status;
  final bool isError;
  final String messageKey;
  final Map<String, dynamic>? data;

  ResponseGraphql({
    required this.status,
    required this.isError,
    required this.messageKey,
    this.data,
  });

  factory ResponseGraphql.fromMap(Map<String, dynamic> map) {
    return ResponseGraphql(
      status: map['status'] ?? 0,
      isError: map['isError'] ?? false,
      messageKey: map['messageKey'] ?? '',
      data: map['data'] as Map<String, dynamic>?,
    );
  }

  @override
  String toString() {
    return 'ResponseGraphql(status: $status, isError: $isError, messageKey: $messageKey, data: $data)';
  }
}
