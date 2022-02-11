import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/blocs/login/bloc.dart';
import 'package:organia/src/ui/routes/main_routes.dart';
import 'package:organia/src/utils/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) {
      return LoginBloc();
    }),
  ], child: const App()));
}

Future<bool> _loadCredentials() async {
  final auth = await MySharedPreferences().get("AUTH");

  if (auth == null) {
    return (false);
  }

  return (true);
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadCredentials(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: child!),
            initialRoute: (snapshot.data == true ? '/home' : '/'),
            title: 'OrganIA',
            theme: ThemeData(
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
            ),
            home: const MainRoutes(),
          );
        } else {
          return const MaterialApp(
              home: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
