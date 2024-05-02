import 'package:get/get.dart';

import '../modules/addContact/bindings/add_contact_binding.dart';
import '../modules/addContact/views/add_contact_view.dart';
import '../modules/addDeal/bindings/add_deal_binding.dart';
import '../modules/addDeal/views/add_deal_view.dart';
import '../modules/addSale/bindings/add_sale_binding.dart';
import '../modules/addSale/views/add_sale_view.dart';
import '../modules/addTicket/bindings/add_ticket_binding.dart';
import '../modules/addTicket/views/add_ticket_view.dart';
import '../modules/addUser/bindings/add_user_binding.dart';
import '../modules/addUser/views/add_user_view.dart';
import '../modules/assignAgent/bindings/assign_agent_binding.dart';
import '../modules/assignAgent/views/assign_agent_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
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
  ];
}
