import 'package:train_seat_finder/app_models/app_enums.dart';

class TrainSeatModel {
  late final int _seatNo;
  late final SeatType _seatName;
  TrainSeatModel(this._seatNo, this._seatName);

  int get seatNo => _seatNo;
  SeatType get seatName => _seatName;
}

class TrainBlockModel {
  late final int _blockNo;
  late final List<TrainSeatModel> _seatList;

  TrainBlockModel(
    this._blockNo,
    this._seatList,
  );

  int get seatNo => _blockNo;
  List<TrainSeatModel> get seatList => _seatList;
}
