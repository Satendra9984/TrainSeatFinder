import 'package:flutter/cupertino.dart';
import 'package:train_seat_finder/app_models/app_enums.dart';

import '../app_models/seat_model.dart';

class DatabaseServices {
  static Future<List<TrainSeatModel>> getTrainBlocksOfGivenCoach(
      String coachId) async {
    List<TrainSeatModel> list = [];

    for (int i = 0; i < 10; i++) {
      for (int j = 1; j <= 8; j++) {
        late TrainSeatModel seatModel;
        if (j == 1 || j == 4) {
          seatModel = TrainSeatModel(i * 8 + j, SeatType.lower);
        } else if (j == 2 || j == 5) {
          seatModel = TrainSeatModel(i * 8 + j, SeatType.middle);
        } else if (j == 3 || j == 6) {
          seatModel = TrainSeatModel(i * 8 + j, SeatType.upper);
        } else if (j == 7) {
          seatModel = TrainSeatModel(i * 8 + j, SeatType.sideLower);
        } else if (j == 8) {
          seatModel = TrainSeatModel(i * 8 + j, SeatType.sideUpper);
        }
        // debugPrint('seatno: ${seatModel.seatNo}');
        list.add(seatModel);
      }
    }

    return list;
  }
}
