class MessageModel {
  String? messageId;
  String? sender;
  String? text;
  bool? seen;
  DateTime? creatDon;

  MessageModel(
      {this.creatDon, this.seen, this.sender, this.text, this.messageId});

  MessageModel.fromMap(Map<String, dynamic> map) {
    sender = map['sender'];
    seen = map['seen'];
    // creatDon = DateTime.fromMillisecondsSinceEpoch(map['creatDon']);
    creatDon = map['creatDon'].toDate();
    text = map['text'];
    messageId = map['messageId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'seen': seen,
      'creatDon': creatDon,
      'text': text,
      'messageId': messageId,
    };
  }
}
