import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final providerOfFirebaseAuth = Provider<FirebaseAuth>(
  (ref) {
    // FirebaseAuth.instance.useAuthEmulator("10.0.2.2", 9099);
    return FirebaseAuth.instance;
  },
);

final providerOfFireStore = Provider<FirebaseFirestore>(
  (ref) {
    // FirebaseFirestore.instance.useFirestoreEmulator("10.0.2.2", 8080);
    return FirebaseFirestore.instance;
  },
);

final providerOfGoogleAuth = Provider<GoogleSignIn>(
  (ref) {
    return GoogleSignIn();
  },
);

final providerOfFireStorage = Provider<FirebaseStorage>(
  (ref) {
    // FirebaseStorage.instance.useStorageEmulator("10.0.2.2", 9199);
    return FirebaseStorage.instance;
  },
);

final providerOfRealTimeDatabase = Provider<FirebaseDatabase>(
  (ref) {
    // FirebaseDatabase.instance.useDatabaseEmulator("10.0.2.2", 9000);
    return FirebaseDatabase.instance;
  },
);
