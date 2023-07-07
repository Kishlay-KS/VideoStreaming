import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktokclone/controller/search_controller.dart';
import 'package:tiktokclone/model/User.dart';
import 'package:tiktokclone/view/screens/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  TextEditingController searchQuery = TextEditingController();

  final mySearchController searchController = Get.put(mySearchController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: TextFormField(
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: "Search Username"),
            controller: searchQuery,
            onChanged: (value) {
              searchController.searchmyUserFunction(value);
            },
          ),
        ),
        body: searchController.searchList.isEmpty
            ? Center(
                child: Text("Search Users!"),
              )
            : ListView.builder(
                itemCount: searchController.searchList.length,
                itemBuilder: (context, index) {
                  myUser user = searchController.searchList[index];

                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfileScreen(uid: user.uid)));
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.profilePic),
                    ),
                    title: Text(user.name),
                  );
                }),
      );
    });
  }
}
