import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/ui.dart';

class BookingStatus {
  String? id;
  String? name;
  int? order;

  BookingStatus({this.id, this.name, this.order});
}

class Booking {
  String? id;
  String? customerName;
  BookingStatus? status;
  bool cancel;

  Booking({this.id, this.customerName, this.status, this.cancel = false});
}

class BookingsController extends GetxController {
  final bookings = <Booking>[].obs;
  final bookingStatuses = <BookingStatus>[].obs;
  final page = 0.obs;
  final isLoading = true.obs;
  final isDone = false.obs;
  final currentStatus = '1'.obs;

  late ScrollController scrollController;

  // Données simulées pour les statuts de réservation
  final List<BookingStatus> _simulatedStatuses = [
    BookingStatus(id: '1', name: 'Pending', order: 1),
    BookingStatus(id: '2', name: 'Confirmed', order: 2),
    BookingStatus(id: '3', name: 'Completed', order: 3),
    BookingStatus(id: '4', name: 'Canceled', order: 4),
  ];

  // Données simulées pour les réservations
  final List<Booking> _simulatedBookings = [
    Booking(id: '1', customerName: 'John Doe', status: BookingStatus(id: '1', name: 'Pending', order: 1)),
    Booking(id: '2', customerName: 'Jane Smith', status: BookingStatus(id: '2', name: 'Confirmed', order: 2)),
    Booking(id: '3', customerName: 'Robert Brown', status: BookingStatus(id: '3', name: 'Completed', order: 3)),
    Booking(id: '4', customerName: 'Emily White', status: BookingStatus(id: '4', name: 'Canceled', order: 4)),
  ];

  @override
  Future<void> onInit() async {
    await getBookingStatuses();
    currentStatus.value = getStatusByOrder(1).id!;
    super.onInit();
  }

  Future refreshBookings({bool showMessage = false, String? statusId}) async {
    changeTab(statusId);
    if (showMessage) {
      await getBookingStatuses();
      Get.showSnackbar(Ui.SuccessSnackBar(message: "Bookings page refreshed successfully".tr));
    }
  }

  void initScrollController() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isDone.value) {
        loadBookingsOfStatus(statusId: currentStatus.value);
      }
    });
  }

  void changeTab(String? statusId) async {
    this.bookings.clear();
    currentStatus.value = statusId ?? currentStatus.value;
    page.value = 0;
    await loadBookingsOfStatus(statusId: currentStatus.value);
  }

  Future getBookingStatuses() async {
    try {
      bookingStatuses.assignAll(_simulatedStatuses); // Utilisation des statuts simulés
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  BookingStatus getStatusByOrder(int order) => bookingStatuses.firstWhere(
        (s) => s.order == order,
    orElse: () {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Booking status not found".tr));
      return BookingStatus(); // Retourne un statut vide si aucun statut n'est trouvé
    },
  );

  Future loadBookingsOfStatus({String statusId = ''}) async {
    try {
      isLoading.value = true;
      isDone.value = false;
      page.value++;

      // Filtrer les réservations en fonction du statut actuel
      List<Booking> _bookings = _simulatedBookings
          .where((booking) => booking.status!.id == statusId)
          .toList();

      if (_bookings.isNotEmpty) {
        bookings.addAll(_bookings);
      } else {
        isDone.value = true;
      }
    } catch (e) {
      isDone.value = true;
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> cancelBookingService(Booking booking) async {
    try {
      if (booking.status!.order! < 3) { // Par exemple, si l'ordre est inférieur à 'Completed'
        final _status = getStatusByOrder(4); // Statut "Canceled"
        final _booking = Booking(id: booking.id, customerName: booking.customerName, status: _status, cancel: true);
        bookings.removeWhere((element) => element.id == booking.id);
        bookings.add(_booking);
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}
