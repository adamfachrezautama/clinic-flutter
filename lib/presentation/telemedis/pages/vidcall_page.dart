// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter_clinicapp/core/components/spaces.dart';
// import 'package:flutter_clinicapp/core/constants/colors.dart';
// import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:flutter_clinicapp/presentation/telemedis/widgets/count_down.dart';
// import 'package:permission_handler/permission_handler.dart';
// import '../../../core/assets/assets.gen.dart';

// class VidCallPage extends StatefulWidget {
//   final String token;
//   final String channel;
//   final int uid;
//   const VidCallPage({
//     Key? key,
//     required this.token,
//     required this.channel,
//     required this.uid,
//   }) : super(key: key);

//   @override
//   State<VidCallPage> createState() => _VidCallPageState();
// }

// class _VidCallPageState extends State<VidCallPage> {
//   String appId = "19034d23a1564497beb01a5b1e84c50f";
//   int? _remoteUid;
//   bool _localUserJoined = false;
//   late RtcEngine _engine;

//   Future<void> initAgora() async {
//     // retrieve permissions
//     await [Permission.microphone, Permission.camera].request();

//     //create the engine
//     _engine = createAgoraRtcEngine();
//     await _engine.initialize(RtcEngineContext(
//       appId: appId,
//       channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//     ));

//     _engine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           debugPrint("local user ${connection.localUid} joined");
//           setState(() {
//             _localUserJoined = true;
//           });
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           debugPrint("remote user $remoteUid joined");
//           setState(() {
//             _remoteUid = remoteUid;
//           });
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid,
//             UserOfflineReasonType reason) {
//           debugPrint("remote user $remoteUid left channel");
//           setState(() {
//             _remoteUid = null;
//           });
//         },
//         onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
//           debugPrint(
//               '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
//         },
//       ),
//     );

//     await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
//     await _engine.enableVideo();
//     await _engine.startPreview();

//     await _engine.joinChannel(
//       token: widget.token,
//       channelId: widget.channel,
//       uid: widget.uid,
//       options: const ChannelMediaOptions(),
//     );
//   }

//   Future<void> _dispose() async {
//     await _engine.leaveChannel();
//     await _engine.release();
//   }

//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Image.asset(
//             //   Assets.images.doctorVidcall.path,
//             //   width: context.deviceWidth,
//             //   fit: BoxFit.cover,
//             // ),
//             Center(
//               child: _remoteVideo(),
//             ),
//             SizedBox(
//               width: context.deviceWidth,
//               height: context.deviceHeight,
//               child: ClipRRect(
//                 borderRadius:
//                     BorderRadius.circular(10), // Circular border for the video
//                 child: Center(
//                   child: _localUserJoined
//                       ? AgoraVideoView(
//                           controller: VideoViewController(
//                             rtcEngine: _engine,
//                             canvas: const VideoCanvas(uid: 0),
//                           ),
//                         )
//                       : const CircularProgressIndicator(),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 16,
//                 vertical: 24,
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     height: 32,
//                     width: 76,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(
//                         10,
//                       ),
//                       color: const Color(0xff1C1F1E).withOpacity(
//                         0.4,
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           height: 8,
//                           width: 8,
//                           decoration: const BoxDecoration(
//                             color: Color(0xffFF6C52),
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 4,
//                         ),
//                         // const Text(
//                         //   '1:32',
//                         //   style: TextStyle(
//                         //     color: AppColors.white,
//                         //     fontSize: 16,
//                         //     fontWeight: FontWeight.w500,
//                         //   ),
//                         // ),
//                         CountDown(
//                           onCountDownFinish: () {
//                             _dispose();
//                             Navigator.pop(context);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   Stack(
//                     children: [
//                       Image.asset(
//                         Assets.images.doctorVidcall2.path,
//                         width: 85.0,
//                         height: 94.0,
//                         fit: BoxFit.cover,
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(
//                           top: 80,
//                           left: 32,
//                         ),
//                         height: 28,
//                         width: 28,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: const Color(0xff1C1F1E).withOpacity(
//                             0.4,
//                           ),
//                         ),
//                         child: const Center(
//                           child: Icon(
//                             Icons.sync,
//                             color: AppColors.white,
//                             size: 14,
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Positioned(
//               bottom: 24,
//               left: 0,
//               right: 0,
//               child: Column(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 50),
//                     width: context.deviceWidth,
//                     padding: const EdgeInsets.all(8.0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(
//                         10,
//                       ),
//                       color: const Color(0xffC2C2C2).withOpacity(
//                         0.6,
//                       ),
//                     ),
//                     child: const Column(
//                       children: [
//                         Text(
//                           "drg. Nita Pratiwi",
//                           style: TextStyle(
//                             fontSize: 16.0,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black,
//                           ),
//                         ),
//                         Text(
//                           "Spesialis Ortodonsia",
//                           style: TextStyle(
//                               fontSize: 14.0,
//                               fontWeight: FontWeight.w500,
//                               color: Color(
//                                 0xff71717A,
//                               )),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SpaceHeight(
//                     20,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 50,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         _buttonCircle(
//                           false,
//                           Icons.mic,
//                         ),
//                         _buttonCircle(
//                           true,
//                           Icons.call,
//                         ),
//                         _buttonCircle(
//                           false,
//                           Icons.videocam,
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _remoteVideo() {
//     if (_remoteUid != null) {
//       return AgoraVideoView(
//         controller: VideoViewController.remote(
//           rtcEngine: _engine,
//           canvas: VideoCanvas(uid: _remoteUid),
//           connection: RtcConnection(channelId: widget.channel),
//         ),
//       );
//     } else {
//       return const Text(
//         'Please wait for remote user to join',
//         textAlign: TextAlign.center,
//       );
//     }
//   }

//   Widget _buttonCircle(bool isRed, IconData icon) {
//     return Container(
//       height: 72,
//       width: 72,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: isRed
//             ? const Color(0xffFF6C52)
//             : const Color(0xff1C1F1E).withOpacity(
//                 0.4,
//               ),
//       ),
//       child: Center(
//         child: Icon(
//           icon,
//           color: AppColors.white,
//           size: 28,
//         ),
//       ),
//     );
//   }
// }
