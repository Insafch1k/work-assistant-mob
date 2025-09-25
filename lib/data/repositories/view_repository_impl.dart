import 'package:work_assistent_mob/data/datasources/remote/view_remote_data_source.dart';
import 'package:work_assistent_mob/domain/entities/view.dart';
import 'package:work_assistent_mob/domain/repositories/view_repository.dart';

class ViewRepositoryImpl implements ViewRepository {
  final ViewDataSource dataSource;

  ViewRepositoryImpl({required this.dataSource});

  @override
  Future<ViewEntity> createView(int job_id) async { 
    final createdViewModel = await dataSource.createView(job_id);
    return createdViewModel.toEntity();
  }
}