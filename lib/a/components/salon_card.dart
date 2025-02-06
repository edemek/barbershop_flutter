import 'package:barbershpo_flutter/a/utils/config.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class SalonCard extends StatefulWidget {
  const SalonCard({super.key});

  @override
  State<SalonCard> createState() => _SalonCardState();
}

class _SalonCardState extends State<SalonCard> {
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 150,
      child: GestureDetector(
        child: Card(
          elevation: 5,
          color: TColors.white,
          child: Row(
            children: [
              SizedBox(
                width: Config.widthSize * 0.33,
                child: Image.asset(
                  'assets/images/animations/onboard4.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        'Salon Rehoboth',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Salon de coiffure Femme',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.star_border, color: TColors.blue, size: 16,),
                          Spacer(flex: 1,),
                          Text('4.5'),
                          Spacer(flex: 1,),
                          Text('Reviews'),
                          Spacer(flex: 1,),
                          Text('(20)'),
                          Spacer(flex: 7,),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {}, // Rediriger vers la page de vue du salon
      ),
    );
  }
}
