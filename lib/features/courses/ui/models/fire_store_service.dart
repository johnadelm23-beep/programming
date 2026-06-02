import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/course.dart';

class CoursesService {
  final _db = FirebaseFirestore.instance;

  Stream<List<CourseModel>> getCourses() {
    return _db.collection("courses").snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => CourseModel.fromJson(doc.data(), doc.id))
          .toList();
    });
  }

  Future<void> addCourse(CourseModel course) async {
    final doc = _db.collection("courses").doc();
    await doc.set(course.copyWith(id: doc.id).toJson());
  }

  Future<void> deleteCourse(String id) async {
    await _db.collection("courses").doc(id).delete();
  }
}
