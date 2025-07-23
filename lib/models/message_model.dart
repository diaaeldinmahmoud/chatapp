class MessageModel {
  final String message;
  final String? email;
  MessageModel({required this.message, this.email});
  factory MessageModel.fromJson(json) {
    return MessageModel(
      message: json['message'] ?? '',
      email: json['email'] ?? null,
    );
  }
}
