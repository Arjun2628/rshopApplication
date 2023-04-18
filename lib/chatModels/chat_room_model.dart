class ChatRoomModel {
  String? chatroomId;
  Map<String, dynamic>? participants;
  String? lastMessage;
  List<dynamic>? users;
  DateTime? creatDon;
  ChatRoomModel(
      {this.chatroomId,
      this.participants,
      this.lastMessage,
      this.users,
      this.creatDon});

  ChatRoomModel.fromMap(Map<String, dynamic> map) {
    chatroomId = map['chatroomid'];
    participants = map['participants'];
    lastMessage = map['lastMessage'];
    users = map['users'];
    creatDon = map['creatDon'].toDate();
  }

  Map<String, dynamic> toMap() {
    return {
      'chatroomid': chatroomId,
      'participants': participants,
      'lastMessage': lastMessage,
      'users': users,
      'creatDon': creatDon
    };
  }
}
