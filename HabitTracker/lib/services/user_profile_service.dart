// ignore_for_file: unnecessary_cast

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfile {
  final String name;
  final String email;

  UserProfile({
    required this.name,
    required this.email,
  });

  factory UserProfile.fromMap(Map<dynamic, dynamic> map) {
    return UserProfile(
      name: (map['name'] ?? '') as String,
      email: (map['email'] ?? '') as String,
    );
  }
}

class UserProfileService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance;

  Stream<UserProfile?> watchProfile() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return const Stream.empty();

    final ref = _db.ref('users/$uid/profile');

    return ref.onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null || data is! Map) return null;
      return UserProfile.fromMap(data as Map<dynamic, dynamic>);
    });
  }
}

final userProfileServiceProvider = Provider<UserProfileService>((ref) {
  return UserProfileService();
});

final userProfileProvider = StreamProvider<UserProfile?>((ref) {
  final service = ref.watch(userProfileServiceProvider);
  return service.watchProfile();
});
