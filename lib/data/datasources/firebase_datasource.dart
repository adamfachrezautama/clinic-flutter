import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/response/channel_model.dart';

import '../models/response/message_model.dart';
import '../models/response/user_model.dart';

String generateChannelId(String id1, String id2, DateTime orderDate) {
  final formattedDate =
      '${orderDate.year}${orderDate.month.toString().padLeft(2, '0')}${orderDate.day.toString().padLeft(2, '0')}';
  if (id1.hashCode < id2.hashCode) {
    return '$id1-$id2-$formattedDate';
  }
  return '$id2-$id1-$formattedDate';
}

class FirebaseDatasource {
  FirebaseDatasource._init();

  static final FirebaseDatasource instance = FirebaseDatasource._init();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> isUserExist(String id) async {
    final snap =
    await FirebaseFirestore.instance.collection('users').doc().get();
    return snap.exists;
  }

  Future<void> setUserToDB(UserModel user) async {
    log("Data: ${user.toMap()} | ${DateTime.now().millisecondsSinceEpoch}");
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .set(user.toMap());
  }

  // get user by email
  Future<UserModel?> getUserByEmail(String email) async {
    log("Email: $email");
    return FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get()
        .then((value) {
      log("Value: ${value.docs}");
      if (value.docs.isEmpty) {
        return null;
      }
      return UserModel.fromDocumentSnapshot(value.docs.first);
    });
  }

  Future<Channel?> getChannel(String channelId) async {
    return FirebaseFirestore.instance
        .collection('channels')
        .doc(channelId)
        .get()
        .then((chanel) {
      if (chanel.exists) {
        return Channel.fromDocumentSnapshot(chanel);
      }
      return null;
    });
  }

  Future<void> updateChannel(
      String channelId, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('channels')
        .doc(channelId)
        .set(data, SetOptions(merge: true));
  }

  Future<void> addMessage(Message message) async {
    await FirebaseFirestore.instance
        .collection('messages')
        .add(message.toMap());
  }

  Stream<List<Message>> messageStream(String channelId) {
    return FirebaseFirestore.instance
        .collection('messages')
        .where('channelId', isEqualTo: channelId)
        .orderBy('sendAt', descending: true)
        .snapshots()
        .map((querySnapshot) {
      List<Message> rs = [];
      for (var element in querySnapshot.docs) {
        rs.add(Message.fromDocumentSnapshot(element));
      }
      return rs;
    });
  }

  Stream<List<Channel>> channelStream(String userId) {
    return FirebaseFirestore.instance
        .collection('channels')
        .where('memberIds', arrayContains: userId)
        .orderBy('lastTime', descending: true)
        .snapshots()
        .map((querySnapshot) {
      log("QuerySnapshot2: ${querySnapshot.docs[0]}");
      List<Channel> rs = [];
      for (var element in querySnapshot.docs) {
        log("element data: ${element.data()}");
        rs.add(Channel.fromDocumentSnapshot(element));
      }
      return rs;
    });
  }

  Stream<List<Channel>> getAllChannels() {
    return _firestore.collection('channels').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Channel.fromDocumentSnapshot(doc);
      }).toList();
    });
  }

  Future<void> updateUidByEmail(String email, String uid) async {
    try {
      var querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print('User not found');
        return;
      }

      for (var doc in querySnapshot.docs) {
        await doc.reference.update({
          'uid': uid, // Assign UID to the doctor
        });
      }

      log('Doctor UID updated successfully');
    } catch (e) {
      log('Error updating doctor UID: $e');
    }
  }

  Future<bool> isFirstMessageOlderThanOneDay(String channelId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('messages')
        .where('channelId', isEqualTo: channelId)
        .orderBy('sendAt', descending: true)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final lastMessage = querySnapshot.docs.last.data();
      final sendAt = lastMessage['sendAt'] as Timestamp;
      final sendAtDate = sendAt.toDate();
      final now = DateTime.now();

      return now.difference(sendAtDate).inDays >= 1;
    }

    // Jika tidak ada pesan, anggap belum lebih dari sehari
    return false;
  }

  Future<void> updateOneSignalToken(String email, String token) async {
    final users = FirebaseFirestore.instance.collection('users');
    final snapshot = await users.where('email', isEqualTo: email).limit(1).get();

    if (snapshot.docs.isNotEmpty) {
      await snapshot.docs.first.reference.update({'onesignal_token': token});
    }
  }

}
