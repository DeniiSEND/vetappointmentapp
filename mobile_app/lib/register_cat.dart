import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterCatScreen extends StatefulWidget {
  @override
  _RegisterCatScreenState createState() => _RegisterCatScreenState();
}

class _RegisterCatScreenState extends State<RegisterCatScreen> {
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController ownerPhoneController = TextEditingController();
  final TextEditingController ownerAddressController = TextEditingController();
  final TextEditingController catNameController = TextEditingController();
  final TextEditingController catBreedController = TextEditingController();
  final TextEditingController catAgeController = TextEditingController();
  String selectedGender = 'เพศผู้';

  Future<void> registerCat() async {
    final response = await http.post(
      Uri.parse('http://localhost/ex/register_cat.php'),
      body: {
        'owner_name': ownerNameController.text,
        'owner_phone': ownerPhoneController.text,
        'owner_address': ownerAddressController.text,
        'cat_name': catNameController.text,
        'cat_breed': catBreedController.text,
        'cat_age': catAgeController.text,
        'cat_gender': selectedGender,
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("ลงทะเบียนแมวสำเร็จ!")),
      );
      Navigator.pop(context); // กลับไปหน้าหลัก
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("เกิดข้อผิดพลาด! ลองใหม่อีกครั้ง")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ลงทะเบียนแมว")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: ownerNameController,
                decoration: InputDecoration(labelText: "ชื่อเจ้าของ"),
              ),
              TextField(
                controller: ownerPhoneController,
                decoration: InputDecoration(labelText: "เบอร์โทรเจ้าของ"),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: ownerAddressController,
                decoration: InputDecoration(labelText: "ที่อยู่เจ้าของ"),
              ),
              TextField(
                controller: catNameController,
                decoration: InputDecoration(labelText: "ชื่อแมว"),
              ),
              TextField(
                controller: catBreedController,
                decoration: InputDecoration(labelText: "สายพันธุ์"),
              ),
              TextField(
                controller: catAgeController,
                decoration: InputDecoration(labelText: "อายุ (ปี)"),
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField<String>(
                value: selectedGender,
                items: ["เพศผู้", "เพศเมีย"].map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGender = value!;
                  });
                },
                decoration: InputDecoration(labelText: "เพศ"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: registerCat,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text("บันทึก", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
