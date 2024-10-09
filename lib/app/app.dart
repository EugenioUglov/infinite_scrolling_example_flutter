import 'package:flutter/material.dart';
import 'package:infinite_scrolling_example_flutter/app/initial_loader.dart';
import 'package:infinite_scrolling_example_flutter/app/state.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  App({super.key});

  final AppState _appState = AppState();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _appState),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Infinite Scroll List',
        home: InitialLoader(),
      ),
    );
  }
}
