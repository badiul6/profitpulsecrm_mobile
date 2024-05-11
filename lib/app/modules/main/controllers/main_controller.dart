import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/data/agent_deal_response.dart';
import 'package:profitpulsecrm_mobile/app/data/agent_response.dart';
import 'package:profitpulsecrm_mobile/app/data/agent_ticket_response.dart';
import 'package:profitpulsecrm_mobile/app/data/campaign_response.dart';
import 'package:profitpulsecrm_mobile/app/data/contact_response.dart';
import 'package:profitpulsecrm_mobile/app/data/deal_response.dart';
import 'package:profitpulsecrm_mobile/app/data/fb_campaign_response.dart';
import 'package:profitpulsecrm_mobile/app/data/product_response.dart';
import 'package:profitpulsecrm_mobile/app/data/profile_response.dart';
import 'package:profitpulsecrm_mobile/app/data/sales_agent_response.dart';
import 'package:profitpulsecrm_mobile/app/data/ticket_response.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/views/campaign_create_view.dart';
import 'package:http/http.dart' as http;
import 'package:profitpulsecrm_mobile/app/routes/app_pages.dart';
import 'package:profitpulsecrm_mobile/app/views/snackbar_view.dart';

class MainController extends GetxController {
  TextEditingController campaignController = TextEditingController();
  final serverUrl = dotenv.env['SERVERURL'];

  final storage = const FlutterSecureStorage();
  String? cookie;
  RxBool sessionExpiredHandled = false.obs;
  RxBool isError = false.obs;
  RxList<Agent> agents = <Agent>[].obs;
  RxList<Contact> contacts = <Contact>[].obs;
  RxList<Campaign> campaigns = <Campaign>[].obs;
  RxList<ProductResponse> products = <ProductResponse>[].obs;
  RxList<Deal> deals = <Deal>[].obs;
  RxList<AgentDeal> agentDeals = <AgentDeal>[].obs;
  RxList<Ticket> tickets = <Ticket>[].obs;
  RxList<AgentTicket> agentTickets = <AgentTicket>[].obs;
  RxList<SalesAgentResponse> salesAgents = <SalesAgentResponse>[].obs;
  final fbCampaign = Rx<CampaignMetrics?>(null);
  RxBool isPageLoading = false.obs;
  RxString currentMenu = 'Home'.obs;
  RxString role = ''.obs;
  RxBool isSavingCampaign= false.obs;
  final profile= Rx<Profile?>(null);

  @override
  void onInit() async {
    await getRole();
    super.onInit();
    if (role.value == "OWNER") {
      loadAllData();
    } else if (role.value == "MAGENT") {
      loadMagentData();
    } else if (role.value == "SHEAD") {
      loadSheadData();
    } else if (role.value == "SAGENT") {
      loadSagentData();
    } else if (role.value == "CSAGENT") {
      loadCSagentData();
    }
  }



  Future<void> addCampaign() async {
    try {
      isSavingCampaign.value = true;
      String? cookie = await storage.read(key: 'cookie');
      String? role = await storage.read(key: 'role');

      if (cookie == null || role == null) {
        await storage.deleteAll();
        SnackbarHelper.showCustomSnackbar(
            title: 'Error',
            message: 'Session expired. Please login again to continue',
            type: SnackbarType.error);
        Get.offAllNamed(Routes.HOME);
        isSavingCampaign.value = false;
        return;
      }
      var body = jsonEncode({
        'name': campaignController.text,
       
      });

      var response = await http.post(Uri.parse('$serverUrl/campaign/create'),
          headers: {
            "Content-Type": "application/json",
            "Cookie": cookie,
          },
          body: body);
      if (response.statusCode == 201) {
        SnackbarHelper.showCustomSnackbar(
            title: 'Success',
            message: 'Campaign successfully created',
            type: SnackbarType.success);
        campaignController.clear();
        isSavingCampaign.value = false;
        getAllCampaigns();
        return;
      } else if (response.statusCode == 409) {
        SnackbarHelper.showCustomSnackbar(
            title: 'Conflict Error',
            message: 'Campaign already exists with the same name',
            type: SnackbarType.error);
        campaignController.clear();
        isSavingCampaign.value = false;
        return;
      } else if (response.statusCode == 403) {
        await storage.deleteAll();
        SnackbarHelper.showCustomSnackbar(
            title: 'Session Expired',
            message: 'Please login to continue',
            type: SnackbarType.error);
        Get.offAllNamed(Routes.HOME);
        isSavingCampaign.value = false;
        return;
      }
      SnackbarHelper.showCustomSnackbar(
          title: 'Error',
          message: 'Try again. Some error occur',
          type: SnackbarType.error);
      isSavingCampaign.value = false;
    } catch (e) {
      SnackbarHelper.showCustomSnackbar(
          title: 'Error',
          message: 'Try again. Some error occur',
          type: SnackbarType.error);
      isSavingCampaign.value = false;
    }
  }

  

