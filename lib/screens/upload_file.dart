import 'package:flutter/material.dart';
import 'package:urban_culture_daily_skincare/main.dart';
import 'package:urban_culture_daily_skincare/screens/daily_skincare_page.dart';

class UploadFile extends StatefulWidget {
  const UploadFile({super.key});

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF7FA),
      appBar: AppBar(
        title: const Text('Streaks',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Color(0xff1C0D12))),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Text(
              "Today's Goal: 3 streak days",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xffF2E8EB),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Streak Days",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "2",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff1C0D12)
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Daily Streak",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "2",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Text(
                  "Last 30 Days",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff964F66),
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  "+100%",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff088759),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Image.asset("assets/stats.png"),
            const SizedBox(
              height: 30,
            ),
            const Text("Keep it up! You're on a roll."),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              // Adjust the width as needed
              padding: const EdgeInsets.symmetric(vertical: 15),
              // Adjust height
              decoration: BoxDecoration(
                color: const Color(0xFFF2E8EB), // Light pinkish background
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
              alignment: Alignment.center,
              // Center the text
              child: const Text(
                'Get Started',
                style: TextStyle(
                  color: Colors.black, // Black text color
                  fontWeight: FontWeight.w600, // Semi-bold
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          if (value == 0) {
            Navigator.of(context).pop();
          }
          debugPrint("valdv${value}");
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Routine',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Streaks',),
        ],
        unselectedItemColor: const Color(0xff964F66),
        selectedItemColor: const Color(0xff964F66),
      ),
    );
  }
}
