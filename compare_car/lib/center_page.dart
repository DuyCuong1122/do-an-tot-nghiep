import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/store/user.dart';

class CenterPage extends StatelessWidget {
  const CenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Admin()),
                );
              },
              child: const Text('Admin'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const User()),
                );
              },
              child: const Text('User'),
            ),
          ],
        ),
      ),
    );
  }
}

class Admin extends StatelessWidget {
  const Admin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Administrator'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => Get.toNamed('/add_car'),
                child: const Text('Add car'),
              ),
              ElevatedButton(
                onPressed: () => Get.toNamed('/add_spec'),
                child: const Text('Add spec'),
              ),
              ElevatedButton(
                onPressed: () => Get.toNamed('/delete_car'),
                child: const Text('Delete car'),
              ),
              ElevatedButton(
                onPressed: () => Get.toNamed('/add_image'),
                child: const Text('Add image'),
              ),
              ElevatedButton(
                onPressed: () => Get.toNamed('/delete_spec'),
                child: const Text('Delete spec'),
              ),
            ],
          ),
        ));
  }
}

class User extends StatelessWidget {
  const User({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () => Get.toNamed('/compareCar'),
            child: const Text('Compare Car'),
          ),
          ElevatedButton(
            onPressed: () async {
              String profile = await UserStore.to.getProfile();
              log(profile);
              Get.offAndToNamed('/application');
            },
            child: const Text('Homepage'),
          ),
          ElevatedButton(
            child: const Text("Log out"),
            onPressed: () {
              // UserStore.to.logout();

              Get.offAndToNamed('/sign_in');
            },
          ),
          ElevatedButton(
            child: const Text('Profile'),
            onPressed: () => Get.offAndToNamed('/profile'),
          )
        ],
      )),
    );
  }
}
