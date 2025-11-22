import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:work_assistent_mob/data/datasources/local/auth_local_data_source_impl.dart';
import 'package:work_assistent_mob/data/datasources/remote/advertisement_remote_data_source.dart';
import 'package:work_assistent_mob/data/datasources/remote/auth_remote_data_source_impl.dart';
import 'package:work_assistent_mob/data/datasources/remote/login_remote_data_source_impl.dart';
import 'package:work_assistent_mob/data/datasources/remote/resume_remote_data_source.dart';
import 'package:work_assistent_mob/data/datasources/remote/view_remote_data_source.dart';
import 'package:work_assistent_mob/data/repositories/advertisement_repository_impl.dart';
import 'package:work_assistent_mob/data/repositories/auth_repositiry_impl.dart';
import 'package:http/http.dart' as http;
import 'package:work_assistent_mob/data/repositories/login_repository_impl.dart';
import 'package:work_assistent_mob/data/repositories/resume_repository_impl.dart';
import 'package:work_assistent_mob/data/repositories/view_repository_impl.dart';
import 'package:work_assistent_mob/domain/usecases/create_advertisement.dart';
import 'package:work_assistent_mob/domain/usecases/create_favorite_advertisement.dart';
import 'package:work_assistent_mob/domain/usecases/create_view.dart';
import 'package:work_assistent_mob/domain/usecases/delete_advertisement.dart';
import 'package:work_assistent_mob/domain/usecases/delete_favorite_advertisement.dart';
import 'package:work_assistent_mob/domain/usecases/delete_resume.dart';
import 'package:work_assistent_mob/domain/usecases/get_advertisements.dart';
import 'package:work_assistent_mob/domain/usecases/get_advertisements_from_history.dart';
import 'package:work_assistent_mob/domain/usecases/get_detailed_advertisement.dart';
import 'package:work_assistent_mob/domain/usecases/get_employer_advertisements.dart';
import 'package:work_assistent_mob/domain/usecases/get_employer_resume.dart';
import 'package:work_assistent_mob/domain/usecases/get_favorite_advertisements.dart';
import 'package:work_assistent_mob/domain/usecases/get_filtered_advertisements.dart';
import 'package:work_assistent_mob/domain/usecases/get_resumes.dart';
import 'package:work_assistent_mob/domain/usecases/redo_employer_resume.dart';
import 'package:work_assistent_mob/domain/usecases/redo_resume.dart';
import 'package:work_assistent_mob/domain/usecases/reduct_advertisement.dart';
import 'package:work_assistent_mob/domain/usecases/send_resume.dart';
import 'package:work_assistent_mob/presentation/experemental/avtorization_page.dart';
import 'package:work_assistent_mob/presentation/experemental/change_password_page.dart';
import 'package:work_assistent_mob/presentation/experemental/forgot_password_page.dart';
import 'package:work_assistent_mob/presentation/pages/chat_page.dart';
import 'package:work_assistent_mob/presentation/pages/create_resume_page.dart';
import 'package:work_assistent_mob/presentation/pages/login_page.dart';
import 'package:work_assistent_mob/presentation/pages/profile_page.dart';
import 'package:work_assistent_mob/presentation/pages/recreate_resume_page.dart';
import 'package:work_assistent_mob/presentation/pages/work_page.dart';
import 'package:work_assistent_mob/presentation/providers/advertisement_provider.dart';
import 'package:work_assistent_mob/presentation/providers/auth_provider.dart';
import 'package:work_assistent_mob/presentation/providers/login_provider.dart';
import 'package:work_assistent_mob/presentation/providers/resume_provider.dart';
import 'package:work_assistent_mob/presentation/providers/view_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = FlutterSecureStorage();
  final httpClient = http.Client();

  print('1. HTTP Client created: ${httpClient != null}');

  final authLocalDataSource = AuthLocalDataSourceImpl(storage);

  // Auth dependencies
  final authRemoteDataSource = AuthRemoteDataSourceImpl(client: httpClient);
  final authRepository = AuthRepositoryImpl(
    remoteDataSource: authRemoteDataSource,
    localDataSource: authLocalDataSource,
  );
  final authProvider = AuthProvider(repository: authRepository);

  final loginRemoteDataSource = LoginRemoteDataSourceImpl(client: httpClient, localDataSource: authLocalDataSource);

  final loginRepository = LoginRepositoryImpl(
    remoteDataSource: loginRemoteDataSource,
    localDataSource: authLocalDataSource,
  );

  final loginProvider = LoginProvider(repository: loginRepository); // Обычный конструктор!

  // View dependencies
  final viewRemoteDataSource = ViewRemoteDataSource(
    client: httpClient,
    loginProvider: loginProvider,
  );
  final viewRepository = ViewRepositoryImpl(dataSource: viewRemoteDataSource);
  final viewProvider = ViewProvider(
    createViewUseCase: CreateView(viewRepository),
  );

  // Advertisement dependencies
  final adsDataSource = AdvertisementRemoteDataSource(
    client: httpClient,
    loginProvider: loginProvider,
  );
  final adsRepository = AdvertisementRepositoryImpl(
    remoteDataSource: adsDataSource,
  );

  final advertisementProvider = AdvertisementProvider(
    getAdvertisements: GetAdvertisements(adsRepository),
    getFilteredAdvertisements: GetFilteredAdvertisements(adsRepository),
    getEmployersAdvertisements: GetEmployerAdvertisements(adsRepository),
    getDetailedAdvertisement: GetDetailedAdvertisement(adsRepository),
    getAdvertisementsFromHistory: GetAdvertisementsFromHistory(adsRepository),
    addAdvertisementToFavorite: AddAdvertisementToFavorite(adsRepository),
    deleteAdvertisementFromFavorite: DeleteAdvertisementFromFavorite(adsRepository),
    getFavoriteAdvertisements: GetFavoriteAdvertisements(adsRepository),
    createAdvertisement: CreateAdvertisement(repository: adsRepository),
    reductAdvertisement: ReductAdvertisement(repository: adsRepository),
    deleteAdvertisement: DeleteAdvertisement(repository: adsRepository)
  );

  // Resume dependencies
  final resumeDataSource = ResumeRemoteDataSourceImpl(
    client: httpClient,
    loginProvider: loginProvider,
  );
  final resumeRepository = ResumeRepositoryImpl(
    remoteDataSource: resumeDataSource,
  );
  final resumeProvider = ResumeProvider(
    sendResumeUseCase: SendResume(repository: resumeRepository),
    getResumesUseCase: GetResumes(repository: resumeRepository),
    getEmployerResumesUseCase: GetEmployerResumes(repository: resumeRepository),
    redoResumeUseCase: RedoResume(repository: resumeRepository),
    redoEmployerResumeUseCase: RedoEmployerResume(repository: resumeRepository),
    deleteResumeUseCase: DeleteResume(repository: resumeRepository),
  );

  await authProvider.loadCachedToken();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProvider.value(value: advertisementProvider),
        ChangeNotifierProvider.value(value: loginProvider),
        ChangeNotifierProvider.value(value: viewProvider),
        ChangeNotifierProvider.value(value: resumeProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Work Assistant',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}