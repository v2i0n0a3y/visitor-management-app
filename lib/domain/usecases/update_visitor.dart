import 'package:visitor_management_app/domain/entities/visitor.dart';
import 'package:visitor_management_app/domain/repositories/visitor_repository.dart';

class UpdateVisitor {
  final VisitorRepository repository;

  UpdateVisitor(this.repository);

  Future<void> call(Visitor visitor) {
    return repository.updateVisitor(visitor);
  }
}

