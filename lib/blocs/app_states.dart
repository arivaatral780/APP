import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../some/a.dart';
@immutable
abstract class UserState extends Equatable{

}
class UserLoadingState extends UserState{
  List<Object?> get props => [];

}
class UserLoadedState extends UserState{
  UserLoadedState(this.users);
  final List<contact> users;
  List<Object?> get props => [users];

}

class UserErrorState extends UserState{
  UserErrorState(this.error);
  final String error;
  List<Object?> get props => [error];

}