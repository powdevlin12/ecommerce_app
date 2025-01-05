part of 'application_bloc.dart';

abstract class ApplicationEvent extends Equatable {
  final Map<String, dynamic> params;
  const ApplicationEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class OnSetDomainApplication extends ApplicationEvent {
  const OnSetDomainApplication({required super.params});
}
