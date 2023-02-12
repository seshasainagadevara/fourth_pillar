import 'package:flutter/material.dart';

import 'package:fourth_pillar/app_constants.dart';
import 'package:fourth_pillar/engine/searchController/search_controller.dart';
import 'package:fourth_pillar/visuals/screens/home/profileScreen/profile_screen.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchController _searchController =
      Get.put<SearchController>(SearchController());

  final TextEditingController _searchTextEditingController =
      TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.clearUsers();
    _searchTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: TextFormField(
          controller: _searchTextEditingController,
          onFieldSubmitted: (value) {
            // _searchController.clearUsers();
            _searchController.searchUser(value.trim());
          },
          decoration: const InputDecoration(
              filled: false,
              hintText: 'Search',
              hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.white,
              )),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Obx(
          () => ListView.builder(
              itemCount: _searchController.searchedUsers.length,
              itemBuilder: (context, index) {
                var usr = _searchController.searchedUsers[index];
                return InkWell(
                  onTap: () {
                    Get.to(() => ProfileScreen(uid: usr.uid));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(usr.profilePic!),
                    ),
                    title: Text(
                      usr.userName,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
