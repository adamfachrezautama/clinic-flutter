import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_clinicapp/data/models/response/user_model.dart';

class Channel{
  final String id;
  final List<String> memberId;
  final String lastMessage;
  final Timestamp lastTime;
  final Map<String, bool> unRead;
  final List<UserModel> members;
  final String sendBy;

  Channel({
   required this.id,
   required this.memberId,
   required this.members,
   required this.lastMessage,
   required this.lastTime,
   required this.unRead,
   required this.sendBy,
});

  Map<String, dynamic> toMap(){
    return {
    'memberId': memberId,
      'members' : members.map((user) => user.toMap()..['id'] = user.id).toList(),
      'lastMessage': lastMessage,
      'sendBy': sendBy,
      'lastTime': lastTime,
      'unRead': unRead,
    };
  }

  factory Channel.fromMap(Map<String, dynamic> map){
    return Channel(
        id: map['id'] ?? '',
        memberId: List<String>.from(map['memberId']),
        members: List<UserModel>.from(map['members']?.map((user) => UserModel.fromMap(user))),
        lastMessage: map['lastMessage'] ?? '',
        lastTime: map['lastTime'] as Timestamp,
        unRead:map['unRead'] ,
        sendBy: map['sendBy'],);
  }

  factory Channel.fromDocumentSnapshot(DocumentSnapshot snapshot){
    return Channel(
      id: snapshot.id,
      memberId: List<String>.from(snapshot['memberId']),
      members: List<UserModel>.from(snapshot['members']?. map((user) => UserModel.fromMap(user))),
      lastMessage: snapshot['lastMessage'] ?? '',
      sendBy: snapshot['sendBy'],
      lastTime: snapshot['lastTime'] as Timestamp,
      unRead: Map<String, bool>.from(snapshot['unRead']),
    );
  }

}