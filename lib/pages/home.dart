import 'package:dhikr_reminder1/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Container(
              height: 200,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage("assets/images/hero_bg.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Dhikr Reminder", style: TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("Have you dhikr today?", style: TextStyle(color: AppColors.white, fontSize: 18)),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: const Row(
                children: [
                  Expanded(child: Text("Daily dhikr reminder", style: TextStyle(color: Colors.grey))),
                  Icon(Icons.more_vert_outlined, color: Colors.grey),
                ],
              ),
            ),
            const Divider(),
            Container(
              color: AppColors.lightBlue,
              child: ListTile(
                title: Text("Adkar Al-Sabah", style: TextStyle(color: AppColors.primaryColor)),
                subtitle: const Text("10:30 PM", style: TextStyle(color: Color.fromARGB(236, 7, 45, 76))),
                trailing: Icon(Icons.more_vert, color: AppColors.primaryColor),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              color: AppColors.lightBlue,
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Adkar Al-Sabah", style: TextStyle(color: AppColors.primaryColor, fontSize: 17)),
                        const SizedBox(height: 3),
                        Text("09:00 AM", style: TextStyle(color: AppColors.primaryColor, fontSize: 14)),
                      ],
                    ),
                  ),
                  const Icon(Icons.more_vert),
                ],
              ),
            ),
          ],
        ),
      );
  }
}
