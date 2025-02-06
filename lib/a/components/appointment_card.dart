import 'package:barbershpo_flutter/a/utils/config.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class AppointmentCard extends StatefulWidget {
  const AppointmentCard({super.key});

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: TColors.primary1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/animations/onboard4.jpg'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Rehoboth',
                        style: TextStyle(
                          color: TColors.blue,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Salon de coiffure Homme',
                        style: TextStyle(color: TColors.black),
                      ),
                    ],
                  ),
                ],
              ),
              Config.spaceSmall,

              /// -- Information du planing
              const ScheduleCard(),
              Config.spaceSmall,

              /// -- Action Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Annuler', style: TextStyle(color: Colors.red),),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Terminé', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TColors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          Icon(
            Icons.calendar_today,
            color: TColors.black,
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'Lundi, 03 Février 2025',
            style: TextStyle(color: TColors.black),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.access_alarm,
            color: TColors.black,
            size: 17,
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
            child: Text(
              '10h00',
              style: TextStyle(color: TColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
