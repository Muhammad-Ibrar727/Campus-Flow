import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadDataScreen extends StatelessWidget {
  final Map<String, dynamic> data = {
    
      "departments": {
        "Pak Study": {
          "students": {
            "PS2023001": {
              "name": "Ali Raza",
              "rollNumber": "PS2023001",
              "semester": "1st",
              "batch": "2023",
              "department": "Pak Study",
            },
            "PS2023002": {
              "name": "Sadia Noor",
              "rollNumber": "PS2023002",
              "semester": "1st",
              "batch": "2023",
              "department": "Pak Study",
            },
            "PS2022001": {
              "name": "Usman Qureshi",
              "rollNumber": "PS2022001",
              "semester": "3rd",
              "batch": "2022",
              "department": "Pak Study",
            },
            "PS2022002": {
              "name": "Ayesha Anwar",
              "rollNumber": "PS2022002",
              "semester": "3rd",
              "batch": "2022",
              "department": "Pak Study",
            },
            "PS2021001": {
              "name": "Hassan Ali",
              "rollNumber": "PS2021001",
              "semester": "5th",
              "batch": "2021",
              "department": "Pak Study",
            },
            "PS2021002": {
              "name": "Nimra Sheikh",
              "rollNumber": "PS2021002",
              "semester": "5th",
              "batch": "2021",
              "department": "Pak Study",
            },
            "PS2020001": {
              "name": "Imran Khan",
              "rollNumber": "PS2020001",
              "semester": "7th",
              "batch": "2020",
              "department": "Pak Study",
            },
            "PS2020002": {
              "name": "Sara Malik",
              "rollNumber": "PS2020002",
              "semester": "7th",
              "batch": "2020",
              "department": "Pak Study",
            },
          },
        },
        "Computer Science": {
          "students": {
            "CS2023001": {
              "name": "Ali Ahmed",
              "rollNumber": "CS2023001",
              "semester": "1st",
              "batch": "2023",
              "department": "Computer Science",
            },
            "CS2023002": {
              "name": "Fatima Khan",
              "rollNumber": "CS2023002",
              "semester": "1st",
              "batch": "2023",
              "department": "Computer Science",
            },
            "CS2022001": {
              "name": "Usman Ali",
              "rollNumber": "CS2022001",
              "semester": "3rd",
              "batch": "2022",
              "department": "Computer Science",
            },
            "CS2022002": {
              "name": "Ayesha Malik",
              "rollNumber": "CS2022002",
              "semester": "3rd",
              "batch": "2022",
              "department": "Computer Science",
            },
            "CS2021001": {
              "name": "Bilal Hassan",
              "rollNumber": "CS2021001",
              "semester": "5th",
              "batch": "2021",
              "department": "Computer Science",
            },
            "CS2021002": {
              "name": "Sara Riaz",
              "rollNumber": "CS2021002",
              "semester": "5th",
              "batch": "2021",
              "department": "Computer Science",
            },
            "CS2020001": {
              "name": "Omar Farooq",
              "rollNumber": "CS2020001",
              "semester": "7th",
              "batch": "2020",
              "department": "Computer Science",
            },
            "CS2020002": {
              "name": "Zainab Akhtar",
              "rollNumber": "CS2020002",
              "semester": "7th",
              "batch": "2020",
              "department": "Computer Science",
            },
          },
        },
        "Statistics": {
          "students": {
            "ST2023001": {
              "name": "Ahmed Khan",
              "rollNumber": "ST2023001",
              "semester": "1st",
              "batch": "2023",
              "department": "Statistics",
            },
            "ST2023002": {
              "name": "Sana Malik",
              "rollNumber": "ST2023002",
              "semester": "1st",
              "batch": "2023",
              "department": "Statistics",
            },
            "ST2022001": {
              "name": "Haris Ahmed",
              "rollNumber": "ST2022001",
              "semester": "3rd",
              "batch": "2022",
              "department": "Statistics",
            },
            "ST2022002": {
              "name": "Maha Riaz",
              "rollNumber": "ST2022002",
              "semester": "3rd",
              "batch": "2022",
              "department": "Statistics",
            },
            "ST2021001": {
              "name": "Noman Ali",
              "rollNumber": "ST2021001",
              "semester": "5th",
              "batch": "2021",
              "department": "Statistics",
            },
            "ST2021002": {
              "name": "Farah Qureshi",
              "rollNumber": "ST2021002",
              "semester": "5th",
              "batch": "2021",
              "department": "Statistics",
            },
            "ST2020001": {
              "name": "Tahir Hussain",
              "rollNumber": "ST2020001",
              "semester": "7th",
              "batch": "2020",
              "department": "Statistics",
            },
            "ST2020002": {
              "name": "Areeba Khan",
              "rollNumber": "ST2020002",
              "semester": "7th",
              "batch": "2020",
              "department": "Statistics",
            },
          },
        },
        "Islamic Study": {
          "students": {
            "IS2023001": {
              "name": "Mohammad Ali",
              "rollNumber": "IS2023001",
              "semester": "1st",
              "batch": "2023",
              "department": "Islamic Study",
            },
            "IS2023002": {
              "name": "Khadija Noor",
              "rollNumber": "IS2023002",
              "semester": "1st",
              "batch": "2023",
              "department": "Islamic Study",
            },
            "IS2022001": {
              "name": "Zeeshan Iqbal",
              "rollNumber": "IS2022001",
              "semester": "3rd",
              "batch": "2022",
              "department": "Islamic Study",
            },
            "IS2022002": {
              "name": "Ayesha Siddiqui",
              "rollNumber": "IS2022002",
              "semester": "3rd",
              "batch": "2022",
              "department": "Islamic Study",
            },
            "IS2021001": {
              "name": "Hamid Raza",
              "rollNumber": "IS2021001",
              "semester": "5th",
              "batch": "2021",
              "department": "Islamic Study",
            },
            "IS2021002": {
              "name": "Maryam Ali",
              "rollNumber": "IS2021002",
              "semester": "5th",
              "batch": "2021",
              "department": "Islamic Study",
            },
            "IS2020001": {
              "name": "Khalid Mehmood",
              "rollNumber": "IS2020001",
              "semester": "7th",
              "batch": "2020",
              "department": "Islamic Study",
            },
            "IS2020002": {
              "name": "Sadia Bano",
              "rollNumber": "IS2020002",
              "semester": "7th",
              "batch": "2020",
              "department": "Islamic Study",
            },
          },
        },
        "English": {
          "students": {
            "EN2023001": {
              "name": "John Smith",
              "rollNumber": "EN2023001",
              "semester": "1st",
              "batch": "2023",
              "department": "English",
            },
            "EN2023002": {
              "name": "Maryam Khan",
              "rollNumber": "EN2023002",
              "semester": "1st",
              "batch": "2023",
              "department": "English",
            },
            "EN2022001": {
              "name": "David Ali",
              "rollNumber": "EN2022001",
              "semester": "3rd",
              "batch": "2022",
              "department": "English",
            },
            "EN2022002": {
              "name": "Fatima Zahra",
              "rollNumber": "EN2022002",
              "semester": "3rd",
              "batch": "2022",
              "department": "English",
            },
            "EN2021001": {
              "name": "Michael Riaz",
              "rollNumber": "EN2021001",
              "semester": "5th",
              "batch": "2021",
              "department": "English",
            },
            "EN2021002": {
              "name": "Hina Yousaf",
              "rollNumber": "EN2021002",
              "semester": "5th",
              "batch": "2021",
              "department": "English",
            },
            "EN2020001": {
              "name": "Peter Khan",
              "rollNumber": "EN2020001",
              "semester": "7th",
              "batch": "2020",
              "department": "English",
            },
            "EN2020002": {
              "name": "Ayesha Karim",
              "rollNumber": "EN2020002",
              "semester": "7th",
              "batch": "2020",
              "department": "English",
            },
          },
        },
        "Economics": {
          "students": {
            "EC2023001": {
              "name": "Salman Khan",
              "rollNumber": "EC2023001",
              "semester": "1st",
              "batch": "2023",
              "department": "Economics",
            },
            "EC2023002": {
              "name": "Maha Ali",
              "rollNumber": "EC2023002",
              "semester": "1st",
              "batch": "2023",
              "department": "Economics",
            },
            "EC2022001": {
              "name": "Nadeem Ahmed",
              "rollNumber": "EC2022001",
              "semester": "3rd",
              "batch": "2022",
              "department": "Economics",
            },
            "EC2022002": {
              "name": "Rabia Shah",
              "rollNumber": "EC2022002",
              "semester": "3rd",
              "batch": "2022",
              "department": "Economics",
            },
            "EC2021001": {
              "name": "Zahid Iqbal",
              "rollNumber": "EC2021001",
              "semester": "5th",
              "batch": "2021",
              "department": "Economics",
            },
            "EC2021002": {
              "name": "Farzana Noor",
              "rollNumber": "EC2021002",
              "semester": "5th",
              "batch": "2021",
              "department": "Economics",
            },
            "EC2020001": {
              "name": "Adnan Hussain",
              "rollNumber": "EC2020001",
              "semester": "7th",
              "batch": "2020",
              "department": "Economics",
            },
            "EC2020002": {
              "name": "Sobia Malik",
              "rollNumber": "EC2020002",
              "semester": "7th",
              "batch": "2020",
              "department": "Economics",
            },
          },
        },
        "Political Science": {
          "students": {
            "PSCI2023001": {
              "name": "Kamran Ali",
              "rollNumber": "PSCI2023001",
              "semester": "1st",
              "batch": "2023",
              "department": "Political Science",
            },
            "PSCI2023002": {
              "name": "Ayesha Javed",
              "rollNumber": "PSCI2023002",
              "semester": "1st",
              "batch": "2023",
              "department": "Political Science",
            },
            "PSCI2022001": {
              "name": "Fahad Iqbal",
              "rollNumber": "PSCI2022001",
              "semester": "3rd",
              "batch": "2022",
              "department": "Political Science",
            },
            "PSCI2022002": {
              "name": "Nida Khan",
              "rollNumber": "PSCI2022002",
              "semester": "3rd",
              "batch": "2022",
              "department": "Political Science",
            },
            "PSCI2021001": {
              "name": "Shahbaz Ahmed",
              "rollNumber": "PSCI2021001",
              "semester": "5th",
              "batch": "2021",
              "department": "Political Science",
            },
            "PSCI2021002": {
              "name": "Areeba Noor",
              "rollNumber": "PSCI2021002",
              "semester": "5th",
              "batch": "2021",
              "department": "Political Science",
            },
            "PSCI2020001": {
              "name": "Muneeb Khan",
              "rollNumber": "PSCI2020001",
              "semester": "7th",
              "batch": "2020",
              "department": "Political Science",
            },
            "PSCI2020002": {
              "name": "Iqra Shaikh",
              "rollNumber": "PSCI2020002",
              "semester": "7th",
              "batch": "2020",
              "department": "Political Science",
            },
          },
        },
        "Zoology": {
          "students": {
            "ZO2023001": {
              "name": "Haris Qureshi",
              "rollNumber": "ZO2023001",
              "semester": "1st",
              "batch": "2023",
              "department": "Zoology",
            },
            "ZO2023002": {
              "name": "Nimra Hassan",
              "rollNumber": "ZO2023002",
              "semester": "1st",
              "batch": "2023",
              "department": "Zoology",
            },
            "ZO2022001": {
              "name": "Owais Khan",
              "rollNumber": "ZO2022001",
              "semester": "3rd",
              "batch": "2022",
              "department": "Zoology",
            },
            "ZO2022002": {
              "name": "Sadia Iqbal",
              "rollNumber": "ZO2022002",
              "semester": "3rd",
              "batch": "2022",
              "department": "Zoology",
            },
            "ZO2021001": {
              "name": "Umer Farooq",
              "rollNumber": "ZO2021001",
              "semester": "5th",
              "batch": "2021",
              "department": "Zoology",
            },
            "ZO2021002": {
              "name": "Amina Riaz",
              "rollNumber": "ZO2021002",
              "semester": "5th",
              "batch": "2021",
              "department": "Zoology",
            },
            "ZO2020001": {
              "name": "Adil Hussain",
              "rollNumber": "ZO2020001",
              "semester": "7th",
              "batch": "2020",
              "department": "Zoology",
            },
            "ZO2020002": {
              "name": "Hira Malik",
              "rollNumber": "ZO2020002",
              "semester": "7th",
              "batch": "2020",
              "department": "Zoology",
            },
          },
        },
        "Botany": {
          "students": {
            "BO2023001": {
              "name": "Arslan Ahmed",
              "rollNumber": "BO2023001",
              "semester": "1st",
              "batch": "2023",
              "department": "Botany",
            },
            "BO2023002": {
              "name": "Saba Noor",
              "rollNumber": "BO2023002",
              "semester": "1st",
              "batch": "2023",
              "department": "Botany",
            },
            "BO2022001": {
              "name": "Nouman Riaz",
              "rollNumber": "BO2022001",
              "semester": "3rd",
              "batch": "2022",
              "department": "Botany",
            },
            "BO2022002": {
              "name": "Zoya Malik",
              "rollNumber": "BO2022002",
              "semester": "3rd",
              "batch": "2022",
              "department": "Botany",
            },
            "BO2021001": {
              "name": "Hamza Iqbal",
              "rollNumber": "BO2021001",
              "semester": "5th",
              "batch": "2021",
              "department": "Botany",
            },
            "BO2021002": {
              "name": "Laiba Fatima",
              "rollNumber": "BO2021002",
              "semester": "5th",
              "batch": "2021",
              "department": "Botany",
            },
            "BO2020001": {
              "name": "Shahid Raza",
              "rollNumber": "BO2020001",
              "semester": "7th",
              "batch": "2020",
              "department": "Botany",
            },
            "BO2020002": {
              "name": "Iqra Hussain",
              "rollNumber": "BO2020002",
              "semester": "7th",
              "batch": "2020",
              "department": "Botany",
            },
          },
        },
        "Pashtu": {
          "students": {
            "PA2023001": {
              "name": "Junaid Khan",
              "rollNumber": "PA2023001",
              "semester": "1st",
              "batch": "2023",
              "department": "Pashtu",
            },
            "PA2023002": {
              "name": "Gulalai Bibi",
              "rollNumber": "PA2023002",
              "semester": "1st",
              "batch": "2023",
              "department": "Pashtu",
            },
            "PA2022001": {
              "name": "Ismail Khan",
              "rollNumber": "PA2022001",
              "semester": "3rd",
              "batch": "2022",
              "department": "Pashtu",
            },
            "PA2022002": {
              "name": "Shazia Noor",
              "rollNumber": "PA2022002",
              "semester": "3rd",
              "batch": "2022",
              "department": "Pashtu",
            },
            "PA2021001": {
              "name": "Rashid Ahmad",
              "rollNumber": "PA2021001",
              "semester": "5th",
              "batch": "2021",
              "department": "Pashtu",
            },
            "PA2021002": {
              "name": "Mehwish Khan",
              "rollNumber": "PA2021002",
              "semester": "5th",
              "batch": "2021",
              "department": "Pashtu",
            },
            "PA2020001": {
              "name": "Saleem Jan",
              "rollNumber": "PA2020001",
              "semester": "7th",
              "batch": "2020",
              "department": "Pashtu",
            },
            "PA2020002": {
              "name": "Shahnaz Bibi",
              "rollNumber": "PA2020002",
              "semester": "7th",
              "batch": "2020",
              "department": "Pashtu",
            },
          },
        },
        "Urdu": {
          "students": {
            "UR2023001": {
              "name": "Aslam Qureshi",
              "rollNumber": "UR2023001",
              "semester": "1st",
              "batch": "2023",
              "department": "Urdu",
            },
            "UR2023002": {
              "name": "Samina Parveen",
              "rollNumber": "UR2023002",
              "semester": "1st",
              "batch": "2023",
              "department": "Urdu",
            },
            "UR2022001": {
              "name": "Jawad Ali",
              "rollNumber": "UR2022001",
              "semester": "3rd",
              "batch": "2022",
              "department": "Urdu",
            },
            "UR2022002": {
              "name": "Hira Fatima",
              "rollNumber": "UR2022002",
              "semester": "3rd",
              "batch": "2022",
              "department": "Urdu",
            },
            "UR2021001": {
              "name": "Kamran Raza",
              "rollNumber": "UR2021001",
              "semester": "5th",
              "batch": "2021",
              "department": "Urdu",
            },
            "UR2021002": {
              "name": "Nida Ahmed",
              "rollNumber": "UR2021002",
              "semester": "5th",
              "batch": "2021",
              "department": "Urdu",
            },
            "UR2020001": {
              "name": "Waheed Iqbal",
              "rollNumber": "UR2020001",
              "semester": "7th",
              "batch": "2020",
              "department": "Urdu",
            },
            "UR2020002": {
              "name": "Sana Gul",
              "rollNumber": "UR2020002",
              "semester": "7th",
              "batch": "2020",
              "department": "Urdu",
            },
          },
        },
        "Mathematics": {
          "students": {
            "MA2023001": {
              "name": "Zohaib Ali",
              "rollNumber": "MA2023001",
              "semester": "1st",
              "batch": "2023",
              "department": "Mathematics",
            },
            "MA2023002": {
              "name": "Iqra Noor",
              "rollNumber": "MA2023002",
              "semester": "1st",
              "batch": "2023",
              "department": "Mathematics",
            },
            "MA2022001": {
              "name": "Hammad Khan",
              "rollNumber": "MA2022001",
              "semester": "3rd",
              "batch": "2022",
              "department": "Mathematics",
            },
            "MA2022002": {
              "name": "Saira Javed",
              "rollNumber": "MA2022002",
              "semester": "3rd",
              "batch": "2022",
              "department": "Mathematics",
            },
            "MA2021001": {
              "name": "Shahzaib Ahmed",
              "rollNumber": "MA2021001",
              "semester": "5th",
              "batch": "2021",
              "department": "Mathematics",
            },
            "MA2021002": {
              "name": "Fizza Khan",
              "rollNumber": "MA2021002",
              "semester": "5th",
              "batch": "2021",
              "department": "Mathematics",
            },
            "MA2020001": {
              "name": "Adil Raza",
              "rollNumber": "MA2020001",
              "semester": "7th",
              "batch": "2020",
              "department": "Mathematics",
            },
            "MA2020002": {
              "name": "Maryam Shah",
              "rollNumber": "MA2020002",
              "semester": "7th",
              "batch": "2020",
              "department": "Mathematics",
            },
          },
        },
        "Chemistry": {
          "students": {
            "CH2023001": {
              "name": "Tariq Ali",
              "rollNumber": "CH2023001",
              "semester": "1st",
              "batch": "2023",
              "department": "Chemistry",
            },
            "CH2023002": {
              "name": "Sadia Riaz",
              "rollNumber": "CH2023002",
              "semester": "1st",
              "batch": "2023",
              "department": "Chemistry",
            },
            "CH2022001": {
              "name": "Noman Qureshi",
              "rollNumber": "CH2022001",
              "semester": "3rd",
              "batch": "2022",
              "department": "Chemistry",
            },
            "CH2022002": {
              "name": "Maham Ali",
              "rollNumber": "CH2022002",
              "semester": "3rd",
              "batch": "2022",
              "department": "Chemistry",
            },
            "CH2021001": {
              "name": "Ubaid Khan",
              "rollNumber": "CH2021001",
              "semester": "5th",
              "batch": "2021",
              "department": "Chemistry",
            },
            "CH2021002": {
              "name": "Saira Fatima",
              "rollNumber": "CH2021002",
              "semester": "5th",
              "batch": "2021",
              "department": "Chemistry",
            },
            "CH2020001": {
              "name": "Waqar Ali",
              "rollNumber": "CH2020001",
              "semester": "7th",
              "batch": "2020",
              "department": "Chemistry",
            },
            "CH2020002": {
              "name": "Amna Bibi",
              "rollNumber": "CH2020002",
              "semester": "7th",
              "batch": "2020",
              "department": "Chemistry",
            },
          },
        },
        "AI": {
          "students": {
            "AI2023001": {
              "name": "Zain Ali",
              "rollNumber": "AI2023001",
              "semester": "1st",
              "batch": "2023",
              "department": "AI",
            },
            "AI2023002": {
              "name": "Hira Shah",
              "rollNumber": "AI2023002",
              "semester": "1st",
              "batch": "2023",
              "department": "AI",
            },
            "AI2022001": {
              "name": "Farhan Malik",
              "rollNumber": "AI2022001",
              "semester": "3rd",
              "batch": "2022",
              "department": "AI",
            },
            "AI2022002": {
              "name": "Laiba Ahmed",
              "rollNumber": "AI2022002",
              "semester": "3rd",
              "batch": "2022",
              "department": "AI",
            },
            "AI2021001": {
              "name": "Adeel Khan",
              "rollNumber": "AI2021001",
              "semester": "5th",
              "batch": "2021",
              "department": "AI",
            },
            "AI2021002": {
              "name": "Sana Qureshi",
              "rollNumber": "AI2021002",
              "semester": "5th",
              "batch": "2021",
              "department": "AI",
            },
            "AI2020001": {
              "name": "Waseem Iqbal",
              "rollNumber": "AI2020001",
              "semester": "7th",
              "batch": "2020",
              "department": "AI",
            },
            "AI2020002": {
              "name": "Kiran Fatima",
              "rollNumber": "AI2020002",
              "semester": "7th",
              "batch": "2020",
              "department": "AI",
            },
          },
        },
        "Physics": {
          "students": {
            "PH2023001": {
              "name": "Saad Ali",
              "rollNumber": "PH2023001",
              "semester": "1st",
              "batch": "2023",
              "department": "Physics",
            },
            "PH2023002": {
              "name": "Nida Malik",
              "rollNumber": "PH2023002",
              "semester": "1st",
              "batch": "2023",
              "department": "Physics",
            },
            "PH2022001": {
              "name": "Hassan Riaz",
              "rollNumber": "PH2022001",
              "semester": "3rd",
              "batch": "2022",
              "department": "Physics",
            },
            "PH2022002": {
              "name": "Mariam Noor",
              "rollNumber": "PH2022002",
              "semester": "3rd",
              "batch": "2022",
              "department": "Physics",
            },
            "PH2021001": {
              "name": "Yasir Khan",
              "rollNumber": "PH2021001",
              "semester": "5th",
              "batch": "2021",
              "department": "Physics",
            },
            "PH2021002": {
              "name": "Fatima Sheikh",
              "rollNumber": "PH2021002",
              "semester": "5th",
              "batch": "2021",
              "department": "Physics",
            },
            "PH2020001": {
              "name": "Adnan Ali",
              "rollNumber": "PH2020001",
              "semester": "7th",
              "batch": "2020",
              "department": "Physics",
            },
            "PH2020002": {
              "name": "Sadia Khan",
              "rollNumber": "PH2020002",
              "semester": "7th",
              "batch": "2020",
              "department": "Physics",
            },
          },
        },
      },
    
  };

  UploadDataScreen({super.key});

  Future<void> uploadData(BuildContext context) async {
    print('Data upload started');
    final firestore = FirebaseFirestore.instance;

    try {
      final departments = data["departments"] as Map<String, dynamic>;

      // First, create all department documents
      for (var deptName in departments.keys) {
        print('Creating department: $deptName');

        // Create the department document first
        await firestore
            .collection("departments")
            .doc(deptName)
            .set({
              'name': deptName,
              'createdAt': FieldValue.serverTimestamp(),
              'totalStudents': 0, // Initialize student count
            })
            .catchError((error) {
              print('Error creating department $deptName: $error');
              throw error;
            });

        print('Department $deptName created successfully');
      }

      // Then, add students to each department's subcollection
      for (var deptName in departments.keys) {
        final students =
            departments[deptName]["students"] as Map<String, dynamic>;
        int studentCount = 0;

        print('Uploading students for department: $deptName');

        for (var rollNo in students.keys) {
          final studentData = students[rollNo];

          print('Uploading student: $rollNo');

          await firestore
              .collection("departments")
              .doc(deptName)
              .collection("students")
              .doc(rollNo)
              .set(studentData)
              .catchError((error) {
                print('Error uploading student $rollNo: $error');
                throw error;
              });

          studentCount++;
          print('Student $rollNo uploaded successfully');
        }

        // Update the student count in the department document
        await firestore.collection("departments").doc(deptName).update({
          'totalStudents': studentCount,
        });

        print('Uploaded $studentCount students for department: $deptName');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("✅ Data uploaded successfully!"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print('Upload error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error: $e"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Data to Firebase"),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_upload, size: 64, color: Colors.blue[700]),
            SizedBox(height: 20),
            Text(
              'Upload Dummy Data',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'This will create departments and students collections',
              style: TextStyle(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => uploadData(context),
              icon: const Icon(Icons.cloud_upload),
              label: const Text("Upload Data"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Note: Make sure your Firebase rules allow writes',
              style: TextStyle(
                color: Colors.orange[700],
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
