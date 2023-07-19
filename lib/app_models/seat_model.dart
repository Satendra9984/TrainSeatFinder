import 'package:train_seat_finder/app_models/app_enums.dart';

class TrainSeatModel {
  final int seatNo;
  final SeatType seatName;
  TrainSeatModel(this.seatNo, this.seatName);
}

class TrainBlockModel {
  final int blockNo;
  final List<TrainSeatModel> seatList;

  TrainBlockModel(
    this.blockNo,
    this.seatList,
  );
}
