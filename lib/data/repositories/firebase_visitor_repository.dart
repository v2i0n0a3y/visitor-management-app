import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visitor_management_app/domain/entities/visitor.dart';
import 'package:visitor_management_app/domain/repositories/visitor_repository.dart';

class FirebaseVisitorRepository implements VisitorRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Visitor>> getVisitors(String watchmanEmail) {
    return _firestore
        .collection('visitors')
        .where('watchmanEmail', isEqualTo: watchmanEmail)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Visitor.fromFirestore(doc)).toList();
    });
  }

  @override
  Future<void> addVisitor(Visitor visitor) {
    return _firestore.collection('visitors').add(visitor.toFirestore());
  }

  @override
  Future<void> updateVisitor(Visitor visitor) {
    return _firestore.collection('visitors').doc(visitor.id).update(visitor.toFirestore());
  }

  @override
  Future<void> deleteVisitor(String id) {
    return _firestore.collection('visitors').doc(id).delete();
  }
}

