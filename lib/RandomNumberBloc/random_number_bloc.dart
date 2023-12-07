import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:kjbnlabs/RandomNumberBloc/repository.dart';
 

part 'random_number_event.dart';
part 'random_number_state.dart';

class RandomNumberBloc extends Bloc<RandomNumberEvent, RandomNumberState> {
  final RandomNumberRepository _repository;

  int successCount = 0; 

  RandomNumberBloc(this._repository) : super(RandomNumberInitial()) {
    on<GenerateRandomNumber>(_onGenerateRandomNumber);
  }

  void _onGenerateRandomNumber(GenerateRandomNumber event, Emitter<RandomNumberState> emit) async {
    int randomNumber = Random().nextInt(60);

    int currentSecond = DateTime.now().second;

    if (randomNumber == currentSecond) {
      int newSuccessCount = await _repository.incrementSuccessCount();
      emit(RandomNumberSuccess(randomNumber: randomNumber, successCount: newSuccessCount));
    } else {
      emit(RandomNumberFailure(randomNumber: randomNumber));
    }
  }
}
