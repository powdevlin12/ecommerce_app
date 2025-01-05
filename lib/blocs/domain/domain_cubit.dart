// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:ercomerce_app/configs/preferences.dart';

class DomainCubit extends Cubit<String> {
  DomainCubit() : super('localhost') {
    loadDomain();
  }

  // ** Load domain app from SharePreferences
  Future<void> loadDomain() async {
    final savedDomain = await UserPreferences.getDomain();
    emit(savedDomain);
  }

  // ** Update domain and save it to SharedPreferences
  Future<void> updateDomain(String newDomain) async {
    await UserPreferences.setDomain(newDomain);
    emit(newDomain);
  }
}
