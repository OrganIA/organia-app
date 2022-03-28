import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/blocs/login/bloc.dart';
import 'package:organia/src/ui/routes/main_routes.dart';
import 'package:organia/src/ui/themes/themes.dart';
import 'package:organia/src/utils/myhive.dart';

void main() async {
  await hive.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) {
      return LoginBloc();
    }),
  ], child: const App()));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
      title: 'OrganIA',
      theme: ThemeData(
        primaryColor: darkBlue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primaryColor: blue,
        brightness: Brightness.dark,
      ),
      home: const MainRoutes(),
    );
  }
}
