import 'package:get/get.dart';

import '../../models/salon_model.dart';
import '../providers/laravel_provider.dart';
// import '../../models/award_model.dart';
import '../../models/e_service_model.dart';
// import '../../models/experience_model.dart';
// import '../../models/gallery_model.dart';
// import '../../models/review_model.dart';
import '../../models/salon_model.dart';
import '../../models/user_model.dart';

class SalonRepository {

  late LaravelApiClient _laravelApiClient;
  // Simulated data for salons, reviews, galleries, etc.
  List<Map<String, dynamic>> salons = [
    {'id': '1', 'name': 'Salon A', 'address': 'Address 1', 'rating': 4.5},
    {'id': '2', 'name': 'Salon B', 'address': 'Address 2', 'rating': 4.0},
    {'id': '3', 'name': 'Salon C', 'address': 'Address 3', 'rating': 3.5},
  ];

  List<Map<String, dynamic>> reviews = [
    {'id': '1', 'salonId': '1', 'comment': 'Great service!', 'rating': 5},
    {'id': '2', 'salonId': '2', 'comment': 'Good experience', 'rating': 4},
    {'id': '3', 'salonId': '1', 'comment': 'Not bad', 'rating': 3},
  ];

  List<Map<String, dynamic>> galleries = [
    {'id': '1', 'salonId': '1', 'imageUrl': 'https://example.com/gallery1.jpg'},
    {'id': '2', 'salonId': '1', 'imageUrl': 'https://example.com/gallery2.jpg'},
    {'id': '3', 'salonId': '2', 'imageUrl': 'https://example.com/gallery3.jpg'},
  ];

  List<Map<String, dynamic>> awards = [
    {'id': '1', 'salonId': '1', 'title': 'Best Salon 2022'},
    {'id': '2', 'salonId': '2', 'title': 'Top Rated Salon'},
  ];

  List<Map<String, dynamic>> experiences = [
    {'id': '1', 'salonId': '1', 'title': 'Expert in haircuts'},
    {'id': '2', 'salonId': '2', 'title': 'Specialist in hair coloring'},
  ];

  List<Map<String, dynamic>> employees = [
    {'id': '1', 'salonId': '1', 'name': 'John Doe', 'role': 'Hairdresser'},
    {'id': '2', 'salonId': '2', 'name': 'Jane Smith', 'role': 'Colorist'},
  ];

  List<Map<String, dynamic>> eServices = [
    {'id': '1', 'salonId': '1', 'name': 'Haircut', 'category': 'Hair'},
    {'id': '2', 'salonId': '2', 'name': 'Hair Coloring', 'category': 'Hair'},
    {'id': '3', 'salonId': '1', 'name': 'Shampoo', 'category': 'Hair'},
  ];

  // Simulated methods returning static data

  Future<List<Salon>> getRecommended() async {
    return _laravelApiClient.getRecommendedSalons();
  }

   Future<Salon> get(String salonId) {
    return _laravelApiClient.getSalon(salonId);
  }

  // Future<List<Salon>> getNearSalons(LatLng latLng, LatLng areaLatLng) {
  //   return _laravelApiClient.getNearSalons(latLng, areaLatLng);
  // }

  // Future<List<Review>> getReviews(String salonId) async {
  //   return _laravelApiClient.getSalonReviews(salonId);
  // }

  // Future<List<Gallery>> getGalleries(String salonId) async {
  //    return _laravelApiClient.getSalonGalleries(salonId);
  // }

  // Future<List<Award>> getAwards(String salonId) async {
  //    return _laravelApiClient.getSalonAwards(salonId);
  // }

  // Future<List<Experience>> getExperiences(String salonId) async {
  //   return _laravelApiClient.getSalonExperiences(salonId);
  // }

  Future<List<EService>> getEServices( String salonId, List<String> categories,{int page = 1}) async {
    return _laravelApiClient.getSalonEServices(salonId, categories, page);
  }

  Future<List<User>> getEmployees(String salonId) async {
    return _laravelApiClient.getSalonEmployees(salonId);
  }

  Future<List<EService>> getPopularEServices(
      String salonId, List<String> categories,
      {int page = 1}) async {
     return _laravelApiClient.getSalonPopularEServices(salonId, categories, page);
  }

  Future<List<EService>> getMostRatedEServices(
      String salonId, List<String> categories,
      {int page = 1}) async {
    return _laravelApiClient.getSalonMostRatedEServices(salonId, categories, page);
  }

    Future<List<EService>> getAvailableEServices(
      String salonId, List<String> categories,
      {int page = 1}) async {
     return _laravelApiClient.getSalonAvailableEServices(salonId, categories, page);
  }

  Future<List<EService>> getFeaturedEServices(
      String salonId, List<String> categories,
      {int page = 1}) async {
    return _laravelApiClient.getSalonFeaturedEServices(salonId, categories, page);
  }

  Future<List> getAvailabilityHours(
      String eProviderId, DateTime date, String employeeId) async {
    // This can return hardcoded availability, e.g., a fixed set of available hours
    return _laravelApiClient.getAvailabilityHours(eProviderId, date, employeeId);
  }
}
