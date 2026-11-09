
  import 'dart:convert';
  import 'package:flutter/material.dart';
  import 'student.dart';

  void main() {
    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StudentPage(),
      );
    }
  }

  class StudentPage extends StatefulWidget {
    const StudentPage({super.key});

    @override
    State<StudentPage> createState() => _StudentPageState();
  }

  class _StudentPageState extends State<StudentPage> {
    final List<Student> students = [
      Student(id: 1, name: 'Raj', course: 'CSE'),
    ];

    final TextEditingController nameController =
        TextEditingController();

    final TextEditingController courseController =
        TextEditingController();

    String jsonOutput = '';

    void addStudent() {
      if (nameController.text.isEmpty ||
          courseController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Enter all student details'),
          ),
        );
        return;
      }

      setState(() {
        students.add(
          Student(
            id: students.length + 1,
            name: nameController.text,
            course: courseController.text,
          ),
        );

        nameController.clear();
        courseController.clear();
      });
    }

    void convertToJson() {
      List<Map<String, dynamic>> data =
          students.map((student) => student.toJson()).toList();

      String jsonString = jsonEncode(data);

      List<dynamic> decodedData = jsonDecode(jsonString);

      List<Student> newStudents = decodedData
          .map((item) => Student.fromJson(item))
          .toList();

      setState(() {
        jsonOutput = const JsonEncoder.withIndent('  ')
            .convert(newStudents.map((s) => s.toJson()).toList());
      });

      print(jsonString);
      print(newStudents.first.name);
    }

    @override
    void dispose() {
      nameController.dispose();
      courseController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Student Management'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Student Name',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: courseController,
                decoration: const InputDecoration(
                  labelText: 'Course',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: addStudent,
                child: const Text('Add Student'),
              ),

              ElevatedButton(
                onPressed: convertToJson,
                child: const Text('Convert to JSON'),
              ),

              const SizedBox(height: 10),

              const Text(
                'Student List',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(students[index].name),
                        subtitle: Text(students[index].course),
                        trailing: Text(
                          'ID: ${students[index].id}',
                        ),
                      ),
                    );
                  },
                ),
              ),

              if (jsonOutput.isNotEmpty)
                Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                      color: Colors.blue.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SelectableText(jsonOutput),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    }
  }
