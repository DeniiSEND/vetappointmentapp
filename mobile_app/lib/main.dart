import 'package:flutter/material.dart';
import 'register_cat.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    DashboardScreen(),
    Center(child: Text("รายการนัดหมาย")),
    Center(child: Text("ข้อมูลแมว")),
    Center(child: Text("สัตวแพทย์")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.pink,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "หน้าหลัก"),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "นัดหมาย"),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: "ข้อมูลแมว"),
          BottomNavigationBarItem(icon: Icon(Icons.medical_services), label: "สัตวแพทย์"),
        ],
      ),
    );
  }
}

// ✅ แก้ไขแล้ว: หน้า Dashboard
class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ระบบนัดหมายสัตวแพทย์")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("ยินดีต้อนรับสู่ KittyCare", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterCatScreen()), // เปิดหน้าลงทะเบียนแมว
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text("ลงทะเบียนแมว", style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                // เพิ่มการเชื่อมไปยังหน้าจองนัดหมาย
              },
              child: Text("จองนัดหมาย"),
            ),
          ],
        ),
      ),
    );
  }
}
