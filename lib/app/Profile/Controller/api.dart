
import 'dart:convert';

import 'package:e_commerce/common_widgets/snack_bar.dart';
import 'package:e_commerce/config/shared_prif.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../../common_widgets/urls.dart';
import '../View/add_address_screen.dart';
import '../model/all_address_model.dart';
import '../model/contact_us_model.dart';
import '../model/country_model.dart';

class ProfileApi{
  
  
  Future<AllAddressModel?> getAddress()async{

    String  token =  SharedStorage.localStorage?.getString("token") ??"";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
print(token);

    try {
      final response = await get(Uri.parse(getAddressURL),headers: headers);

      final parseData = jsonDecode(response.body);
   print(response.statusCode);
      if (response.statusCode == 200) {
        var data = AllAddressModel.fromJson(parseData);
        return data;
      } else {
        return null;
      }

    } on Exception catch (e) {
      // TODO
    }
  }

  Future<ContactUsModel?> getContactDetail()async{

    String  token =  SharedStorage.localStorage?.getString("token") ??"";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    print(token);

    try {
      final response = await get(Uri.parse(getContactURL),headers: headers);

      final parseData = jsonDecode(response.body);
   print(response.statusCode);
      if (response.statusCode == 200) {
        var data = ContactUsModel.fromJson(parseData);
        return data;
      } else {
        return null;
      }

    } on Exception catch (e) {
      // TODO
    }
  }


  Future<bool?> logout()async{

    String  token =  SharedStorage.localStorage?.getString("token") ??"";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await get(Uri.parse(logoutURL),headers: headers);

      final parseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var data = parseData;
        showSnackBar(snackPosition: SnackPosition.TOP,
        title: "Success",
          description: data["message"]
        );
        return true;
      } else {
        return false;
      }

    } on Exception catch (e) {
      // TODO
    }
  }

  addAndEditAddress(AddressModel data)async{

    String  token =  SharedStorage.localStorage?.getString("token") ??"";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var body = {
      'id':data.id,
      'name': data.name,
      'mobile': data.mobile,
      'mobile_optional': data.optionalMobile,
      'line1': data.street,
      'line2': data.street2,
      'landmark': data.landmark,
      'country_id': data.country,
      'state_id': data.state,
      'city_id': data.city,
      'zipcode': data.zip,
      'address_type': data.addressType,
      'default_address': data.isDefaultAddress.toString()
    };

    try {
      final response = await post(Uri.parse(saveAddressURL),body: body,headers: headers,);

      print(response.statusCode);
      final parseData = jsonDecode(response.body);

      print(parseData);
      if (parseData["status"] !=false ) {
        showSnackBar(snackPosition: SnackPosition.TOP,
            title: "Success",
            description: parseData["msg"]);
        return true;
      } else {
        showSnackBar(snackPosition: SnackPosition.TOP,
            title: "Success",
            description: parseData["msg"]);
        return false;
      }

    } on Exception catch (e) {
      // TODO
    }
  }

  deleteAddress(String id)async{

    String  token =  SharedStorage.localStorage?.getString("token") ??"";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await get(Uri.parse(deleteAddressURL+id),headers: headers,);

      print(response.statusCode);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        showSnackBar(snackPosition: SnackPosition.TOP,
            title: "Success",
            description: parseData["msg"]);
        return true;
      } else {
        return false;
      }

    } on Exception catch (e) {
      // TODO
    }
  }

  // default-address/{id}/{status}
  defaultAddress(String id,String status)async{

    String  token =  SharedStorage.localStorage?.getString("token") ??"";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await get(Uri.parse("${defaultAddressURL+id}/$status"),headers: headers,);

      print(response.statusCode);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        showSnackBar(snackPosition: SnackPosition.TOP,
            title: "Success",
            description: parseData["msg"]);
        return true;
      } else {
        return false;
      }

    } on Exception catch (e) {
      // TODO
    }
  }


  Future<CountryModel?> getCountryList()async{

    String  token =  SharedStorage.localStorage?.getString("token") ??"";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse(getCountryURL),headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = CountryModel.fromJson(parseData);
        return data;
      } else {
        return null;
      }

    } on Exception catch (e) {
      // TODO
    }
  }

  Future<StateModel?> getState(String id)async{

    String  token =  SharedStorage.localStorage?.getString("token") ??"";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse(getStateURL+id),headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = StateModel.fromJson(parseData);
        return data;
      } else {
        return null;
      }

    } on Exception catch (e) {
      // TODO
    }
  }

  Future<DistrictModel?> getDistrict(String id)async{

    String  token =  SharedStorage.localStorage?.getString("token") ??"";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse(getcityURL+id),headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = DistrictModel.fromJson(parseData);
        return data;
      } else {
        return null;
      }

    } on Exception catch (e) {
      // TODO
    }
  }

}