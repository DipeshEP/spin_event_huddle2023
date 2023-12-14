import 'package:flutter/material.dart';
import 'package:spin_event_2023/controller/spin_api.dart';
import 'package:spin_event_2023/model/DB_product_model.dart';
import 'package:spin_event_2023/model/modeluser.dart';
import 'package:spin_event_2023/view/src/spin_wheel/spin%20.dart';

// ignore: must_be_immutable
class Profile extends StatelessWidget {
  User user;
  Profile({super.key, required this.user});
  List<DBProducts> dbproducts = [];
  List cherryList=[0,3,6,9,11];

  @override
  Widget build(BuildContext context) {
    String? email = user.email;
    var nameuser = email?.split("@");
    var emailcaracter = email?.replaceRange(
        2, nameuser![0].length, "*" * (nameuser![0].length - 2));
    print(emailcaracter);
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
                Container(
                  height: height * 0.25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(user.image!), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name!,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white70,
                                  ),
                        ),
                        Text(
                          emailcaracter!,
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Colors.white70,
                                  ),
                        ),
                      ],
                    ),
              SizedBox(width: 50,),
              ElevatedButton(
                onPressed: () async {
                 Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green),
                child: Text(
                  "Back",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(
                    color: Colors.white70,
                  ),
                ),
              ),
                    StreamBuilder(
                        stream: SpinApi.fetchProducts(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return Center(child: CircularProgressIndicator());
                            case ConnectionState.active:
                            case ConnectionState.done:
                              dbproducts = snapshot.data!.docs
                                  .map((e) => DBProducts.fromJson(e.data()))
                                  .toList();
                                  print("list count===================${dbproducts.length}");
                              if (dbproducts.isNotEmpty) {
                                return 
                                  ElevatedButton(
                                  onPressed: () async {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => SpinWheel(
                                        user: user,
                                        dbProducts: dbproducts ,
                                      ),
                                    ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  child: Text(
                                    "confirm",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                          color: Colors.white70,
                                        ),
                                  ),
                                );
                              }else{
                                return ElevatedButton(
                                  onPressed: () async {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => SpinWheel(
                                        user: user,
                                        dbProducts: dbproducts ,
                                      ),
                                    ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  child: Text(
                                    "confirm",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                          color: Colors.white70,
                                        ),
                                  ),
                                );
                              }
                          }
                          // return ElevatedButton(
                          //   onPressed: () async {
                          //     Navigator.of(context).push(MaterialPageRoute(
                          //       builder: (context) => SpinWheel(
                          //         user: user,
                          //       ),
                          //     ));
                          //   },
                          //   style: ElevatedButton.styleFrom(
                          //       backgroundColor: Colors.green),
                          //   child: Text(
                          //     "confirm",
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .labelLarge!
                          //         .copyWith(
                          //           color: Colors.white70,
                          //         ),
                          //   ),
                          // );
                        }),
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
