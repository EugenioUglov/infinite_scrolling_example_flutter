import 'package:flutter/material.dart';
import 'package:infinite_scrolling_example_flutter/app/api.dart';

class AppState with ChangeNotifier {
  final int pageSize = 20;
  int pageNumber = 1;
  List<int> intList = [];
  bool isLoading = false;
  bool showFab = false;

  void _addToList(List<int> list) {
    intList.addAll(list);
  }

  void _notifyListeners() {
    notifyListeners();
  }

  void _isLoading(bool loadingState) {
    isLoading = loadingState;
  }

  void _appendPageNumber() {
    pageNumber = pageNumber + 1;
  }

  Future<bool> loadInitialData() async {
    intList.clear();
    final list = await API.getCount(pageSize: pageSize, pageNumber: pageNumber);
    intList = list;
    _appendPageNumber();
    return true;
  }

  void appendList() async {
    _isLoading(true);
    _notifyListeners();
    final list = await API.getCount(pageSize: pageSize, pageNumber: pageNumber);
    _appendPageNumber();
    _addToList(list);
    _isLoading(false);
    _notifyListeners();
  }

  void showFabButton(bool state) {
    showFab = state;
    _notifyListeners();
  }
}
