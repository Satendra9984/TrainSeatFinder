import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:train_seat_finder/app_models/app_enums.dart';
import 'package:train_seat_finder/app_screens/train_block/cubit/train_block_cubit.dart';

import '../widgets/train_block_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final TextEditingController _textEditingController;
  final GlobalKey _formKey = GlobalKey<FormState>();
  late final ScrollController _scrollController;
  @override
  void initState() {
    _textEditingController = TextEditingController();
    _scrollController = ScrollController();
    context.read<TrainBlockCubit>().initializeSeatsData();
    super.initState();
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        debugPrint("reach the bottom");
      });
    }
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        debugPrint("reach the top");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<TrainBlockCubit, TrainBlockState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.loadState == LoadState.initial ||
              state.loadState == LoadState.loading) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Colors.lightBlueAccent),
                SizedBox(height: 10),
                Text(
                  'Loading Train Data',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: CupertinoColors.black,
                  ),
                ),
              ],
            );
          } else if (state.loadState == LoadState.errorLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    color: CupertinoColors.systemRed,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Error Loading Train Data',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: CupertinoColors.black,
                    ),
                  ),
                ],
              ),
            );
          }

          _scrollController.addListener(() => _scrollListener());

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 65),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Seat Finder',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context
                            .read<TrainBlockCubit>()
                            .resetSeatFromUserSeatsList();
                      },
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: CupertinoColors.systemRed,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                /// Find Seat Number Text-Input
                Form(
                  key: _formKey,
                  child: FormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    initialValue: _textEditingController,
                    validator: (controller) {
                      if (_textEditingController.text.isEmpty) {
                        return 'Enter Seat Number';
                      } else if (int.tryParse(_textEditingController.text) ==
                          null) {
                        return 'Invalid Seat Number';
                      }
                      return null;
                    },
                    builder: (formState) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2.5,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: TextField(
                                onChanged: (value) {
                                  _textEditingController.text = value;
                                  _textEditingController.selection =
                                      TextSelection.collapsed(
                                          offset: _textEditingController
                                              .text.length);
                                  formState.didChange(_textEditingController);
                                },
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.lightBlueAccent,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 22,
                                  color: Colors.lightBlueAccent,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'Enter Seat Number',
                                  hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.lightBlueAccent,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                    // borderSide: BorderSide(color: Colors.red),
                                  ),
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: ElevatedButton(
                                onPressed: () {
                                  // FIND SEAT
                                  int index = context
                                      .read<TrainBlockCubit>()
                                      .findTheUserSeat(int.parse(
                                          _textEditingController.text));

                                  if (index == -1) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: CupertinoColors
                                            .systemRed
                                            .withOpacity(0.75),
                                        content: const Center(
                                          child: Text(
                                            'No Seat Found',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    final itemExtent = _scrollController
                                            .position.maxScrollExtent /
                                        (state.seats!.length / 9);
                                    final offset = itemExtent * index;
                                    _scrollController.animateTo(
                                      offset,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: const EdgeInsets.all(0),
                                  fixedSize: const Size(double.infinity, 48),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7)),
                                  backgroundColor: formState.hasError
                                      ? CupertinoColors.systemGrey
                                      : Colors.lightBlueAccent,
                                ),
                                child: const Text(
                                  'Find',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 25),

                /// Display All Seats
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    shrinkWrap: true,
                    itemCount: state.seats!.length ~/ 8,
                    itemBuilder: (context, index) {
                      // debugPrint('block index: ${index}');
                      return Column(
                        children: [
                          TrainBlockWidget(blockNo: index),
                          const SizedBox(height: 1),
                        ],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void scrollDownToIndex(int index, int dataLength) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        if (maxScrollExtent == 0) {
          // Wait for the ListView to build and calculate the maxScrollExtent
          scrollDownToIndex(index, dataLength);
        } else {
          final itemExtent =
              _scrollController.position.maxScrollExtent / (dataLength - 1);
          final offset = itemExtent * index;
          _scrollController.animateTo(
            offset,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }
}
