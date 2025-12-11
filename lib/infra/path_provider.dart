import 'dart:convert';
import 'dart:io';

import 'package:good_hamburger/models/entities/order.dart';
import 'package:good_hamburger/models/shared/custom_exception.dart';
import 'package:path_provider/path_provider.dart';

class PathProvider {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/order_list.json');
  }

  Future<void> writeOrder(Order order) async {
    try {
      final prevList = await getOrderList();
      prevList.add(order);

      File file = await _localFile;
      String jsonOrder = jsonEncode(prevList);
      await file.writeAsString(jsonOrder, mode: FileMode.writeOnly);
    } catch (e) {
      throw CustomException(CustomExceptionType.readFromFile.message);
    }
  }

  Future<List<Order>> getOrderList() async {
    try {
      File file = await _localFile;
      bool fileExist = await file.exists();

      if (!fileExist) return [];

      String jsonString = await file.readAsString();
      List<dynamic> orderMap = jsonDecode(jsonString);
      List<Order> list = orderMap.map((d) => Order.fromJson(d)).toList();
      return list;
    } catch (e) {
      throw CustomException(CustomExceptionType.writeToFile.message);
    }
  }
}
