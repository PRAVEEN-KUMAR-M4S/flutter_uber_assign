part of 'fetch_data_bloc.dart';

sealed class FetchDataEvent extends Equatable {
  const FetchDataEvent();

  @override
  List<Object> get props => [];
}

final class FetchUserData extends FetchDataEvent {}

final class FetchDriverData extends FetchDataEvent {}

final class FetchRideDetails extends FetchDataEvent{}

final class BookRideEvent extends FetchDataEvent {
  final Booking booking;

  const BookRideEvent({required this.booking});

  @override
  List<Object> get props => [booking];
}
