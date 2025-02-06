import 'package:barbershpo_flutter/a/utils/config.dart';
import 'package:barbershpo_flutter/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

enum FilterStatus { nouveau, terminer, annuler }

class _AppointmentPageState extends State<AppointmentPage> {
  FilterStatus status = FilterStatus.nouveau;
  Alignment _alignment = Alignment.centerLeft;
  List<dynamic> schedules = [
    {
      'Salon_name': 'Salon Rehoboth',
      'Salon_profile': 'assets/images/animations/onboard1.jpg',
      'category': 'Femme',
      'status': FilterStatus.nouveau,
    },
    {
      'Salon_name': 'Salon Betania',
      'Salon_profile': 'assets/images/animations/onboard2.jpg',
      'category': 'Homme',
      'status': FilterStatus.terminer,
    },
    {
      'Salon_name': 'Jeannette',
      'Salon_profile': 'assets/images/animations/onboard3.jpg',
      'category': 'Coloration et Traitements Carpillaires',
      'status': FilterStatus.terminer,
    },
    {
      'Salon_name': 'Miabe Barber',
      'Salon_profile': 'assets/images/animations/onboard4.jpg',
      'category': 'Soins et Extensions',
      'status': FilterStatus.annuler,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<dynamic> filteredSchedules = schedules.where((var schedule) {
      //switch (schedule['status']) {
      //case 'upcoming':
      //schedule['status'] = FilterStatus.upcoming;
      //break;
      //case 'complete':
      //schedule['status'] = FilterStatus.complete;
      //break;
      //case 'cancel':
      //schedule['status'] = FilterStatus.cancel;
      //break;
      //}
      return schedule['status'] == status;
    }).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Planing des rendez-vous',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Config.spaceSmall,
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (FilterStatus filterStatus in FilterStatus.values)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (filterStatus == FilterStatus.nouveau) {
                                  status = FilterStatus.nouveau;
                                  _alignment = Alignment.centerLeft;
                                } else if (filterStatus ==
                                    FilterStatus.terminer) {
                                  status = FilterStatus.terminer;
                                  _alignment = Alignment.center;
                                } else if (filterStatus ==
                                    FilterStatus.annuler) {
                                  status = FilterStatus.annuler;
                                  _alignment = Alignment.centerRight;
                                }
                              });
                            },
                            child: Center(
                              child: Text(filterStatus.name),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedAlign(
                  alignment: _alignment,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: TColors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        status.name,
                        style: const TextStyle(
                          color: TColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Config.spaceSmall,
            Expanded(
              child: ListView.builder(
                  itemCount: filteredSchedules.length,
                  itemBuilder: (context, index) {
                    var _schedule = filteredSchedules[index];
                    bool isLastElement = filteredSchedules.length + 1 == index;
                    return Card(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                        color: TColors.blue,
                      ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: !isLastElement ? const EdgeInsets.only(bottom: 20) : EdgeInsets.zero,
                      child: Padding(padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(_schedule['Salon_profile']),
                              ),
                              Config.spaceSmall,
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_schedule['Salon_name'],
                                )
                              ],)
                            ],
                          ),
                        ],
                      ),),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
