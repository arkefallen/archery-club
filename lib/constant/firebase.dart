import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future getPostCollection() async {
    CollectionReference _posts = _firebaseFirestore.collection('posts');

    return _posts;
  }

  Future<QuerySnapshot<Object?>> getPostSnapshot() async {
    QuerySnapshot _postsSnapshot = await getPostCollection();

    return _postsSnapshot;
  }
}
