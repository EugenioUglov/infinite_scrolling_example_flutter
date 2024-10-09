import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:infinite_scrolling_example_flutter/app/state.dart';
import 'package:provider/provider.dart';

class InfiniteScrollList extends StatefulWidget {
  const InfiniteScrollList({super.key});

  @override
  State<InfiniteScrollList> createState() => _InfiniteScrollListState();
}

class _InfiniteScrollListState extends State<InfiniteScrollList> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void scrollListener() {
    final appState = Provider.of<AppState>(context, listen: false);
    final maxVerticalScrollBound = _controller.position.maxScrollExtent;
    final triggerPoint = maxVerticalScrollBound * 70 / 100;
    final currentScrollOffset = _controller.offset;
    if (currentScrollOffset > 0.0 && !appState.showFab) {
      appState.showFabButton(true);
    }

    if (currentScrollOffset == 0.0 && appState.showFab) {
      appState.showFabButton(false);
    }

    if (currentScrollOffset > triggerPoint && !appState.isLoading) {
      log('Triggered');
      appState.appendList();
    }
  }

  bool isControllerAtTop() {
    return _controller.offset > 0.0;
  }

  void scrollToTop() => _controller.animateTo(0.0,
      duration: const Duration(milliseconds: 300), curve: Curves.bounceInOut);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Consumer<AppState>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Infinite Scrolling List'),
              centerTitle: true,
            ),
            floatingActionButton: value.showFab
                ? FloatingActionButton(
                    onPressed: scrollToTop,
                    child: const Icon(Icons.arrow_circle_up_rounded),
                  )
                : null,
            body: ListView.builder(
              controller: _controller,
              shrinkWrap: true,
              itemCount: value.intList.length + (value.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == value.intList.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final element = value.intList[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 3.0,
                          spreadRadius: 3.0,
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text("Element No $element"),
                      subtitle: Text("Is Even => ${element.isEven}"),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
