
 import 'package:e_commerce/app/Wallet/Controller/api.dart';
import 'package:flutter/cupertino.dart';

import '../Model/wallet_model.dart';

class WalletsController extends ChangeNotifier{
  WalletApi walletApi= WalletApi();
  int segmentedControlGroupValue = 0;


  setsegmentValu(value){
    segmentedControlGroupValue = value;
    notifyListeners();
  }

  bool walletLoading = false;

  int totalWallet = 0;
  int totalReward = 0;
  List<WalletHistory> walletHistory = [];
  List<RewardHistory> rewardHistory = [];


  getWalletData(type) async{
    if(type==0) {
      walletLoading = true;
    }
    final result= await walletApi.getWalletHistory();
    if(result != null){
      totalWallet = result.result?.twallet ?? 0;
      totalReward = result.result?.treward ?? 0;
      walletHistory = result.result?.wallethistory ?? [];
      rewardHistory = result.result?.rewardhistory ?? [];

      walletLoading =false;
      notifyListeners();
    }
  }
}