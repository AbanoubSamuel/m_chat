import '../constants.dart';

class Message {
  final String message;
  final String id;

  Message(this.message, this.id);

  factory Message.fromSnapshot(jsonData) {
    return Message(jsonData[kMessage], jsonData[kId]);
  }
}
