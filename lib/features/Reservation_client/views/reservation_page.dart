import 'package:get/get.dart';

class ReservationController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var selectedService = Rx<String?>(null);

  // Liste des services (à remplacer par ta source de données)
  var services = [
    'Service A',
    'Service B',
    'Service C',
  ].obs;

  // Fonction pour changer la date
  void changeDate(DateTime date) {
    selectedDate.value = date;
  }

  // Fonction pour réserver un service
  void reserveService(String service) {
    selectedService.value = service;
    // Logic pour réserver le service
  }
}
