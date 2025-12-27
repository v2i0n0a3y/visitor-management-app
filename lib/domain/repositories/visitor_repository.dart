import 'package:visitor_management_app/domain/entities/visitor.dart';

abstract class VisitorRepository {
  Stream<List<Visitor>> getVisitors(String watchmanEmail);
  Future<void> addVisitor(Visitor visitor);
  Future<void> updateVisitor(Visitor visitor);
  Future<void> deleteVisitor(String id);
}

