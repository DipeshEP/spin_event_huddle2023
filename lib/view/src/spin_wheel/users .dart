import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:spin_event_2023/model/product_model.dart';
import 'package:spin_event_2023/view/src/spin_wheel/profile.dart';

import '../../../controller/spin_api.dart';
import '../../../model/modeluser.dart';
import 'package:spin_event_2023/model/message_model.dart';
class Users extends StatefulWidget {
  Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List<User> userList = [];
  List<User> filtered = [];
  String? query = "";

  @override
  void initState() {
    SpinApi.fetchUser().listen((snapshot) {
      userList = snapshot.docs.map((e) => User.fromJson(e.data())).toList();
      userList.sort((a, b) => b.spinTime!.compareTo(a.spinTime!));
      filterUsers(query!);
    });
    super.initState();
  }

  void filterUsers(String query) {
    if (query.isNotEmpty) {
      List<User> filteredSearch = userList.where((user) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      }).toList();

      setState(() {
        filtered = filteredSearch;
      });
    } else {
      setState(() {
        filtered = userList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: const Text(
              "USERS",
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                height: 70,
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 260, right: 260),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) => filterUsers(value),
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle:
                            const TextStyle(color: Colors.white, fontSize: 18),
                        prefixIconColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.search_outlined,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colors.green,
                              width: 2.0,
                            )),
                        fillColor: Colors.black,
                        filled: true),
                  ),
                ),
              ),
              SizedBox(height: 40,),
              Expanded(
                child: StreamBuilder(
                    stream: SpinApi.fetchUser(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return const Center(child: CircularProgressIndicator());
                        case ConnectionState.active:
                        case ConnectionState.done:
                          userList = snapshot.data!.docs
                              .map((e) => User.fromJson(e.data()))
                              .toList();
                          if (userList.isNotEmpty) {
                            return ListView.builder(
                              itemCount: filtered.length,
                              itemBuilder: (context, index) {
                                bool? isChecked = filtered[index].isSpin;
                                String email = filtered[index].email!;
                                var nameuser = email.split("@");
                                var emailcaracter = email.replaceRange(
                                    2,
                                    nameuser[0].length,
                                    "*" * (nameuser[0].length - 2));
                                print(emailcaracter);
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: ListTile(
                                    horizontalTitleGap: 20,
                                    minVerticalPadding: 30,
                                    isThreeLine: true,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16)),
                                    tileColor: isChecked == true
                                        ? Colors.grey
                                        : const Color(0xFDFDFDFD),
                                    leading: CircleAvatar(
                                      radius: 40,
                                      backgroundImage:
                                          NetworkImage(filtered[index].image!),
                                    ),
                                    title: Text(
                                      filtered[index].name!.toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      emailcaracter,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                            color: Colors.black,
                                          ),
                                    ),
                                    trailing: isChecked == true
                                        ? ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: const Size(150, 50),
                                                backgroundColor:
                                                    Colors.transparent),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    content: GlassmorphicContainer(
                                                      height: 550,
                                                      width: 500,
                                                      alignment: Alignment.center,
                                                      border: 2,
                                                      linearGradient:
                                                          LinearGradient(
                                                        begin: Alignment.topLeft,
                                                        end: Alignment.bottomRight,
                                                        colors: [
                                                          Colors.white
                                                              .withOpacity(0.1),
                                                          Colors.white
                                                              .withOpacity(0.1),
                                                        ],
                                                      ),
                                                      borderGradient:
                                                          LinearGradient(
                                                        begin: Alignment.topLeft,
                                                        end: Alignment.bottomRight,
                                                        colors: [
                                                          Colors.white
                                                              .withOpacity(0.1),
                                                          Colors.white
                                                              .withOpacity(0.1),
                                                        ],
                                                      ),
                                                      blur: 2,
                                                      borderRadius: 20,
                                                      child: Stack(
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Text(
                                                                  "${filtered[index].name},You Already Traied",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize: 18,
                                                                      letterSpacing:
                                                                          1)),
                                                              Image.asset(
                                                                "assets/sad2.png",
                                                                height: 300,
                                                              ),
                                                              OutlinedButton(
                                                                style: OutlinedButton.styleFrom(
                                                                  backgroundColor: Colors.grey.shade100,
                                                                  elevation: 10,
                                                                ),
                                                                  onPressed: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                Users(),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: const Text(
                                                                    "Ok",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600),
                                                                  ))
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: const Text(""),
                                          )
                                        : ElevatedButton(
                                            onPressed: () async{
                                              // SpinApi.sendPushNotification( filtered[index].pushToken.toString(), "Hai");

                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    Profile(user: filtered[index]),
                                              ));

                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                                fixedSize: const Size(150, 50)),
                                            child: Text(
                                              "Next",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                    color: Colors.white,
                                                  ),
                                            ),
                                          ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: Text("no user"),
                            );
                          }
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
