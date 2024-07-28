part of 'fetch_data_bloc.dart';

sealed class FetchDataState extends Equatable {
  const FetchDataState();

  @override
  List<Object> get props => [];
}

final class FetchDataInitial extends FetchDataState {}

final class BookRideSuccess extends FetchDataState {}

final class FetchDriverDataSuccess extends FetchDataState {
  final List<DriverModel> drivers;

  const FetchDriverDataSuccess({required this.drivers});

  @override
  List<Object> get props => [drivers];
}

final class FetchUserDataSuccess extends FetchDataState {
  final UserModel userModel;

  const FetchUserDataSuccess({required this.userModel});
  @override
  List<Object> get props => [userModel];
}

final class FetchDataLoading extends FetchDataState {}

final class FetchDataFailure extends FetchDataState {
  final String error;

  const FetchDataFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class FetchRideSuccess extends FetchDataState {
  final List<Booking> bookings;

  const FetchRideSuccess(this.bookings);

  @override
  List<Object> get props => [bookings];
}
