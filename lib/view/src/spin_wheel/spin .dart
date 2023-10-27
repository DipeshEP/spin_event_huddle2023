import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:spin_event_2023/controller/spin_api.dart';
import 'package:spin_event_2023/model/product_model.dart';
import 'package:spin_event_2023/view/src/spin_wheel/users%20.dart';

import '../../../model/modeluser.dart';

class SpinWheel extends StatefulWidget {
  User user;
  SpinWheel({super.key, required this.user});

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> {
  StreamController<int> selected = StreamController<int>();
  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  void initState() {
    selected = StreamController<int>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<User> userList = [];
    // final items = <String>[
    // 'Cherry',
    // 'Wocher 200',
    // 'Watch',
    // 'Cherry',
    // 'Wocher 100',
    // 'Earbud',
    // 'Cherry',
    // 'Wocher 200',
    // 'Speaker',
    // 'Cherry',
    // 'Wocher 100',
    // 'Cap',
    // ];

    int? index;
    String email = widget.user.email!;
    var nameuser = email.split("@");
    var emailcaracter = email.replaceRange(
        2, nameuser[0].length, "*" * (nameuser[0].length - 2));
    print(emailcaracter);
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://images.unsplash.com/photo-1604079628040-94301bb21b91?auto=format&fit=crop&q=80&w=1887&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
              fit: BoxFit.fill)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            toolbarHeight: 100,
            automaticallyImplyLeading: false,
            title: StreamBuilder(
                stream: SpinApi.fetchOneUser(widget.user.usId),
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
                        return Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(userList.first.image!),
                              radius: 40,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userList.first.name!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Colors.black,
                                      ),
                                ),
                                Text(
                                  emailcaracter,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Colors.black,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: Text("error"),
                        );
                      }
                  }
                }),
          ),
          body: GestureDetector(
            onTap: () {
              log(userList.first.isSpin.toString());
              if (userList.first.isSpin == false) {
                setState(() {
                  selected.add(SpinApi.spinButtonClik());
                });
              } else {
                showDialog(
                  context: context,
// user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      // <-- SEE HERE

                      title: const Text(
                        'You Already Tried',
                        textAlign: TextAlign.center,
                      ),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[],
                        ),
                      ),
                      actions: <Widget>[
                        Center(
                          child: OutlinedButton(
                            child: const Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Users(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FortuneWheel(
                      onAnimationStart: () {
                        SpinApi.updateCount();
                      },
                      onAnimationEnd: () {
                        SpinApi.updateUserStatus(userList.first.usId);
                        popup(context, productlist);
                      },
                      animateFirst: false,
                      selected: selected.stream,
                      items: [
                        for (var it in productlist)
                          FortuneItem(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(it.price),
                              Text(it.name),
                            ],
                          )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Future<dynamic> popup(BuildContext context, List<Products> productlist) {
    return showDialog(
      context: context,
// user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE

          title: const Text(
            'Congratulations you Won',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  productlist[SpinApi.random].name,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: OutlinedButton(
                child: const Text('Ok'),
                onPressed: () {
                 Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Users(),
                                ),
                              );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}