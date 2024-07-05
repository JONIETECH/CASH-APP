import 'package:flutter/material.dart';

class Aipage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const Aipage());
  const Aipage({super.key});
  
  @override
  State<Aipage> createState() => _AipageState();
}

class _AipageState extends State<Aipage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/dark.jpg"),
            fit: BoxFit.cover, // This ensures the image covers the entire background
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 120,
              child: const Row(
                children: [
                  Text(
                    "Fin Pal",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ],
              ),
            ),
            Expanded(child: ListView()),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              height: 120,
              color: Colors.blue,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Center(
                      child: Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Center(
                      child: Icon(Icons.mic, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

