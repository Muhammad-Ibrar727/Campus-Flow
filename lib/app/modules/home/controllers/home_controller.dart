import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Department {
  final String name;
  final IconData icon;
  final Color color;

  Department(this.name, this.icon, {this.color = Colors.blue});
}

class HomeController extends GetxController {
  final departments = <Department>[
    Department("Pak Study", Icons.public, color: Colors.indigo), // 🌍
    Department("Computer Science", Icons.computer, color: Colors.blue), // 💻
    Department("Statistics", Icons.bar_chart, color: Colors.green), // 📊
    Department("Islamic Study", Icons.auto_stories, color: Colors.teal), // 📖
    Department("English", Icons.menu_book, color: Colors.deepPurple), // 📘
    Department("Economics", Icons.attach_money, color: Colors.amber), // 💰
    Department("Political Science", Icons.gavel, color: Colors.redAccent), // ⚖️
    Department("Zoology", Icons.pets, color: Colors.brown), // 🐾
    Department("Botany", Icons.grass, color: Colors.green), // 🌱
    Department("Pashtu", Icons.translate, color: Colors.orange), // 📝
    Department("Urdu", Icons.language, color: Colors.pink), // ✍️
    Department("Mathematics", Icons.calculate, color: Colors.blueGrey), // ➗
    Department("Chemistry", Icons.science, color: Colors.deepOrange), // ⚗️
    Department("AI", Icons.memory, color: Colors.cyan), // 🤖
    Department("Physics", Icons.bolt, color: Colors.yellow.shade700), // ⚡
  ].obs;

  // Search Query
  var searchQuery = "".obs;

  // Filtered Departments
  List<Department> get filteredDepartments {
    if (searchQuery.isEmpty) return departments;
    return departments
        .where(
          (d) => d.name.toLowerCase().contains(searchQuery.value.toLowerCase()),
        )
        .toList();
  }

  var title = "Home".obs;
}
