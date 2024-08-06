import 'package:bloc/bloc.dart';
import 'package:calibort_assignment/services/api_services.dart';
import 'package:equatable/equatable.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiServices apiService;

  UserBloc(this.apiService) : super(UserInitial()) {
    // Registering event handlers
    on<FetchUsers>(_onFetchUsers);
    on<Logout>(_onLogout);
  }

  void _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final users = await apiService.fetchUsers(event.page);
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError('Failed to fetch users: $e'));
    }
  }

  void _onLogout(Logout event, Emitter<UserState> emit) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      emit(UserInitial());
    } catch (e) {
      print('Error during logout: $e'); // Debugging line
    }
  }
}
