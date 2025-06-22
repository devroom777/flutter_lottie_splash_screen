import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? lottieFile;
  Uint8List? lottieData;

  @override
  void initState() {
    super.initState();
    downloadAndSaveFile();
    loadLottieBytes();
  }

  Future<void> loadLottieBytes() async {
    final response = await http.get(Uri.parse('https://lottie.host/f87cf6a6-bcf2-44d8-8f90-f12382cf959f/T0avw96Dur.json'));
    setState(() {
      lottieData = response.bodyBytes;
    });
  }

  Future<void> downloadAndSaveFile() async {
    final url = 'https://lottie.host/f87cf6a6-bcf2-44d8-8f90-f12382cf959f/T0avw96Dur.json';
    final response = await http.get(Uri.parse(url));
     if (response.statusCode == 200) {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/animation.json';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      setState(() {
        lottieFile = file;
      });
    } else {
      print("❌ Error downloading Lottie file: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Welcome Lottie'),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Lottie.asset(
                      "assets/animation/Animation1750581575472.json",
                      fit: BoxFit.cover,
                      repeat: false//stop
                      // width: 100,
                      // height: 100,
                    ),
                  ),
                  Expanded(
                    child: Lottie.asset(
                      "assets/animation/Animation1750505046776.json",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Lottie.asset(
                      "assets/animation/Animation750504920340.json",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'json',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Lottie.network(
                      "https://lottie.host/f87cf6a6-bcf2-44d8-8f90-f12382cf959f/T0avw96Dur.json",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Lottie.network(
                     'https://lottie.host/a035805d-5f6b-4893-a4eb-f093d507b5d0/lVSr7FfGiJ.json',
                    ),
                  ),
                  Expanded(
                    child: Lottie.network(
                      "https://lottie.host/a83234a9-5d1c-4a88-b4b4-80f846902cb6/2mSHlaoPry.json",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'network',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  lottieFile == null
                      ? const CircularProgressIndicator()
                      : Lottie.file(
                          lottieFile!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                          repeat: true
                        ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'file',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  lottieData == null
                    ? const CircularProgressIndicator()
                    : Lottie.memory(lottieData!, width: 140, height: 140),
                    ],
              ),
              const SizedBox(height: 20),
              const Text(
                'memory',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
