import 'package:visitor_management_app/domain/entities/visitor.dart';
import 'package:visitor_management_app/domain/repositories/visitor_repository.dart';

class GetVisitors {
  final VisitorRepository repository;

  GetVisitors(this.repository);

  Stream<List<Visitor>> call(String watchmanEmail) {
    return repository.getVisitors(watchmanEmail);
  }
}

