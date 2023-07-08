import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:train_seat_finder/app_models/app_enums.dart';
import 'package:train_seat_finder/app_models/seat_model.dart';
import 'package:train_seat_finder/app_screens/train_block/cubit/train_block_cubit.dart';

class TrainSeatWidget extends StatelessWidget {
  final TrainSeatModel seat;
  final bool isUpper;
  const TrainSeatWidget({
    Key? key,
    required this.seat,
    this.isUpper = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isPresentInUserSeatList =
        context.read<TrainBlockCubit>().ifSeatIsUserSeat(seat.seatNo);
    return BlocBuilder<TrainBlockCubit, TrainBlockState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<TrainBlockCubit>().removeSeatFromUserSeatsList(seat);
          },
          child: Container(
            width: (size.width - 10) / 7,
            height: (size.width - 10) / 7,
            color: isPresentInUserSeatList
                ? Colors.lightBlueAccent
                : Colors.lightBlueAccent.withOpacity(0.3),
            child: isUpper
                ? upperBerth(isPresentInUserSeatList)
                : lowerBerth(isPresentInUserSeatList),
          ),
        );
      },
    );
  }

  Widget upperBerth(bool isPresentInUserSeatList) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Center(
          child: Text(
            seat.seatNo.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
              color: isPresentInUserSeatList ? Colors.white : Colors.blue,
            ),
          ),
        ),
        Text(
          seatTypeString(seat.seatName),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 10,
            color: isPresentInUserSeatList ? Colors.white : Colors.blue,
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget lowerBerth(bool isPresentInUserSeatList) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Text(
          seatTypeString(seat.seatName),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 10,
            color: isPresentInUserSeatList ? Colors.white : Colors.blue,
          ),
        ),
        Center(
          child: Text(
            seat.seatNo.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
              color: isPresentInUserSeatList ? Colors.white : Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
