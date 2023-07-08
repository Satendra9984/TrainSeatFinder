import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:train_seat_finder/app_screens/train_block/cubit/train_block_cubit.dart';
import 'package:train_seat_finder/app_screens/train_block/widgets/seat_widget.dart';

class TrainBlockWidget extends StatelessWidget {
  final int blockNo;

  const TrainBlockWidget({
    Key? key,
    required this.blockNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<TrainBlockCubit, TrainBlockState>(
      builder: (context, state) {
        return Column(
          children: [
            /// UPPER ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  //A THICK TOP BORDER
                  decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: Colors.lightBlueAccent, width: 6)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // MAKE a container of rectangle shape for the border with height of seat widget height /2
                      Container(
                        width: 6,
                        height: ((size.width - 20) / 14),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25)),
                          color: Colors.lightBlueAccent,
                        ),
                      ),

                      // TODO: THREE SEATS WIDGET
                      TrainSeatWidget(
                          seat: state.seats![blockNo * 8 + 0], isUpper: true),
                      TrainSeatWidget(
                          seat: state.seats![blockNo * 8 + 1], isUpper: true),
                      TrainSeatWidget(
                          seat: state.seats![blockNo * 8 + 2], isUpper: true),
                      // MAKE a container of rectangle shape for the border with height of seat widget height /2
                      Container(
                        width: 6,
                        height: ((size.width - 20) / 14),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25)),
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ],
                  ),
                ),

                // ADD TWO EMPTY SEAT FOR PLACEHOLDER width seatwidth * 2

                Container(
                  //A THICK TOP BORDER
                  decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: Colors.lightBlueAccent, width: 6)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // MAKE a container of rectangle shape for the border with height of seat widget height /2
                      Container(
                        width: 6,
                        height: ((size.width - 20) / 14),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25)),
                          color: Colors.lightBlueAccent,
                        ),
                      ),

                      // TODO: THREE SEATS WIDGET
                      TrainSeatWidget(
                          seat: state.seats![blockNo * 8 + 6], isUpper: true),

                      // MAKE a container of rectangle shape for the border with height of seat widget height /2
                      Container(
                        width: 6,
                        height: ((size.width - 20) / 14),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25)),
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// Lower berth inverted upper berth
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  //A THICK TOP BORDER
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.lightBlueAccent, width: 6)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // MAKE a container of rectangle shape for the border with height of seat widget height /2
                      Container(
                        width: 6,
                        height: ((size.width - 20) / 14),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25)),
                          color: Colors.lightBlueAccent,
                        ),
                      ),

                      // THREE SEATS WIDGET
                      TrainSeatWidget(
                          seat: state.seats![blockNo * 8 + 3], isUpper: false),
                      TrainSeatWidget(
                          seat: state.seats![blockNo * 8 + 4], isUpper: false),
                      TrainSeatWidget(
                          seat: state.seats![blockNo * 8 + 5], isUpper: false),
                      // MAKE a container of rectangle shape for the border with height of seat widget height /2
                      Container(
                        width: 6,
                        height: ((size.width - 20) / 14),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25)),
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ],
                  ),
                ),

                // ADD TWO EMPTY SEAT FOR PLACEHOLDER width seatwidth * 2
                Container(
                  //A THICK TOP BORDER
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.lightBlueAccent, width: 6)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // MAKE a container of rectangle shape for the border with height of seat widget height /2
                      Container(
                        width: 6,
                        height: ((size.width - 20) / 14),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25)),
                          color: Colors.lightBlueAccent,
                        ),
                      ),

                      // SEAT NO 8 WIDGET
                      TrainSeatWidget(
                          seat: state.seats![blockNo * 8 + 7], isUpper: false),

                      // MAKE a container of rectangle shape for the border with height of seat widget height /2
                      Container(
                        width: 6,
                        height: ((size.width - 20) / 14),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25)),
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
