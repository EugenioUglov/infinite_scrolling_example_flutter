import 'dart:developer';

class API {
  /// Mock API which takes `pageSize` and `pageNumber` to return list of numbers
  static Future<List<int>> getCount(
      {required int pageSize, required int pageNumber}) async {
    log("=======API Called======");
    log("=======PageNumber $pageNumber======");
    List<int> returnList = [];
    for (int i = ((pageNumber * pageSize) - pageSize);
        i < pageNumber * pageSize;
        i++) {
      returnList.add(i + 1);
    }
    //Change this to make fast or slow
    await Future.delayed(const Duration(seconds: 2));
    return returnList;
  }
}
