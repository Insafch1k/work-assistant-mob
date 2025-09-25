import 'package:work_assistent_mob/domain/entities/view.dart';
import 'package:work_assistent_mob/domain/repositories/view_repository.dart';

class CreateView {
  final ViewRepository repository;

  const CreateView(this.repository);

  Future<ViewEntity> execute(int jobId) async {
    return await repository.createView(jobId);
  }

  Future<ViewEntity> call(int jobId) async => execute(jobId);
}