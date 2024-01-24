part of '../controller/favorites_bloc.dart';

abstract class FavoritesEvent {}

class FavoritesStartedEvent extends FavoritesEvent {
  final String userId;

  FavoritesStartedEvent({required this.userId});
}
