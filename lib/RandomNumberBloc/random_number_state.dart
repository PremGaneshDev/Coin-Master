part of 'random_number_bloc.dart';

abstract class RandomNumberState {}

class RandomNumberInitial extends RandomNumberState {}

class RandomNumberSuccess extends RandomNumberState {
  final int randomNumber;
  final int successCount;
  RandomNumberSuccess({required this.randomNumber, required this.successCount});
}

class RandomNumberFailure extends RandomNumberState {
  final int randomNumber;
  RandomNumberFailure({
    required this.randomNumber,
  });
}
