import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:urban_culture_daily_skincare/screens/upload_file.dart';

class SkincareRoutinePage extends StatefulWidget {
  @override
  State<SkincareRoutinePage> createState() => _SkincareRoutinePageState();
}

class _SkincareRoutinePageState extends State<SkincareRoutinePage> {

  PlatformFile? pickedFile;

  final List<Map<String, String>> skincareItems = [
    {'title': 'Cleanser', 'subtitle': 'Cetaphil Gentle Skin Cleanser', 'time': '8:00 PM'},
    {'title': 'Toner', 'subtitle': 'Thayers Witch Hazel Toner', 'time': '8:02 PM'},
    {'title': 'Moisturizer', 'subtitle': "Kiehl's Ultra Facial Cream", 'time': '8:04 PM'},
    {'title': 'Sunscreen', 'subtitle': 'Supergoop Unseen Sunscreen SPF 40', 'time': '8:06 PM'},
    {'title': 'Lip Balm', 'subtitle': 'Glossier Birthday Balm Dotcom', 'time': '8:08 PM'},
  ];

  Future uploadFile() async{
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);

  }

  Future<void> selectFile(BuildContext context) async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.request();

      if (status.isDenied) {
        debugPrint("pr1");
        bool shouldOpenSettings = await showPermissionDialog(context);
        if (shouldOpenSettings) {
          debugPrint("pr2");
          await Permission.storage.request(); // Request again
          return;
        }
      }

      if (status.isPermanentlyDenied) {
        bool shouldOpenSettings = await showPermissionDialog(context, isPermanent: true);
        if (shouldOpenSettings) {
          openAppSettings(); // Open settings if user agrees
        }
        return;
      }
    }

    try {
      debugPrint("pr3");

      final result = await FilePicker.platform.pickFiles();
      if (result == null) {
        debugPrint("No file selected.");
        return;
      }

      if (!context.mounted) return; // Ensure the widget is still active

      setState(() {
        pickedFile = result.files.first;
        debugPrint("Selected file: ${pickedFile!.name}, Size: ${pickedFile!.size} bytes");
      });
    } catch (e) {
      debugPrint("File selection error: $e");
    }
  }

  Future<bool> showPermissionDialog(BuildContext context, {bool isPermanent = false}) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isPermanent ? "Storage Permission Required" : "Permission Denied"),
        content: Text(
          isPermanent
              ? "Storage permission is permanently denied. Please enable it in settings."
              : "This app requires storage access to pick files. Grant permission?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(isPermanent ? "Open Settings" : "Allow"),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF7FA),
      appBar: AppBar(
        title: const Text('Daily Skincare', style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,
            color: Color(0xff1C0D12))),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: skincareItems.length,
        itemBuilder: (context, index) {
          final item = skincareItems[index];
          return ListTile(
            leading: Container(
              width: 56,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xffF2E8EB),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.check,
                size: 26,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            title: Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item['subtitle']!, style: const TextStyle(color: Color(0xff964F66),
                fontSize: 14,fontWeight: FontWeight.w400)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                    onTap: () {
                      selectFile(context);
                      if(pickedFile!=null){
                        debugPrint("heydv");
                        Center(
                          child: Container(
                            color: Colors.blue[100],
                            child: Image.file(
                              File(pickedFile!.path!),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                        debugPrint("pickedFile${pickedFile!.name}");
                      }
                      else{
                        debugPrint("prntdv");
                      }
                    },
                    child: Image.asset("assets/camera.png",height: 27,width: 27,)),
                const SizedBox(width: 8),
                Text(item['time']!, style: const TextStyle(color: Color(0xff964F66),
                    fontWeight: FontWeight.w400,fontSize: 14)),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar:
      BottomNavigationBar(
        onTap: (value) {
          if(value == 1){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return UploadFile();
              },
            ));
          }
          debugPrint("valdv${value}");
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Routine',),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Streaks'),
        ],
        unselectedItemColor: const Color(0xff964F66),
        selectedItemColor: const Color(0xff964F66),
      ),
    );
  }
}