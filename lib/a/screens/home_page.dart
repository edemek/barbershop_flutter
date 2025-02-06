import 'package:barbershpo_flutter/a/components/appointment_card.dart';
import 'package:barbershpo_flutter/a/components/salon_card.dart';
import 'package:barbershpo_flutter/a/utils/config.dart';
import 'package:barbershpo_flutter/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> salCat = [
    {
      'icon': FontAwesomeIcons.user,
      'category': 'Homme',
    },
    {
      'icon': FontAwesomeIcons.userNurse,
      'category': 'Femme',
    },
    {
      'icon': Iconsax.brush,
      'category': 'Coloration et Traitements Carpillaires',
    },
    {
      'icon': Iconsax.magic_star,
      'category': 'Soins et Extensions',
    },
    {
      'icon': Iconsax.emoji_happy,
      'category': 'Service Additionnels',
    },
  ];

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: (Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text(
                      'Edemek',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                            'assets/images/content/user.png'), //insert user/salon image here
                      ),
                    ),
                  ],
                ),
                Config.spaceMedium,

                /// -- categories listing
                const Text(
                  'Categorie',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                SizedBox(
                  height: Config.heightSize * 0.05,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List<Widget>.generate(salCat.length, (index) {
                      return Card(
                        margin: const EdgeInsets.only(right: 20),
                        color: TColors.primary1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              FaIcon(
                                salCat[index]['icon'],
                                color: TColors.blue,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                salCat[index]['category'],
                                style: const TextStyle(
                                    fontSize: 16, color: TColors.black),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                Config.spaceSmall,
                const Text(
                  'Mes Rendez-vous',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Config.spaceSmall,
                AppointmentCard(),
                Config.spaceSmall,
                const Text(
                  'Les meilleurs Salons',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Config.spaceSmall,
                Column(
                  children: List.generate(10, (index) {
                    return const SalonCard();
                  }),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
