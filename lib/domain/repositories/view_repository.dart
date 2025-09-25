import 'package:work_assistent_mob/domain/entities/view.dart';

abstract class ViewRepository {
  Future<ViewEntity> createView(int job_id);
}