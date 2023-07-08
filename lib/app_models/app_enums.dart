enum LoadState {
  initial,
  loading,
  loaded,
  errorLoading,
}

enum SeatType {
  lower,
  middle,
  upper,
  sideLower,
  sideUpper,
}

String seatTypeString(SeatType seatType) {
  if (seatType == SeatType.lower) {
    return 'Lower';
  } else if (seatType == SeatType.middle) {
    return 'Middle';
  } else if (seatType == SeatType.upper) {
    return 'Upper';
  } else if (seatType == SeatType.sideLower) {
    return 'SideLower';
  } else if (seatType == SeatType.sideUpper) {
    return 'SideUpper';
  }

  return '';
}
