import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kjbnlabs/RandomNumberBloc/random_number_bloc.dart';
import 'package:kjbnlabs/RandomNumberBloc/repository.dart';
 
import 'package:kjbnlabs/screens/homepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amberAccent),
      ),
      home: RepositoryProvider(
        create: (context) => RandomNumberRepository(),
        child: BlocProvider(
          create: (context) => RandomNumberBloc(
            RepositoryProvider.of<RandomNumberRepository>(context),
          ),
          child: const MyHomePage(),
        ),
      ),
    );
  }
}
