import 'package:flutter/material.dart';
import 'package:spin_event_2023/controller/spin_api.dart';
import 'package:spin_event_2023/model/DB_product_model.dart';
import 'package:spin_event_2023/model/modeluser.dart';
import 'package:spin_event_2023/view/src/spin_wheel/spin%20.dart';

// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
        2, nameuser![0].length, "*" * (nameuser[0].length - 2));

    // Get height and width
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Container(
          clipBehavior: Clip.antiAlias,
          width: width * 0.6,
          height: height * 0.35,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display user image
                Container(
                  height: height * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: user.image != null && user.image!.isNotEmpty
                          ? CachedNetworkImageProvider(user.image!)
                          : AssetImage('assets/default_image.png')
                      as ImageProvider, // Fallback if image is null/empty
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Display user name and obfuscated email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name!.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white70),
                        ),
                        Text(
                          emailObfuscated!,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                    SizedBox(width: 50),
                    // Back button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text(
                        "Back",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.white70),
                      ),
                    ),
                    // StreamBuilder for fetching products
                    StreamBuilder(
                      stream: SpinApi.fetchProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting ||
                            snapshot.connectionState == ConnectionState.none) {
                          return CircularProgressIndicator();
                        }

                        if (snapshot.hasData) {
                          dbproducts.clear();
                          dbproducts.addAll(snapshot.data!.docs
                              .map((e) => DBProducts.fromJson(e.data()))
                              .toList());

                          print("list count===================${dbproducts.length}");
                        }

                        // If products are fetched or not, return the Confirm button
                        return ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SpinWheel(
                                user: user,
                                dbProducts: dbproducts,
                              ),
                            ));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: Text(
                            "Confirm",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: Colors.white70),
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
    );
  }
}
