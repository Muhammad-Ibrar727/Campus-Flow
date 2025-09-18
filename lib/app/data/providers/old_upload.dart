import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UploadStudentsView extends StatelessWidget {
  const UploadStudentsView({super.key});

  // 🔹 Inline JSON grouped by departments
  final Map<String, List<Map<String, dynamic>>> departmentStudents = const {
    "Computer Science": [
      {
        "name": "Usman Ali",
        "roll_number": "CS-2201",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Ayesha Malik",
        "roll_number": "CS-2202",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Bilal Hassan",
        "roll_number": "CS-2101",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Sara Riaz",
        "roll_number": "CS-2102",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Omar Farooq",
        "roll_number": "CS-2001",
        "session": "2020",
        "semester": "7th",
      },
      {
        "name": "Zainab Akhtar",
        "roll_number": "CS-2002",
        "session": "2020",
        "semester": "7th",
      },
    ],
    "Pak Study": [
      {
        "name": "Usman Qureshi",
        "roll_number": "PS-2201",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Ayesha Anwar",
        "roll_number": "PS-2202",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Hassan Ali",
        "roll_number": "PS-2101",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Nimra Sheikh",
        "roll_number": "PS-2102",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Imran Khan",
        "roll_number": "PS-2001",
        "session": "2020",
        "semester": "7th",
      },
      {
        "name": "Sara Malik",
        "roll_number": "PS-2002",
        "session": "2020",
        "semester": "7th",
      },
    ],
    "Statistics": [
      {
        "name": "Haris Ahmed",
        "roll_number": "ST-2201",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Maha Riaz",
        "roll_number": "ST-2202",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Noman Ali",
        "roll_number": "ST-2101",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Farah Qureshi",
        "roll_number": "ST-2102",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Tahir Hussain",
        "roll_number": "ST-2001",
        "session": "2020",
        "semester": "7th",
      },
      {
        "name": "Areeba Khan",
        "roll_number": "ST-2002",
        "session": "2020",
        "semester": "7th",
      },
    ],
    "Islamic Study": [
      {
        "name": "Zeeshan Iqbal",
        "roll_number": "IS-2201",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Ayesha Siddiqui",
        "roll_number": "IS-2202",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Hamid Raza",
        "roll_number": "IS-2101",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Maryam Ali",
        "roll_number": "IS-2102",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Khalid Mehmood",
        "roll_number": "IS-2001",
        "session": "2020",
        "semester": "7th",
      },
      {
        "name": "Sadia Bano",
        "roll_number": "IS-2002",
        "session": "2020",
        "semester": "7th",
      },
    ],
    "English": [
      {
        "name": "David Ali",
        "roll_number": "EN-2201",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Fatima Zahra",
        "roll_number": "EN-2202",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Michael Riaz",
        "roll_number": "EN-2101",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Hina Yousaf",
        "roll_number": "EN-2102",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Peter Khan",
        "roll_number": "EN-2001",
        "session": "2020",
        "semester": "7th",
      },
      {
        "name": "Ayesha Karim",
        "roll_number": "EN-2002",
        "session": "2020",
        "semester": "7th",
      },
    ],
    "Economics": [
      {
        "name": "Nadeem Ahmed",
        "roll_number": "EC-2201",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Rabia Shah",
        "roll_number": "EC-2202",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Zahid Iqbal",
        "roll_number": "EC-2101",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Farzana Noor",
        "roll_number": "EC-2102",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Adnan Hussain",
        "roll_number": "EC-2001",
        "session": "2020",
        "semester": "7th",
      },
      {
        "name": "Sobia Malik",
        "roll_number": "EC-2002",
        "session": "2020",
        "semester": "7th",
      },
    ],
    "Political Science": [
      {
        "name": "Fahad Iqbal",
        "roll_number": "PSCI-2201",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Nida Khan",
        "roll_number": "PSCI-2202",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Shahbaz Ahmed",
        "roll_number": "PSCI-2101",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Areeba Noor",
        "roll_number": "PSCI-2102",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Muneeb Khan",
        "roll_number": "PSCI-2001",
        "session": "2020",
        "semester": "7th",
      },
      {
        "name": "Iqra Shaikh",
        "roll_number": "PSCI-2002",
        "session": "2020",
        "semester": "7th",
      },
    ],
    "Zoology": [
      {
        "name": "Owais Khan",
        "roll_number": "ZO-2201",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Sadia Iqbal",
        "roll_number": "ZO-2202",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Umer Farooq",
        "roll_number": "ZO-2101",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Amina Riaz",
        "roll_number": "ZO-2102",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Adil Hussain",
        "roll_number": "ZO-2001",
        "session": "2020",
        "semester": "7th",
      },
      {
        "name": "Hira Malik",
        "roll_number": "ZO-2002",
        "session": "2020",
        "semester": "7th",
      },
    ],
    "Botany": [
      {
        "name": "Nouman Riaz",
        "roll_number": "BO-2201",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Zoya Malik",
        "roll_number": "BO-2202",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Hamza Iqbal",
        "roll_number": "BO-2101",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Laiba Fatima",
        "roll_number": "BO-2102",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Shahid Raza",
        "roll_number": "BO-2001",
        "session": "2020",
        "semester": "7th",
      },
      {
        "name": "Iqra Hussain",
        "roll_number": "BO-2002",
        "session": "2020",
        "semester": "7th",
      },
    ],
    "Pashtu": [
      {
        "name": "Ismail Khan",
        "roll_number": "PA-2201",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Shazia Noor",
        "roll_number": "PA-2202",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Rashid Ahmad",
        "roll_number": "PA-2101",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Mehwish Khan",
        "roll_number": "PA-2102",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Saleem Jan",
        "roll_number": "PA-2001",
        "session": "2020",
        "semester": "7th",
      },
      {
        "name": "Shahnaz Bibi",
        "roll_number": "PA-2002",
        "session": "2020",
        "semester": "7th",
      },
    ],
    "Urdu": [
      {
        "name": "Jawad Ali",
        "roll_number": "UR-2201",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Hira Fatima",
        "roll_number": "UR-2202",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Kamran Raza",
        "roll_number": "UR-2101",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Nida Ahmed",
        "roll_number": "UR-2102",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Waheed Iqbal",
        "roll_number": "UR-2001",
        "session": "2020",
        "semester": "7th",
      },
      {
        "name": "Sana Gul",
        "roll_number": "UR-2002",
        "session": "2020",
        "semester": "7th",
      },
    ],
    "Mathematics": [
      {
        "name": "Hammad Khan",
        "roll_number": "MA-2201",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Saira Javed",
        "roll_number": "MA-2202",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Shahzaib Ahmed",
        "roll_number": "MA-2101",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Fizza Khan",
        "roll_number": "MA-2102",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Adil Raza",
        "roll_number": "MA-2001",
        "session": "2020",
        "semester": "7th",
      },
      {
        "name": "Maryam Shah",
        "roll_number": "MA-2002",
        "session": "2020",
        "semester": "7th",
      },
    ],
    "Chemistry": [
      {
        "name": "Noman Qureshi",
        "roll_number": "CH-2201",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Maham Ali",
        "roll_number": "CH-2202",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Ubaid Khan",
        "roll_number": "CH-2101",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Saira Fatima",
        "roll_number": "CH-2102",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Waqar Ali",
        "roll_number": "CH-2001",
        "session": "2020",
        "semester": "7th",
      },
      {
        "name": "Amna Bibi",
        "roll_number": "CH-2002",
        "session": "2020",
        "semester": "7th",
      },
    ],
    "AI": [
      {
        "name": "Farhan Malik",
        "roll_number": "AI-2201",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Laiba Ahmed",
        "roll_number": "AI-2202",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Adeel Khan",
        "roll_number": "AI-2101",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Sana Qureshi",
        "roll_number": "AI-2102",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Waseem Iqbal",
        "roll_number": "AI-2001",
        "session": "2020",
        "semester": "7th",
      },
      {
        "name": "Kiran Fatima",
        "roll_number": "AI-2002",
        "session": "2020",
        "semester": "7th",
      },
    ],
    "Physics": [
      {
        "name": "Hassan Riaz",
        "roll_number": "PH-2201",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Mariam Noor",
        "roll_number": "PH-2202",
        "session": "2022",
        "semester": "3rd",
      },
      {
        "name": "Yasir Khan",
        "roll_number": "PH-2101",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Fatima Sheikh",
        "roll_number": "PH-2102",
        "session": "2021",
        "semester": "5th",
      },
      {
        "name": "Adnan Ali",
        "roll_number": "PH-2001",
        "session": "2020",
        "semester": "7th",
      },
      {
        "name": "Sadia Khan",
        "roll_number": "PH-2002",
        "session": "2020",
        "semester": "7th",
      },
    ],
  };

  Future<void> uploadStudents() async {
    try {
      for (var entry in departmentStudents.entries) {
        String departmentName = entry.key;
        List<Map<String, dynamic>> students = entry.value;

        for (var student in students) {
          await FirebaseFirestore.instance
              .collection('departments')
              .doc(departmentName) // 🔹 Department doc
              .collection('students') // 🔹 Students subcollection
              .add(student);
        }
      }
      Get.snackbar(
        "✅ Success",
        "All departments & students uploaded successfully!",
      );
    } catch (e) {
      Get.snackbar("❌ Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Students")),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: uploadStudents,
          icon: const Icon(Icons.upload_file),
          label: const Text("Upload Students Data"),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
