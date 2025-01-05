part of 'application_bloc.dart';

class ApplicationState extends Equatable {
  final String domainApplication;

  @override
  List<Object?> get props => [domainApplication];

  const ApplicationState({this.domainApplication = ""});

  ApplicationState copyWith({String? newDomain}) {
    return ApplicationState(domainApplication: newDomain ?? domainApplication);
  }
}
