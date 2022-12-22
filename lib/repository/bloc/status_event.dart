part of 'status_bloc.dart';

@immutable
abstract class StatusEvent {}

class FetchStatus extends StatusEvent {}

class FetchImage extends StatusEvent {
  final dynamic personId;
  FetchImage({required this.personId});
}
