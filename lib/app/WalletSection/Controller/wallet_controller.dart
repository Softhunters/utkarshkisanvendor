import 'package:flutter/material.dart';

class WalletController extends ChangeNotifier{
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode ="";
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;

  GlobalKey<FormState> formKey=GlobalKey<FormState>();

}