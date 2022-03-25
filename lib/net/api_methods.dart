// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// Future<double> getPrice(String id) async {
//   try {
//     var url = 'https://api.coingecko.com/api/v3/coins/' + id;
//     var response = await http.get(Uri.parse(url));
//     var json = jsonDecode(response.body);
//     var value = json['market_data']['current_price']['gbp'].toString();
//     return double.parse(value);
//   } catch (e) {
//     if (kDebugMode) {
//       print(e.toString());
//     }
//     return 1;
//   }
// }