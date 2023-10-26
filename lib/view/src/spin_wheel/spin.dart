import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

import '../../../model/modeluser.dart';


class SpinWheel extends StatefulWidget {
  AllAddedUsers user;
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
  Widget build(BuildContext context) {
    final items = <String>[
      'Cherry',
      'Wocher 200',
      'Watch',
      'Cherry',
      'Wocher 100',
      'Earbud',
      'Cherry',
      'Wocher 200',
      'Speaker',
      'Cherry',
      'Wocher 100',
      'Cap',
      
    ];
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
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.user.image!),
                radius: 40,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.name!,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  Text(
                    emailcaracter,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: GestureDetector(
          onTap: () {
            int random=Fortune.randomInt(0, items.length);
            log(random.toString());
            ;
            setState(() {
              
              selected.add(random);
               index=random;
            });
            // setState(() {
             
            // });
          },
          child: Column(
            children: [
              Expanded(
                child: FortuneWheel(
                  onAnimationEnd: () {
                  
                 setState(() {
                      log(items[index!+1]);
                 });
                  },
                  animateFirst: false,
                  selected: selected.stream,
                  items: [
                    for (var it in items) FortuneItem(child: Text(it)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
