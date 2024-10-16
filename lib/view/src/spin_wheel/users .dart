
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spin_event_2023/controller/user_controller.dart';
import 'package:spin_event_2023/model/modeluser.dart';
import 'package:spin_event_2023/view/src/spin_wheel/profile.dart';
import 'package:get/get.dart';

class Users extends StatelessWidget {
  Users({super.key});

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    userController.fetchUsers();

    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              const Text(
                  "USERS",
                  style: TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              const SizedBox(height: 10),
              _buildSearchField(),
              const SizedBox(height: 40),
              Expanded(
                child: Obx(() {
                  if (userController.userList.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (userController.filteredUsers.isEmpty) {
                    return Column(
                      children: [
                        Image.asset("assets/sad2.png", height: 300),
                        Text("No user found", style: TextStyle(color: Colors.white))
                      ],
                    );;
                  }

                  return ListView.builder(
                    itemCount: userController.filteredUsers.length,
                    itemBuilder: (context, index) {
                      return _buildUserListTile(userController.filteredUsers[index], context);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),  // Background color with opacity
        borderRadius: BorderRadius.circular(20),  // Rounded corners
        border: Border.all(
          color: Colors.white.withOpacity(0.5),  // Border color with opacity
          width: 2,  // Border width
        ),
      ),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        onChanged: (value) {
          userController.query.value = value; // Update query
          userController.filterUsers(value); // Filter users
        },
        cursorColor: Colors.green,
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: const TextStyle(color: Colors.white, fontSize: 18),
          prefixIconColor: Colors.white,
          prefixIcon: const Icon(Icons.search_outlined),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.green, width: 2.0),
          ),
          fillColor: Colors.transparent,  // Keeping the inside transparent
          filled: true,
        ),
      ),
    );
  }

  Widget _buildUserListTile(User user, BuildContext context) {
    bool? isChecked = user.isSpin;
    String email = user.email!;
    var nameuser = email.split("@");
    var emailObfuscated = email.replaceRange(
        2, nameuser[0].length, "*" * (nameuser[0].length - 2));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          horizontalTitleGap: 20,
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[300],
            backgroundImage: CachedNetworkImageProvider(
              user.image!,
              errorListener: (error) {
                print('Error loading image: $error');
              },
            ),
            onBackgroundImageError: (_, __) {

            },
          ),
          title: Text(
            user.name!.toUpperCase(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,  // Black for better readability
            ),
          ),
          subtitle: Text(
            emailObfuscated,
            style: const TextStyle(
              color: Colors.black54,  // Softer color for email
              fontSize: 14,
            ),
          ),
          trailing: _buildTrailingButton(isChecked, user, context),
        ),
      ),
    );
  }

  Widget _buildTrailingButton(bool? isChecked, User user, BuildContext context) {
    return isChecked == true
        ? ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(150, 50),
        backgroundColor: Colors.transparent,
      ),
      onPressed: () => _showAlreadyTriedDialog(user),
      child: const Text(""),
    )
        : ElevatedButton(
      onPressed: () {

        Get.to(() => Profile(user: user));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        fixedSize: const Size(150, 50),
      ),
      child: Text(
        "Next",
        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white),
      ),
    );
  }

  void _showAlreadyTriedDialog(User user) {
    Get.defaultDialog(
      backgroundColor: Colors.transparent,
      title: "${user.name}, You Already Tried",
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset("assets/sad2.png", height: 300),
          OutlinedButton(
            style: OutlinedButton.styleFrom(backgroundColor: Colors.grey.shade100, elevation: 10),
            onPressed: () => Get.back(),
            child: const Text("Ok", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}



