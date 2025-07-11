import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:flutter_clinicapp/presentation/telemedis/blocs/agora_token/agora_token_bloc.dart';
import 'package:flutter_clinicapp/presentation/telemedis/pages/video_call_page.dart';

class LoadingVidcallPage extends StatefulWidget {
  final String channel;
  final bool isDoctor;
  const LoadingVidcallPage({
    super.key,
    required this.channel,
    required this.isDoctor,
  });

  @override
  State<LoadingVidcallPage> createState() => _LoadingVidcallPageState();
}

class _LoadingVidcallPageState extends State<LoadingVidcallPage> {
  @override
  void initState() {
    context.read<AgoraTokenBloc>().add(
          AgoraTokenEvent.token(widget.channel),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AgoraTokenBloc, AgoraTokenState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            error: (error) {
              context.showSnackBar(error, Colors.red);
            },
            success: (data) {
              context.pushReplacement(VideoCallPage(
                channel: widget.channel,
                token: data.token,
                uid: data.uid,
                isDoctor: widget.isDoctor,
              ));
            },
          );
        },
        child: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
