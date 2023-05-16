import 'package:flutter/material.dart';
import 'package:online_mentor/core/colors.dart';
import 'package:online_mentor/core/enums.dart';
import 'package:online_mentor/models/user/user.dart';
import 'package:online_mentor/widgets/bottom_sheet/primary_bottom_sheet.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TeacherCard extends StatelessWidget {
  final Teacher teacher;

  const TeacherCard({
    Key? key,
    required this.teacher,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showTeacherInfo(context),
      child: Card(
        child: ListTile(
          leading: (teacher.avatar ?? '').isNotEmpty
              ? Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    teacher.avatar!,
                    fit: BoxFit.fill,
                  ),
                )
              : Container(
                  width: 50,
                  height: 50,
                  child: Icon(Icons.person),
                ),
          title: Text(
            '${teacher.name} ${teacher.surname}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Icon(Icons.library_books),
                    Text(
                      teacher.educationType?.label ?? 'Нет данных',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Icon(
                      Icons.email_outlined,
                      color: Colors.blue,
                    ),
                    Text(
                      teacher.email ?? '',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Customize the ListTile as per your needs
        ),
      ),
    );
  }

  _showTeacherInfo(BuildContext context) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        builder: (context) => PrimaryBottomSheet(
          contentPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  teacher.avatar != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(teacher.avatar ?? ''),
                        )
                      : Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person),
                            ],
                          ),
                        ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${teacher.name} ${teacher.surname}',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                '${teacher.age ?? 0} Лет',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.green,
                              ),
                              Text(
                                teacher.phoneNumber ?? '',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.email_outlined,
                                color: Colors.blue,
                              ),
                              Text(
                                teacher.email,
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              ListTile(
                leading: Text('Образование'),
                trailing: Text(teacher.educationType?.label ?? 'Нет данных'),
              ),
              ListTile(
                leading: Text('Специализация'),
                trailing: Text(teacher.specialty?.name ?? 'Нет данных'),
              ),
              ListTile(
                leading: Text('Специализация'),
                trailing: Text(teacher.specialty?.name ?? 'Нет данных'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () async {
                      if (!await launchUrlString(
                          'tel:${teacher.phoneNumber}')) {
                        throw Exception(
                            'Could not launch tel:${teacher.phoneNumber}');
                      }
                    },
                    child: Text('Позвонить'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.lightBlue,
                    ),
                    onPressed: () async {
                      if (!await launchUrlString('mailto:${teacher.email}')) {
                        throw Exception(
                            'Could not launch mailto:${teacher.phoneNumber}');
                      }
                    },
                    child: Text('Написать на почту'),
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