  Future<void> loadAllData() async {
    isError.value = false;
    isPageLoading.value = true;
    await getCookie();
    await Future.wait([
      getProfile(),
      getAllContacts(),
      getAllTickets(),
      getAllCompanyDeals(),
      getFbAds(),
      getAllSalesAgent(), 
      getAllProducts(),
      getAllCampaigns(),
      getAllAgents(),
    ]);
    isPageLoading.value = false;
  }

  Future<void> loadSheadData() async {
    isError.value = false;
    isPageLoading.value = true;
    await getCookie();
    await Future.wait([
      getProfile(),
      getAllContacts(),
      getAllCompanyDeals(),
      getAllProducts(),
      getAllCampaigns(),
      getAllSalesAgent(), 
    ]);
    isPageLoading.value = false;
  }

  Future<void> loadSagentData() async {
    isError.value = false;
    isPageLoading.value = true;
    await getCookie();
    await Future.wait([
      getProfile(),
      getAllProducts(),
      getAllContacts(),
      getAgentDeals()
    ]);
    isPageLoading.value = false;
  }

  Future<void> loadMagentData() async {
    isError.value = false;
    isPageLoading.value = true;
    await getCookie();
    await Future.wait([
      getFbAds(),
      getProfile(),
      getAllCampaigns(),
      getAllContacts(),
    ]);
    isPageLoading.value = false;
  }

  Future<void> loadCSagentData() async {
    isError.value = false;
    isPageLoading.value = true;
    await getCookie();
    await Future.wait([
      getProfile(),
      getAllProducts(),
      getAllContacts(),
      getAgentTickets()
    ]);
    isPageLoading.value = false;
  }

  void setCurrentMenu(String menu) {
    currentMenu.value = menu;
  }

