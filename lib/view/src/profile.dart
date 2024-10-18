import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spin_event_2023/controller/spin_api.dart';
import 'package:spin_event_2023/model/DB_product_model.dart';
import 'package:spin_event_2023/model/modeluser.dart';
import 'package:spin_event_2023/view/src/spinwheelPage.dart';

class Profile extends StatelessWidget {
  final User user;
  final List<DBProducts> dbproducts = [];
  final List<int> cherryList = [0, 3, 6, 9, 11];

  Profile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // Obfuscating the email (partially replacing it with *)
    String? email = user.email;
    var nameuser = email?.split("@");
    var emailObfuscated = email?.replaceRange(
      2, nameuser![0].length, "*" * (nameuser[0].length - 2),
    );

    // Get height and width
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Hero(
          tag: 'profile-card-${user.name}',
          child: Container(
            clipBehavior: Clip.antiAlias,
            width: width * 0.6,
            height: height * 0.46,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.greenAccent, width: 2),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade800,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeIn(
                    duration: const Duration(milliseconds: 600),
                    child: Container(
                      height: height * 0.25,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: user.image != null && user.image!.isNotEmpty
                              ? CachedNetworkImageProvider(user.image!)
                              : const AssetImage('assets/default_image.png') as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInLeftBig(
                            delay: const Duration(milliseconds: 300),
                            child: Text(
                              user.name!.toUpperCase(),
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          FadeOutRight(
                            delay: const Duration(milliseconds: 500),
                            child: Text(
                              emailObfuscated!,
                              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          fixedSize: const Size(100, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Back",
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      StreamBuilder(
                        stream: SpinApi.fetchProducts(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting ||
                              snapshot.connectionState == ConnectionState.none) {
                            return const CircularProgressIndicator(
                                color: Colors.greenAccent);
                          }

                          if (snapshot.hasData) {
                            dbproducts.clear();
                            dbproducts.addAll(snapshot.data!.docs
                                .map((e) => DBProducts.fromJson(e.data()))
                                .toList());
                          }

                          return FadeInLeftBig(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SpinWheel(
                                      user: user,
                                      dbProducts: dbproducts,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                fixedSize: const Size(150, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                shadowColor: Colors.blueAccent.withOpacity(0.5),
                                elevation: 10,
                              ),
                              child: Text(
                                "Confirm",
                                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
