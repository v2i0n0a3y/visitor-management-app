import 'package:visitor_management_app/domain/entities/visitor.dart';
import 'package:visitor_management_app/domain/repositories/visitor_repository.dart';

class AddVisitor {
  final VisitorRepository repository;

  AddVisitor(this.repository);

  Future<void> call(Visitor visitor) {
    return repository.addVisitor(visitor);
  }
}

