import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/faetures/home/repository/repository.dart';
import 'package:uber_clone/faetures/models/booking.dart';
import 'package:uber_clone/faetures/models/driver_model.dart';
import 'package:uber_clone/faetures/models/user_model.dart';

part 'fetch_data_event.dart';
part 'fetch_data_state.dart';

class FetchDataBloc extends Bloc<FetchDataEvent, FetchDataState> {
  final FetchUserDataService fetchUserDataService;
  FetchDataBloc(this.fetchUserDataService) : super(FetchDataInitial()) {
    on<FetchDataEvent>((event, emit) => emit(FetchDataLoading()));
    on<FetchUserData>(_onfetchUserData);
    on<FetchDriverData>(_onfetchDriverData);
    on<BookRideEvent>(_onBookRide);
    on<FetchRideDetails>(_onfetchRideData);
  }

  void _onfetchUserData(
    FetchUserData event,
    Emitter<FetchDataState> emit,
  ) async {
    try {
      final UserModel user = await fetchUserDataService.fetchUserData();
      emit(FetchUserDataSuccess(userModel: user));
    } catch (e) {
      emit(FetchDataFailure(error: e.toString()));
    }
  }

  void _onfetchDriverData(
    FetchDriverData event,
    Emitter<FetchDataState> emit,
  ) async {
    try {
      final List<DriverModel> drivers =
          await fetchUserDataService.fetchDriverData();
      emit(FetchDriverDataSuccess(drivers: drivers));
    } catch (e) {
      emit(FetchDataFailure(error: e.toString()));
    }
  }

  void _onBookRide(
    BookRideEvent event,
    Emitter<FetchDataState> emit,
  ) async {
    try {
      await fetchUserDataService.bookRide(event.booking);
      emit(BookRideSuccess());
    } catch (e) {
      emit(FetchDataFailure(error: e.toString()));
    }
  }

  void _onfetchRideData(
    FetchRideDetails event,
    Emitter<FetchDataState> emit,
  ) async {
    try {
      final bookings = await fetchUserDataService.getBookingData();
      emit(FetchRideSuccess(bookings));
    } catch (e) {
      emit(FetchDataFailure(error: e.toString()));
    }
  }
}
