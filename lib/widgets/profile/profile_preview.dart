import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbla_app/screens/profile/profile_detail_screen.dart';
import 'package:flutter/material.dart';

class ProfilePreview extends StatelessWidget {
  final String userId;

  ProfilePreview(this.userId);

  void selectProfile(BuildContext context, DocumentSnapshot userDocument) {
    Navigator.of(context)
        .pushNamed(
      ProfileDetail.routeName,
      arguments: userDocument,
    )
        .then((result) {
      if (result != null) {}
    });
  } // Builds a profile preview for user as specified in userID. The preview contains a picture, name, and school.

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          Firestore.instance.collection('users').document(userId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          ); // Loading, user data being retrieved.
        }
        final user = snapshot.data;
        return InkWell(
          onTap: () {
            selectProfile(context, user);
          },
          child: Card(
            elevation: 0,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(user['image_url']),
                      ),
                    ), // Positioning and placement of user profile picture.
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              child: Text(
                                user['username'], // Displays username under profile picture.
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              padding: EdgeInsets.all(15),
                              child: Text(
                                user['school'], // Displays school of user
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                  color: Colors.black,
                  height: 0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
