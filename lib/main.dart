import 'package:api_app_flutter/pages/enter_page.dart';
import 'package:api_app_flutter/utils/api_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/note_list_cubit.dart';
import 'cubits/user_data_cubit.dart';

void main() {
  ApiUtils.S = new ApiUtils();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => NoteListCubit()),
          BlocProvider(create: (BuildContext context) => UserDataCubit()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: EnterPage(),
        ));
  }
}