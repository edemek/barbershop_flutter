
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../account/views/account_view.dart';
import '../../../../account/views/account_view_customer.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/validators/validation.dart';

class Resume extends StatelessWidget {
  const Resume({super.key});

  AppBar _buildAppbar() {
    return AppBar(
      title: Text(
        'Profile',
        style: TextStyle(
          color: TColors.textPrimary,
          fontSize: TSizes.fontSizeMd,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildProfilePhoto() {
    return Stack(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
              color: TColors.primaryBackground,
              borderRadius: BorderRadius.all(Radius.circular(60)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ]),
          child: Image(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/on_boarding_images/onboard4.jpg"),
            height: 120,
            width: 120,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          height: 35,
          child: GestureDetector(
            child: Container(
              height: 35,
              width: 35,
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: TColors.buttonPrimary,
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
              ),
              child: IconButton(
                color: TColors.white,
                onPressed: () {},
                icon: Icon(Icons.edit),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompleteBtn() {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: 60, bottom: 30),
        width: 295,
        height: 44,
        decoration: BoxDecoration(
            color: TColors.buttonPrimary,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextButton(
              child: (Text("Terminer")),
              onPressed: (){
                Get.back();
              },

            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutBtn() {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: 0, bottom: 30),
        width: 295,
        height: 44,
        decoration: BoxDecoration(
            color: TColors.buttonDisable,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Déconnexion',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: TColors.textWhite,
                fontSize: TSizes.fontSizeMd,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    return Scaffold(
      appBar: _buildAppbar(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                child: Column(
                  children: [

                    /// -- User Profile Picture
                    _buildProfilePhoto(),

                    const SizedBox(height: TSizes.spacetBtwSections),

                    /// -- User Informationsn
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Affichage des informations collectées
                          Text('Salon: ${userController.shopName.value}'),

                          const SizedBox(height: TSizes.spaceBtwInputFields),

                          Text('Gérer Par: ${userController.firstName.value} ${userController.lastName.value}'),

                          //const SizedBox(height: TSizes.spaceBtwInputFields),

                          //Text('Nom: '),

                          const SizedBox(height: TSizes.spaceBtwInputFields),

                          Text('Email: ${userController.email.value}'),

                          const SizedBox(height: TSizes.spaceBtwInputFields),

                          Text('Numéro de téléphone: ${userController.phoneNumber.value}'),

                        ],
                      ),
                    ),

                    /// -- Boutton Terminer
                    _buildCompleteBtn(),

                    /// -- Logout
                    _buildLogoutBtn(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
