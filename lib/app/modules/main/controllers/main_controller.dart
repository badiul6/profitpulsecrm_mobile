import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/views/campaign_create_view.dart';

class MainController extends GetxController {
 
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController campaignController= TextEditingController();
  final GlobalKey<FormState> campaignFormKey = GlobalKey<FormState>();


  Future<void> showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return CampaignCreateView();
    },
  );
}
String? validatecampaign(String? name) {
      if (name == null || name.isEmpty) {
        return "Name can't be empty";
      }
      return null;
    }
  
  @override
  void onClose() {
    super.onClose();
  }

}
