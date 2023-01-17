import '../some/a.dart';
import 'app_events.dart';
import 'app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent,UserState>{
  final a _userRepository;
  UserBloc(this._userRepository) : super(UserLoadingState()){
    on<LoadUserEvent>((event,emit)async{
      emit(UserLoadingState());
      try{
        final users = await _userRepository.getcontact();
        emit(UserLoadedState(users));
      }
      catch(e){
        emit(UserErrorState(e.toString()));
      }

    });
  }
}