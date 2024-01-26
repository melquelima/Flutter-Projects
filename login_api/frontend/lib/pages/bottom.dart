import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final Widget body;

  BottomNavBar({super.key, required this.body});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState(body: body);
}

class _BottomNavBarState extends State<BottomNavBar> {
  final Widget body;
  _BottomNavBarState({required this.body});

  // List<BottomNavItem> btns = [
  //   const BottomNavItem(
  //     icon: Icon(Icons.home),
  //     label: "Accounts",
  //     path: "/accounts",
  //   ),
  //   const BottomNavItem(
  //     icon: Icon(Icons.location_city),
  //     label: "",
  //     path: "/transfers",
  //   ),
  //   const BottomNavItem(
  //     icon: Icon(Icons.settings),
  //     label: "Dep Checks",
  //     path: "/some",
  //   ),
  //   const BottomNavItem(
  //     icon: Icon(Icons.qr_code),
  //     label: "Bill pay",
  //     path: "/bill",
  //   )
  // ];

  List<BottomNavItem> btns = [
    const BottomNavItem(
      icon: Icon(Icons.home),
      label: "Accounts",
      path: "/accounts",
    ),
    const BottomNavItem(
      icon: Icon(CupertinoIcons.news),
      label: "Statements",
      path: "/statements",
    ),
    const BottomNavItem(
      icon: Icon(CupertinoIcons.arrow_right_arrow_left),
      label: "Transfers",
      path: "/bill",
    ),
    const BottomNavItem(
      icon: Icon(Icons.credit_card),
      label: "Cards",
      path: "/cards",
    ),
  ];

  int get _current_Index => _locationToTabIndex(GoRouter.of(context).location);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widget.body,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _current_Index,
          onTap: (int newIndex) {
            if (newIndex != _current_Index) {
              context.go(btns[newIndex].path);
            }
          },
          items: btns,
        ));
  }

  int _locationToTabIndex(String location) {
    print("--->" + location);
    final index = btns.indexWhere((t) => location.startsWith(t.path));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }
}

class BottomNavItem extends BottomNavigationBarItem {
  const BottomNavItem({required this.path, required Widget icon, String? label})
      : super(icon: icon, label: label);

  /// The init
  final path;
}
