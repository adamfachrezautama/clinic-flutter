import 'package:flutter_clinicapp/data/datasources/order_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'xendit_callback_event.dart';
part 'xendit_callback_state.dart';
part 'xendit_callback_bloc.freezed.dart';

class XenditCallbackBloc
    extends Bloc<XenditCallbackEvent, XenditCallbackState> {
  final OrderRemoteDatasource datasource;

  XenditCallbackBloc(this.datasource) : super(const XenditCallbackState.initial()) {
    on<_Callback>((event, emit) async {
      emit(const _Loading());
      final response =
          await datasource.xenditCallback(event.externalId, event.status);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
