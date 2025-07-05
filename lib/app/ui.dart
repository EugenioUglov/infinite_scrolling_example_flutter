import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scrolling_example_flutter/app/state.dart';

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
    _controller.dispose();
    super.dispose();
  }

  void scrollListener() {
    final appState = Provider.of<AppState>(context, listen: false);
    final maxVerticalScrollBound = _controller.position.maxScrollExtent;
    final triggerPoint = maxVerticalScrollBound * 0.7;
    final currentScrollOffset = _controller.offset;

    if (currentScrollOffset > 0.0 && !appState.showFab) {
      appState.showFabButton(true);
    }

    if (currentScrollOffset == 0.0 && appState.showFab) {
      appState.showFabButton(false);
    }

    if (currentScrollOffset > triggerPoint && !appState.isLoading) {
      appState.appendList();
    }
  }

  void scrollToTop() {
    _controller.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.bounceInOut,
    );
  }

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
            body: Scrollbar(
              controller: _controller,
              interactive: true,
              child: ListView.custom(
                controller: _controller,
                physics: const ClampingScrollPhysics(),
                childrenDelegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == value.intList.length) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    final element = value.intList[index];
                    final randomSymbols = generateRandomSymbols();

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
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
                          title: Text("Element No $element $randomSymbols"),
                          subtitle: Text("Is Even => ${element.isEven}"),
                        ),
                      ),
                    );
                  },
                  childCount:
                      value.intList.length + (value.isLoading ? 1 : 0),
                  addAutomaticKeepAlives: false,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Generates a string of random symbols
/// 
/// [count] - Number of symbols to generate (optional, defaults to random between 100-10000)
/// [includeLineBreaks] - Whether to add line breaks every 80 characters (default: false)
String generateRandomSymbols({int? count, bool includeLineBreaks = false}) {
  final random = Random();
  final symbolCount = count ?? (random.nextInt(9901) + 100);

  final symbols = [
    '!', '@', '#', '%', '^', '&', '*', '(', ')', '-', '_', '=', '+',
    '[', ']', '{', '}', '|', '\\', ':', ';', '"', "'", '<', '>', ',',
    '.', '?', '/', '~', '`', '0', '1', '2', '3', '4', '5', '6', '7',
    '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K',
    'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
    'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k',
    'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x',
    'y', 'z', '☺', '☻', '♠', '♣', '♥', '♦', '♪', '♫', '☼', '►', '◄',
    '↕', '‼', '¶', '§', '▬', '↨', '↑', '↓', '→', '←', '∟', '↔', '▲', '▼'
  ];

  final buffer = StringBuffer();
  for (int i = 0; i < symbolCount; i++) {
    buffer.write(symbols[random.nextInt(symbols.length)]);
    if (includeLineBreaks && (i + 1) % 80 == 0) {
      buffer.write('\n');
    }
  }

  return buffer.toString();
}
