import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kjbnlabs/RandomNumberBloc/random_number_bloc.dart';
import 'package:kjbnlabs/widgets/dailog_box.dart';
import 'package:lottie/lottie.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  void startAnimation() {
    if (!_controller.isAnimating) {
      _controller
        ..reset()
        ..forward();
    }
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.stop();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.3;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade700,
        title: const Text("Coin Master"),
        centerTitle: true,
        elevation: 5,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            BlocBuilder<RandomNumberBloc, RandomNumberState>(
              builder: (context, state) {
                if (state is RandomNumberInitial) {
                  return Column(
                    children: [
                      SizedBox(
                        height: height,
                        child: Image.asset('assets/images/closedbox.png'),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                            text: 'Tap the coin ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold, 
                              decorationThickness: 2.0, 
                              fontSize: 22.0, 
                              color: Colors.black, 
                            ),
                            children: [
                              TextSpan(
                                  text: '\nTo Begin Your Coin Collecting Adventure!',
                                  style: TextStyle(fontSize: 16))
                            ]),
                      ),
                    ],
                  );
                } else if (state is RandomNumberSuccess) {
                  showSuccessDialog(context, state.successCount);
                  return Column(
                    children: [
                      SizedBox(
                        height: height,
                        child: Image.asset('assets/images/opendbox.png'),
                      ),
                      Text.rich(
                        TextSpan(
                          text: 'You have  ',
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 24,
                            color: Colors.black, 
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${state.successCount}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 32,
                                color: Colors.amber, 
                              ),
                            ),
                            const TextSpan(
                              text: '  coins',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 24,
                                color: Colors.black, 
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      SizedBox(
                          height: height, child: Image.asset('assets/images/closedbox.png')), 
                      const Text(
                        'Try again!',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: Colors.black, 
                        ),
                      ),
                    ],
                  );
                }
              },
            ), 

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<RandomNumberBloc>(context).add(GenerateRandomNumber());
                    startAnimation();
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Lottie.asset(
                      'assets/images/coin.json',
                      height: 100,
                      width: 100,
                      controller: _controller,
                      onLoaded: (composition) {
                        _controller
                          ..duration = composition.duration
                          ..forward();
                      },
                    ),
                  ),
                ),
                BlocBuilder<RandomNumberBloc, RandomNumberState>(
                  builder: (context, state) {
                    if (state is RandomNumberSuccess) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            text: 'Random Number ',
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 24,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${state.randomNumber}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 32,
                                  color:
                                      Colors.amber, 
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (state is RandomNumberFailure) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            text: 'Random Number ',
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 24,
                              color: Colors.black, 
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${state.randomNumber}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 32,
                                  color:
                                      Colors.amber,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ), 
              ],
            ), 
          ],
        ),
      ),
    );
  }
}
