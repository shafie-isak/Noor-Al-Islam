import 'dart:convert';
import 'package:dhikr_reminder1/pages/read_dua.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dhikr_reminder1/colors.dart';

class DuaCollection extends StatefulWidget {
  const DuaCollection({super.key});

  @override
  State<DuaCollection> createState() => _DuaCollectionState();
}

class _DuaCollectionState extends State<DuaCollection> {
  List<dynamic> duas = [];

  void initState() {
    super.initState();
    loadDuaItems();
  }

  Future<void> loadDuaItems() async {
    try {
      // Load the JSON file
      String data = await DefaultAssetBundle.of(context).loadString('assets/data/dua.json');
      setState(() {
        // Decode the JSON and extract the "duas" list
        duas = json.decode(data)['duas'];
        print("Dua Items Loaded: $duas");
      });
    } catch (e) {
      print("Error loading JSON: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: duas.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator
          :GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Two items per row
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: duas.length,
                itemBuilder: (context, index) {
                  final dua = duas[index];
                  return GestureDetector(
                    onTap: () {
                      final subDuas = dua['sub_duas'];
                      if (subDuas != null && subDuas is List) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReadDua(subDuas: List<Map<String, dynamic>>.from(subDuas)),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('No sub-duas available for this dua')),
                        );
                      }
                    },
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Column(
                        children: [
                          // SVG Image Section
                          Container(
                            height: 82,
                            width: double.infinity,
                            color: Colors.blue[400],
                            child: SvgPicture.asset(
                              dua["image"]!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Text Section
                          Container(
                            width: double.infinity,
                            height: 32.22,
                            color: AppColors.lightBlue,
                            child: Center(
                              child: Text(
                                dua["title"]!,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },

              ),
    );
  }
}
