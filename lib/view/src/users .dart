
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spin_event_2023/controller/user_controller.dart';
import 'package:spin_event_2023/model/modeluser.dart';
import 'package:spin_event_2023/view/src/profile.dart';
import 'package:get/get.dart';

import 'package:animate_do/animate_do.dart';

class Users extends StatelessWidget {
  Users({super.key});

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    userController.fetchUsers();

    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                child: const Text(
                  "USERS",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildSearchFieldWithAnimation(),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  if (userController.userList.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.greenAccent,
                      ),
                    );
                  }

                  if (userController.filteredUsers.isEmpty) {
                    return Column(
                      children: [
                        Image.asset("assets/sad2.png", height: 300),
                        const Text(
                          "No user found",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: userController.filteredUsers.length,
                    itemBuilder: (context, index) {
                      return SlideInRight(
                        delay: Duration(milliseconds: 100 * index),
                        child: _buildUserListTile(
                          userController.filteredUsers[index],
                          context,
                        ),
                      );
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

  Widget _buildSearchFieldWithAnimation() {
    return SlideInDown(
      duration: const Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade800, // Simple background color
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            style: const TextStyle(color: Colors.white, fontSize: 16),
            onChanged: (value) {
              userController.query.value = value; // Update query
              userController.filterUsers(value); // Filter users
            },
            cursorColor: Colors.greenAccent,
            decoration: InputDecoration(
              hintText: "Search players...",
              hintStyle: const TextStyle(color: Colors.white70, fontSize: 16),
              prefixIcon: const Icon(Icons.search_outlined, color: Colors.white),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserListTile(User user, BuildContext context) {
    bool? isChecked = user.isSpin;
    String email = user.email!;
    var nameuser = email.split("@");
    var emailObfuscated = email.replaceRange(
      2, nameuser[0].length, "*" * (nameuser[0].length - 2),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ZoomIn(
        duration: const Duration(milliseconds: 500),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 10,
          color: Colors.grey.shade800, // Dark card background
          shadowColor: Colors.greenAccent.withOpacity(0.7), // Neon shadow effect
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey.shade700,
              backgroundImage: CachedNetworkImageProvider(
                user.image!,
                errorListener: (error) {
                  print('Error loading image: $error');
                },
              ),
            ),
            title: Text(
              user.name!.toUpperCase(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent, // Green neon text
              ),
            ),
            subtitle: Text(
              emailObfuscated,
              style: const TextStyle(
                color: Colors.white70, // Subtle color for the email
                fontSize: 14,
              ),
            ),
            trailing: _buildTrailingButton(isChecked, user, context),
          ),
        ),
      ),
    );
  }

  Widget _buildTrailingButton(bool? isChecked, User user, BuildContext context) {
    return isChecked == true
        ? ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(100, 50),
        backgroundColor: Colors.transparent,
        side: const BorderSide(color: Colors.red, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () => _showAlreadyTriedDialog(user),
      child: const Icon(Icons.error_outline, color: Colors.red),
    )
        : ElevatedButton(
      onPressed: () {
        Get.to(() => Profile(user: user));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.greenAccent,
        fixedSize: const Size(120, 50), // Slightly larger for CTA
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadowColor: Colors.greenAccent.withOpacity(0.5), // Glow effect
        elevation: 10,
      ),
      child: Text(
        "Play",
        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
      ),
    );
  }

  void _showAlreadyTriedDialog(User user) {
    Get.defaultDialog(
      backgroundColor: Colors.grey.shade900.withOpacity(0.9),
      title: "${user.name}, You Already Tried",
      titleStyle: const TextStyle(color: Colors.white, fontSize: 18),
      content: ZoomIn(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset("assets/sad2.png", height: 200),
            const SizedBox(height: 20),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.grey.shade100,
                elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () => Get.back(),
              child: const Text(
                "Ok",
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



