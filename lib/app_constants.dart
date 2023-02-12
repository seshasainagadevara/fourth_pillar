import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fourth_pillar/engine/firebase_handlers/firebase_auth_controller.dart';
import 'package:fourth_pillar/visuals/screens/home/addPostScreen/add_post_screen.dart';
import 'package:fourth_pillar/visuals/screens/home/exploreScreen/explore_screen.dart';
import 'package:fourth_pillar/visuals/screens/home/profileScreen/profile_screen.dart';
import 'package:fourth_pillar/visuals/screens/home/searchScreen/search_screen.dart';

const Color backgroundColor = Colors.black54;
const Color secondaryColor = Colors.pink;
const Color teritaryColor = Colors.grey;

//Firebase

FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestoreInstance = FirebaseFirestore.instance;
FirebaseStorage firebaseStorageInstance = FirebaseStorage.instance;

//AuthController

FirebaseAuthController firebaseAuthController = FirebaseAuthController.instance;

//screens

final homePages = [
  const ExploreVideoScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('inbox'),
  ProfileScreen(uid: firebaseAuthController.user.uid)
];
