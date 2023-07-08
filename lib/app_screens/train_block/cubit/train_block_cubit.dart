import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:train_seat_finder/app_models/app_enums.dart';
import 'package:train_seat_finder/app_services/database_service.dart';
import '../../../app_models/seat_model.dart';
part 'train_block_state.dart';

class TrainBlockCubit extends Cubit<TrainBlockState> {
  TrainBlockCubit()
      : super(const TrainBlockState(
          loadState: LoadState.initial,
          seats: [],
          userSeats: [],
        ));

  Future<void> initializeSeatsData() async {
    emit(state.copyWith(loadState: LoadState.loading));

    try {
      await DatabaseServices.getTrainBlocksOfGivenCoach('S1').then((seats) {
        emit(state.copyWith(loadState: LoadState.loaded));

        if (seats.isEmpty) {
          return;
        }

        emit(state.copyWith(seats: seats));
      });
    } catch (e) {
      emit(state.copyWith(loadState: LoadState.errorLoading));
    }
  }

  int findTheUserSeat(int seatNo) {
    try {
      List<TrainSeatModel> userSeats = [...?state.userSeats];
      TrainSeatModel seat =
          state.seats!.firstWhere((element) => element.seatNo == seatNo);
      userSeats.add(seat);
      emit(state.copyWith(userSeats: userSeats));
      return seat.seatNo ~/ 8;
    } catch (e) {
      return -1;
    }
  }

  void removeSeatFromUserSeatsList(TrainSeatModel seatModel) {
    List<TrainSeatModel> userSeats = [...?state.userSeats];
    userSeats.remove(seatModel);
    emit(state.copyWith(userSeats: userSeats));
  }

  void resetSeatFromUserSeatsList() {
    emit(state.copyWith(userSeats: []));
  }

  bool ifSeatIsUserSeat(int index) {
    int present =
        state.userSeats!.indexWhere((element) => element.seatNo == index);

    return present >= 0 ? true : false;
  }
}
