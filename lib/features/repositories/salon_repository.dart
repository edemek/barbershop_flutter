import 'package:get/get.dart';


class SalonRepository {
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

  Future<List<Map<String, dynamic>>> getRecommended() async {
    return salons.where((salon) => salon['rating'] >= 4.0).toList();
  }
/*
  Future<List<Map<String, dynamic>>> getNearSalons(LatLng latLng, LatLng areaLatLng) async {
    // Simulated logic to return salons based on location (no actual calculation)
    return salons;
  }*/

  Future<Map<String, dynamic>> get(String salonId) async {
    return salons.firstWhere((salon) => salon['id'] == salonId);
  }

  Future<List<Map<String, dynamic>>> getReviews(String salonId) async {
    return reviews.where((review) => review['salonId'] == salonId).toList();
  }

  Future<List<Map<String, dynamic>>> getGalleries(String salonId) async {
    return galleries.where((gallery) => gallery['salonId'] == salonId).toList();
  }

  Future<List<Map<String, dynamic>>> getAwards(String salonId) async {
    return awards.where((award) => award['salonId'] == salonId).toList();
  }

  Future<List<Map<String, dynamic>>> getExperiences(String salonId) async {
    return experiences.where((experience) => experience['salonId'] == salonId).toList();
  }

  Future<List<Map<String, dynamic>>> getEServices(String salonId, List<String> categories, {int page = 1}) async {
    return eServices
        .where((service) => service['salonId'] == salonId && categories.contains(service['category']))
        .toList();
  }

  Future<List<Map<String, dynamic>>> getEmployees(String salonId) async {
    return employees.where((employee) => employee['salonId'] == salonId).toList();
  }

  Future<List<Map<String, dynamic>>> getPopularEServices(String salonId, List<String> categories, {int page = 1}) async {
    return eServices
        .where((service) => service['salonId'] == salonId && categories.contains(service['category']))
        .toList();
  }

  Future<List<Map<String, dynamic>>> getMostRatedEServices(String salonId, List<String> categories, {int page = 1}) async {
    return eServices
        .where((service) => service['salonId'] == salonId && categories.contains(service['category']))
        .toList();
  }

  Future<List<Map<String, dynamic>>> getAvailableEServices(String salonId, List<String> categories, {int page = 1}) async {
    return eServices
        .where((service) => service['salonId'] == salonId && categories.contains(service['category']))
        .toList();
  }

  Future<List<Map<String, dynamic>>> getFeaturedEServices(String salonId, List<String> categories, {int page = 1}) async {
    return eServices
        .where((service) => service['salonId'] == salonId && categories.contains(service['category']))
        .toList();
  }

  Future<List<Map<String, dynamic>>> getAvailabilityHours(String eProviderId, DateTime date, String employeeId) async {
    // This can return hardcoded availability, e.g., a fixed set of available hours
    return [
      {'start': '09:00', 'end': '17:00'},
      {'start': '10:00', 'end': '18:00'},
    ];
  }
}
