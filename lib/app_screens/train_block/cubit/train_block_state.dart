part of 'train_block_cubit.dart';

class TrainBlockState extends Equatable {
  final LoadState loadState;
  final List<TrainSeatModel>? userSeats;
  final List<TrainSeatModel>? seats;

  const TrainBlockState({
    this.loadState = LoadState.initial,
    this.userSeats,
    this.seats,
  });

  TrainBlockState copyWith(
      {LoadState? loadState,
      List<TrainSeatModel>? userSeats,
      List<TrainSeatModel>? seats}) {
    return TrainBlockState(
      loadState: loadState ?? this.loadState,
      userSeats: userSeats ?? this.userSeats,
      seats: seats ?? this.seats,
    );
  }

  @override
  List<Object?> get props => [
        loadState,
        userSeats,
        seats,
      ];
}
