import 'package:flutter/material.dart';
import 'package:infinite_scrolling_example_flutter/app/state.dart';
import 'package:infinite_scrolling_example_flutter/app/ui.dart';
import 'package:provider/provider.dart';

class InitialLoader extends StatefulWidget {
  const InitialLoader({super.key});

  @override
  State<InitialLoader> createState() => _InitialLoaderState();
}

class _InitialLoaderState extends State<InitialLoader> {
  @override
  void initState() {
    super.initState();
    startUpLogic();
  }

  void startUpLogic() async {
    await Provider.of<AppState>(context, listen: false).loadInitialData();
    if (mounted) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InfiniteScrollList(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
