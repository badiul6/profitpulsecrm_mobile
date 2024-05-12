import 'package:get/get.dart';

import '../modules/addContact/bindings/add_contact_binding.dart';
import '../modules/addContact/views/add_contact_view.dart';
import '../modules/addDeal/bindings/add_deal_binding.dart';
import '../modules/addDeal/views/add_deal_view.dart';
import '../modules/addProduct/bindings/add_product_binding.dart';
import '../modules/addProduct/views/add_product_view.dart';
import '../modules/addSale/bindings/add_sale_binding.dart';
import '../modules/addSale/views/add_sale_view.dart';
import '../modules/addTicket/bindings/add_ticket_binding.dart';
import '../modules/addTicket/views/add_ticket_view.dart';
import '../modules/addUser/bindings/add_user_binding.dart';
import '../modules/addUser/views/add_user_view.dart';
import '../modules/assignAgent/bindings/assign_agent_binding.dart';
import '../modules/assignAgent/views/assign_agent_view.dart';
import '../modules/forgotPassword/bindings/forgot_password_binding.dart';
import '../modules/forgotPassword/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/searchAgentDeal/bindings/search_agent_deal_binding.dart';
import '../modules/searchAgentDeal/views/search_agent_deal_view.dart';
import '../modules/searchAgentTicket/bindings/search_agent_ticket_binding.dart';
import '../modules/searchAgentTicket/views/search_agent_ticket_view.dart';
import '../modules/searchCampaign/bindings/search_campaign_binding.dart';
import '../modules/searchCampaign/views/search_campaign_view.dart';
import '../modules/searchContact/bindings/search_contact_binding.dart';
import '../modules/searchContact/views/search_contact_view.dart';
import '../modules/searchDeal/bindings/search_deal_binding.dart';
import '../modules/searchDeal/views/search_deal_view.dart';
import '../modules/searchProduct/bindings/search_product_binding.dart';
import '../modules/searchProduct/views/search_product_view.dart';
import '../modules/searchTeam/bindings/search_team_binding.dart';
import '../modules/searchTeam/views/search_team_view.dart';
import '../modules/searchTicket/bindings/search_ticket_binding.dart';
import '../modules/searchTicket/views/search_ticket_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splashScreen/bindings/splash_screen_binding.dart';
import '../modules/splashScreen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.ADD_USER,
      page: () => const AddUserView(),
      binding: AddUserBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CONTACT,
      page: () => const AddContactView(),
      binding: AddContactBinding(),
    ),
    GetPage(
      name: _Paths.ADD_DEAL,
      page: () => const AddDealView(),
      binding: AddDealBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TICKET,
      page: () => const AddTicketView(),
      binding: AddTicketBinding(),
    ),
    GetPage(
      name: _Paths.ASSIGN_AGENT,
      page: () => const AssignAgentView(),
      binding: AssignAgentBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SALE,
      page: () => const AddSaleView(),
      binding: AddSaleBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_CONTACT,
      page: () => SearchContactView(),
      binding: SearchContactBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_CAMPAIGN,
      page: () => const SearchCampaignView(),
      binding: SearchCampaignBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_PRODUCT,
      page: () => const SearchProductView(),
      binding: SearchProductBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_DEAL,
      page: () => SearchDealView(),
      binding: SearchDealBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_TICKET,
      page: () => const SearchTicketView(),
      binding: SearchTicketBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_AGENT_DEAL,
      page: () => const SearchAgentDealView(),
      binding: SearchAgentDealBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_AGENT_TICKET,
      page: () => const SearchAgentTicketView(),
      binding: SearchAgentTicketBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PRODUCT,
      page: () => const AddProductView(),
      binding: AddProductBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_TEAM,
      page: () => const SearchTeamView(),
      binding: SearchTeamBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
  ];
}
