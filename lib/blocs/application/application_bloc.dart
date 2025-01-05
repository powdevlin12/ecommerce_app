import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc(super.state) {
    on<OnSetDomainApplication>(_onSetDomainApplication);
  }

  void _onSetDomainApplication(OnSetDomainApplication event, Emitter emit) {
    String domain = event.params.containsKey('domain')
        ? event.params['domain']
        : state.domainApplication;
    emit(state.copyWith(newDomain: domain));
  }
}
