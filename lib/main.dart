import 'package:dhikr_reminder1/colors.dart';
import 'package:dhikr_reminder1/pages/dua_collection.dart';
import 'package:dhikr_reminder1/pages/home.dart';
import 'package:dhikr_reminder1/pages/read_dua.dart';
import 'package:dhikr_reminder1/pages/tasbiih.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:solar_icons/solar_icons.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Luncher(),
  ));
}



class Luncher extends StatefulWidget {
  const Luncher({super.key});

  @override
  State<Luncher> createState() => _LuncherState();
}

class _LuncherState extends State<Luncher> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const Home(),
    const TasbeehApp(),
    const DuaCollection(),
    const TasbeehApp(),
    const DuaCollection()
  ];

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: AppColors.whiteSmoke,
    appBar: AppBar(
      backgroundColor: AppColors.primaryColor,
      title: Text("Dhikr Reminder", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.white)),
      centerTitle: true,
    ),
    drawer: Drawer(
      backgroundColor: AppColors.whiteSmoke,
    ),
    body: _pages[_selectedIndex],

    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    floatingActionButton: FloatingActionButton(
      shape: CircleBorder(),
      foregroundColor: AppColors.lightBlue,
      backgroundColor: AppColors.primaryColor,
      onPressed: () {
        // Add your action here
      },
      child: Icon(Icons.add, size: 24), // Adjusted icon size for small button
    ),

    bottomNavigationBar: BottomAppBar(
      height: 100,
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0, // Increased margin to avoid overflow
      color: AppColors.lightBlue,
      child: Container(
        margin: EdgeInsets.only(top: 15),
        height: 80, // Increased height for better spacing
        child: BottomNavigationBar(
          backgroundColor:AppColors.lightBlue.withOpacity(0),
          elevation: 0,
          unselectedItemColor: AppColors.primaryColor,
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.secondaryColor,
          selectedFontSize: 15,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          showUnselectedLabels: true,
          onTap: _onItemTapped,
          
          items: [
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 0 ? SolarIconsBold.home : SolarIconsOutline.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 1 ? SolarIconsBold.alarm : SolarIconsOutline.alarm),
              label: "Alarms",
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 2 ? SolarIconsBold.checkSquare : SolarIconsOutline.checkSquare),
              label: "To-do",
            ),
            // SizedBox(width: 10,),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 3 ? FlutterIslamicIcons.solidTasbih2 : FlutterIslamicIcons.tasbih2),
              label: 'Tasbih',
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 4 ? FlutterIslamicIcons.solidSajadah : FlutterIslamicIcons.sajadah),
              label: 'Prayers',
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 5 ? FlutterIslamicIcons.solidPrayer : FlutterIslamicIcons.prayer),
              label: 'Duas',
            ),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    ),
  );
}
}

