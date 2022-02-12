import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organia/src/blocs/account/bloc.dart';
import 'package:organia/src/ui/screens/account.dart';

class NavigationRouteInterface {
  final Icon icon;
  final String label;
  final Widget widget;
  const NavigationRouteInterface(this.icon, this.label, this.widget);
}

List<NavigationRouteInterface> navigationRoutes = [
  NavigationRouteInterface(
      const Icon(Icons.person),
      "Account",
      BlocProvider(
        create: (_) => AccountBloc(),
        child: const AccountScreen(),
      )),
  NavigationRouteInterface(
      const Icon(Icons.person),
      "Account",
      BlocProvider(
        create: (_) => AccountBloc(),
        child: const AccountScreen(),
      )),
];

class MainRoutes extends StatefulWidget {
  const MainRoutes({Key? key}) : super(key: key);

  @override
  HomeMainRouteState createState() => HomeMainRouteState();
}

class HomeMainRouteState extends State<MainRoutes> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: navigationRoutes.map<BottomNavigationBarItem>((route) {
              return (BottomNavigationBarItem(
                icon: route.icon,
                label: route.label,
              ));
            }).toList(),
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue,
            onTap: _onItemTapped),
        body: Center(child: navigationRoutes.elementAt(_selectedIndex).widget));
  }
}
