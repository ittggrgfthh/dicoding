import 'package:storyapp/dummy/dummy_data.dart';
import 'package:storyapp/model/stories.dart';
import 'package:storyapp/screen/add_story_screen.dart';
import 'package:storyapp/screen/detail_story_screen.dart';
import 'package:storyapp/screen/list_story_screen.dart';
import 'package:flutter/material.dart';

import '../data/repositories/auth_repository.dart';
import '../screen/login_screen.dart';
import '../screen/register_screen.dart';
import '../screen/splach_screen.dart';

class MyRouterDelegate extends RouterDelegate with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthRepository authRepository;
  bool isForm = false;

  MyRouterDelegate(this.authRepository) : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  _init() async {
    isLoggedIn = await authRepository.isLoggedIn();
    notifyListeners();
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  /// add selected quote variable,
  /// delete setState function, and
  /// change with notifiyListener().
  String? selectedStoryId;
  bool goAddStory = false;

  List<Page> historyStack = [];
  bool? isLoggedIn;
  bool isRegister = false;

  final Stories dummyStories = DummyData.dummyStories;

  List<Page> get _splashStack => const [
        MaterialPage(
          key: ValueKey("SplashPage"),
          child: SplashScreen(),
        ),
      ];

  List<Page> get _loggedOutStack => [
        MaterialPage(
          key: const ValueKey("LoginPage"),
          child: LoginScreen(
            onLogin: () {
              _init();
            },
            onRegister: () {
              isRegister = true;
              notifyListeners();
            },
          ),
        ),
        if (isRegister == true)
          MaterialPage(
            key: const ValueKey("RegisterPage"),
            child: RegisterScreen(onRegister: () {
              isRegister = false;
              notifyListeners();
            }, onLogin: () {
              isRegister = false;
              notifyListeners();
            }),
          ),
      ];

  List<Page> get _loggedInStack => [
        MaterialPage(
          key: const ValueKey("ListStoryScreen"),
          child: ListStoryScreen(onTapped: (String storyId) {
            selectedStoryId = storyId;
            notifyListeners();
          }, onLogout: () {
            _init();
          }, toAddStory: () {
            isForm = true;
            notifyListeners();
          }),
        ),
        if (selectedStoryId != null)
          MaterialPage(
            child: DetailStoryScreen(
              storyId: selectedStoryId!,
              onPopScreen: () {
                selectedStoryId = null;
                notifyListeners();
              },
            ),
          ),
        if (isForm)
          MaterialPage(
            child: AddStoryScreen(
              onSend: () {
                isForm = false;
                notifyListeners();
              },
            ),
          ),
      ];

  @override
  Widget build(BuildContext context) {
    print(selectedStoryId);
    if (isLoggedIn == null) {
      historyStack = _splashStack;
    } else if (isLoggedIn == true) {
      historyStack = _loggedInStack;
    } else {
      historyStack = _loggedOutStack;
    }

    return Navigator(
      key: navigatorKey,
      pages: historyStack,
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }
        selectedStoryId = null;
        isForm = false;
        isRegister = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    /* Do Nothing */
  }
}
