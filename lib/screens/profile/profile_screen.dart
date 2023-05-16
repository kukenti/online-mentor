import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_mentor/blocs/auth/auth_cubit.dart';
import 'package:online_mentor/blocs/profile/profile_cubit.dart';
import 'package:online_mentor/blocs/profile/profile_state.dart';
import 'package:online_mentor/models/user/user.dart';
import 'package:online_mentor/screens/login_screen/login_screen.dart';
import 'package:online_mentor/screens/profile/profile_edit_screen.dart';
import 'package:online_mentor/service_locator.dart';
import 'package:online_mentor/widgets/bottom_sheet/primary_bottom_sheet.dart';
import 'package:online_mentor/widgets/image_caputer_menu.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    getIt<ProfileCubit>().fetchUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final User? user = state.user;
          if (user != null) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _uploadAvatar(context),
                        child: user.avatar != null
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    NetworkImage(user.avatar ?? ''),
                              )
                            : Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.upload),
                                    Text('upload_image'),
                                  ],
                                ),
                              ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${user.name} ${user.surname}',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.email_outlined,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    user.email,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEditScreen()));
                    },
                    child: Text('Edit Profile'),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context).signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                          (route) => false,
                      );
                    },
                    child: Text('Logout'),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void _uploadAvatar(BuildContext context) => showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        builder: (context) => PrimaryBottomSheet(
          child: ImageCaptureMenu(
            onSelectImage: getIt<ProfileCubit>().changeAvatar,
            onSelectImages: (files) =>
                getIt<ProfileCubit>().changeAvatar(files.first),
          ),
        ),
      );
}
