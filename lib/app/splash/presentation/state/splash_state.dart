part of '../controller/splash_bloc.dart';

abstract class SplashState {}

class SplashInitialState extends SplashState {}

class SplashPageLoadingState extends SplashState {}

class SplashPageLoadedState extends SplashState {
  final String currentSession;

  SplashPageLoadedState({this.currentSession = ''});
}

class SplashPageErrorState extends SplashState {}
