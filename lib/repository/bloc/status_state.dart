part of 'status_bloc.dart';

@immutable
abstract class StatusState {}

class StatusInitial extends StatusState {}

class StatusLoading extends StatusState {}

class StatusLoaded extends StatusState {}

class StatusError extends StatusState {}

class ImageLoading extends StatusState {}

class ImageLoaded extends StatusState {}

class ImageError extends StatusState {}
