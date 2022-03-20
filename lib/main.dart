import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_list_app/common/app_colors.dart';
import 'package:infinite_scroll_list_app/feature/presentation/bloc/photo_list_cubit/photo_list_cubit.dart';
import 'package:infinite_scroll_list_app/feature/presentation/pages/home_page.dart';
import 'package:infinite_scroll_list_app/locator_service.dart' as di;

import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PhotoListCubit>(create: (context) => sl<PhotoListCubit>()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          backgroundColor: AppColors.mainBackground,
          scaffoldBackgroundColor: AppColors.mainBackground,
        ),
        home: HomePage(),
      ),
    );
  }
}