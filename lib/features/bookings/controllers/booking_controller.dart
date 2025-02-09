import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/booking_model.dart';
import '../../../models/booking_status.dart';
import '../../repositories/booking_repository.dart';
import '../../repositories/salon_repository.dart';
import '../../../../common/ui.dart';
import '../../../models/user_model.dart';
import '../../../routes/app_routes.dart';
import '../../services/global_service.dart';
import 'bookings_controller.dart';




class BookingStatus_ {
  String? id;
  String? name;
  int? order;

  BookingStatus_({this.id, this.name, this.order});
}

class Booking_ {
  String? id;
  String? customerName;
  BookingStatus_? status;

  Booking_({this.id, this.customerName, this.status});
}

class BookingController extends GetxController {
  final bookings = <Booking>[].obs;
  final bookingStatuses = <BookingStatus>[].obs;
  final page = 0.obs;
  final isLoading = true.obs;
  final isDone = false.obs;
  final currentStatus = '1'.obs;
  final booking = Booking().obs;
  Timer? timer;


  late ScrollController scrollController;
  late SalonRepository _salonRepository;
  late BookingRepository _bookingRepository;

  BookingController() {
    _bookingRepository = BookingRepository();
    _salonRepository = SalonRepository();
  }


  // Données simulées pour les statuts de réservation
  final List<BookingStatus_> _simulatedStatuses = [
    BookingStatus_(id: '1', name: 'Pending', order: 1),
    BookingStatus_(id: '2', name: 'Confirmed', order: 2),
    BookingStatus_(id: '3', name: 'Completed', order: 3),
    BookingStatus_(id: '4', name: 'Canceled', order: 4),
  ];

  // Données simulées pour les réservations
  final List<Booking_> _simulatedBookings = [
    Booking_(id: '1', customerName: 'John Doe', status: BookingStatus_(id: '1', name: 'Pending', order: 1)),
    Booking_(id: '2', customerName: 'Jane Smith', status: BookingStatus_(id: '2', name: 'Confirmed', order: 2)),
    Booking_(id: '3', customerName: 'Robert Brown', status: BookingStatus_(id: '3', name: 'Completed', order: 3)),
    Booking_(id: '4', customerName: 'Emily White', status: BookingStatus_(id: '4', name: 'Canceled', order: 4)),
  ];


  @override
  void onInit() async {
    booking.value = Get.arguments as Booking;
    super.onInit();
  }

  @override
  void onReady() async {
    await refreshBooking();
    super.onReady();
  }

  Future refreshBooking({bool showMessage = false}) async {
    await getBooking();
    if (showMessage) {
      Get.showSnackbar(Ui.SuccessSnackBar(message: "Booking page refreshed successfully".tr));
    }
  }

  Future<void> getBooking() async {
    try {
      booking.value = await _bookingRepository.get(booking.value.id!);
      if (booking.value.status == Get.find<BookingsController>().getStatusByOrder(Get.find<GlobalService>().global.value.inProgress! ) && timer == null) {
        timer = Timer.periodic(Duration(minutes: 1), (t) {
          booking.update((val) {
            val?.duration = val.duration! + (1 / 60);
          });
        });
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future<void> onTheWayBookingService() async {
    final _status = Get.find<BookingsController>().getStatusByOrder(Get.find<GlobalService>().global.value.onTheWay!);
    await changeBookingStatus(_status);
  }

  Future<void> readyBookingService() async {
    final _status = Get.find<BookingsController>().getStatusByOrder(Get.find<GlobalService>().global.value.ready!);
    await changeBookingStatus(_status);
  }

  Future<void> startBookingService() async {
    try {
      final _status = Get.find<BookingsController>().getStatusByOrder(Get.find<GlobalService>().global.value.inProgress!);
      final _booking = new Booking(id: booking.value.id, startAt: DateTime.now(), status: _status);
      await _bookingRepository.update(_booking);
      booking.update((val) {
        val!.startAt = _booking.startAt;
        val.status = _status;
      });
      timer = Timer.periodic(Duration(minutes: 1), (t) {
        booking.update((val) {
          val?.duration = val.duration! + (1 / 60);
        });
      });
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future<void> finishBookingService() async {
    try {
      final _status = Get.find<BookingsController>().getStatusByOrder(Get.find<GlobalService>().global.value.done!);
      var _booking = new Booking(id: booking.value.id, endsAt: DateTime.now(), status: _status);
      final result = await _bookingRepository.update(_booking);
      booking.update((val) {
        val!.endsAt = result.endsAt;
        val.duration = result.duration;
        val.status = _status;
      });
      timer?.cancel();
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
  
  Future<void> cancelBookingService() async {
    try {
      if (booking.value.status!.order < Get.find<GlobalService>().global.value.onTheWay!) {
        final _status = Get.find<BookingsController>().getStatusByOrder(Get.find<GlobalService>().global.value.failed!);
        final _booking = new Booking(id: booking.value.id, cancel: true, status: _status);
        await _bookingRepository.update(_booking);
        booking.update((val) {
          val!.cancel = true;
          val.status = _status;
        });
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
  
  String getTime({String separator = ":"}) {
    String hours = "";
    String minutes = "";
    int minutesInt = ((booking.value.duration! - booking.value.duration!.toInt()) * 60).toInt();
    int hoursInt = booking.value.duration!.toInt();
    if (hoursInt < 10) {
      hours = "0" + hoursInt.toString();
    } else {
      hours = hoursInt.toString();
    }
    if (minutesInt < 10) {
      minutes = "0" + minutesInt.toString();
    } else {
      minutes = minutesInt.toString();
    }
    return hours + separator + minutes;
  }

  //  Future<void> startChat() async {
  //   List<User> _employees = await _salonRepository.getEmployees(booking.value.salon!.id!);
  //   _employees = _employees
  //       .map((e) {
  //         // e.avatar = booking.value.salon!.images![0];
  //         return e;
  //       })
  //       .toSet()
  //       .toList();
  //   Message _message = new Message(_employees, name: booking.value.salon!.name);
  //   Get.toNamed(Routes.CHAT, arguments: _message);
  // }

  Future<void> changeBookingStatus(BookingStatus bookingStatus) async {
    try {
      final _booking = new Booking(id: booking.value.id, status: bookingStatus);
      await _bookingRepository.update(_booking);
      booking.update((val) {
        val!.status = bookingStatus;
      });
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}
