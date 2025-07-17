
import 'dart:convert';

import 'package:utkrashvendor/app/Wallet/Model/wallet_model.dart';
import 'package:http/http.dart';

import '../../../common_widgets/urls.dart';
import '../../../config/shared_prif.dart';

class WalletApi {


  Future<WalletModel?> getWalletHistory() async {
    String  token =  SharedStorage.localStorage?.getString("token") ??"";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse(walletURL),headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = WalletModel.fromJson(parseData);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }
}