  Future<void> getProfile() async {
    try {
      var response =
          await http.get(Uri.parse('$serverUrl/profile/viewprofile'), headers: {
        "Content-Type": "application/json",
        "Cookie": cookie!,
      });
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        profile.value= Profile.fromJson(parsed);
      } else if (response.statusCode == 403) {
        handleSessionExpired();
      } else {
        isError.value = true;
      }
    } catch (e) {
      isError.value = true;
    }
  }

  Future<void> getAgentTickets() async {
    try {
      var response =
          await http.get(Uri.parse('$serverUrl/ticket/get'), headers: {
        "Content-Type": "application/json",
        "Cookie": cookie!,
      });
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        agentTickets.value =
            List<AgentTicket>.from(parsed['data'].map((x) => AgentTicket.fromJson(x)));

      } else if (response.statusCode == 403) {
        handleSessionExpired();
      } else {
        isError.value = true;
      }
    } catch (e) {
      isError.value = true;
    }
  }

  Future<void> getAgentDeals() async {
    try {
      var response = await http.get(
        Uri.parse(
          '$serverUrl/deal/get-deals',
        ),
        headers: {
          "Content-Type": "application/json",
          "Cookie": cookie!, // Include the cookie here
        },
      );
      if (response.statusCode == 200) {
      
        final parsed = json.decode(response.body);
        agentDeals.value =
            List<AgentDeal>.from(parsed['data'].map((x) => AgentDeal.fromJson(x)));
        
      } else if (response.statusCode == 403) {
        handleSessionExpired();
      } else {
        isError.value = true;
      }
    } catch (e) {
      isError.value = true;
    }
  }

  Future<void> getAllTickets() async {
    try {
      var response =
          await http.get(Uri.parse('$serverUrl/ticket/get-all'), headers: {
        "Content-Type": "application/json",
        "Cookie": cookie!,
      });
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        tickets.value =
            List<Ticket>.from(parsed['data'].map((x) => Ticket.fromJson(x)));
      } else if (response.statusCode == 403) {
        handleSessionExpired();
      } else {
        isError.value = true;
      }
    } catch (e) {
      isError.value = true;
    }
  }

  Future<void> getAllCompanyDeals() async {
    try {
      var response = await http.get(Uri.parse('$serverUrl/deal/get'), headers: {
        "Content-Type": "application/json",
        "Cookie": cookie!,
      });
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        deals.value =
            List<Deal>.from(parsed['data'].map((x) => Deal.fromJson(x)));
      } else if (response.statusCode == 403) {
        handleSessionExpired();
      } else {
        isError.value = true;
      }
    } catch (e) {
      isError.value = true;
    }
  }

  Future<void> getFbAds() async {
    try {
      var response = await http.get(Uri.parse('$serverUrl/facebook'), headers: {
        "Content-Type": "application/json",
        "Cookie": cookie!,
      });
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        fbCampaign.value = CampaignMetrics.fromJson(parsed['overall_stats']);
      } else if (response.statusCode == 403) {
        handleSessionExpired();
      } else if (response.statusCode == 404) {
      } else {
        isError.value = true;
      }
    } catch (e) {
      isError.value = true;
    }
  }

  Future<void> getAllProducts() async {
    try {
      var response =
          await http.get(Uri.parse('$serverUrl/product/get'), headers: {
        "Content-Type": "application/json",
        "Cookie": cookie!,
      });
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        products.value = List<ProductResponse>.from(
            parsed['products'].map((model) => ProductResponse.fromJson(model)));
      } else if (response.statusCode == 403) {
        handleSessionExpired();
      } else {
        isError.value = true;
      }
    } catch (e) {
      isError.value = true;
    }
  }

  Future<void> getAllCampaigns() async {
    try {
      var response =
          await http.get(Uri.parse('$serverUrl/campaign/get-all'), headers: {
        "Content-Type": "application/json",
        "Cookie": cookie!,
      });
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        campaigns.value = List<Campaign>.from(
            parsed['campaigns'].map((model) => Campaign.fromJson(model)));
      } else if (response.statusCode == 403) {
        handleSessionExpired();
      } else {
        isError.value = true;
      }
    } catch (e) {
      isError.value = true;
    }
  }

  Future<void> getAllContacts() async {
    try {
      var response =
          await http.get(Uri.parse('$serverUrl/contact/get-all'), headers: {
        "Content-Type": "application/json",
        "Cookie": cookie!,
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        contacts.value = List<Contact>.from(
            jsonData['data'].map((model) => Contact.fromJson(model)));
      } else if (response.statusCode == 403) {
        handleSessionExpired();
      } else {
        isError.value = true;
      }
    } catch (e) {
      isError.value = true;
    }
  }
  
  Future<void> getAllSalesAgent() async {
    try {
      var response = await http.get(
        Uri.parse(
          '$serverUrl/deal/get-agents',
        ),
        headers: {
          "Content-Type": "application/json",
          "Cookie": cookie!, // Include the cookie here
        },
      );
      if (response.statusCode == 200) {

        final decodedJson = jsonDecode(response.body);
        salesAgents.value = List<SalesAgentResponse>.from(decodedJson['data']
            .map((userJson) => SalesAgentResponse.fromJson(userJson)));
      } else if (response.statusCode == 403) {
        handleSessionExpired();
      } else {
        isError.value = true;
      }
    } catch (e) {
      isError.value = true;
    }
  }

  

  Future<void> getAllAgents() async {
    try {
      var response = await http.get(
        Uri.parse(
          '$serverUrl/profile/viewusers',
        ),
        headers: {
          "Content-Type": "application/json",
          "Cookie": cookie!, // Include the cookie here
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> decodedJson = jsonDecode(response.body);
        agents.value =
            decodedJson.map((agentJson) => Agent.fromJson(agentJson)).toList();
      } else if (response.statusCode == 403) {
        handleSessionExpired();
      } else {
        isError.value = true;
      }
    } catch (e) {
      isError.value = true;
    }
  }

  Future<void> handleSessionExpired() async {
    if (!sessionExpiredHandled.value) {
      sessionExpiredHandled.value = true;

      await storage.deleteAll(); // Delete the session cookie and role

      SnackbarHelper.showCustomSnackbar(
          title: 'Session Expired',
          message: 'Please log in again to continue',
          type: SnackbarType.error);
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  Future<void> getCookie() async {
    cookie = await storage.read(key: "cookie");
    if (cookie == null) {
      Get.offAllNamed(Routes.LOGIN);
      SnackbarHelper.showCustomSnackbar(
          title: 'Session Expired',
          message: 'Please login to continue',
          type: SnackbarType.error);
    }
  }

  Future<void> logout() async {
    await storage.deleteAll();
    Get.offAllNamed(Routes.HOME);
  }

  Future<void> getRole() async {
    role.value = (await storage.read(key: "role"))!;
  }

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
    campaignController.dispose();
  }
}
