import 'package:storyapp/data/repositories/preferences_helper.dart';
import 'package:storyapp/provider/auth_provider.dart';
import 'package:storyapp/provider/story_provider.dart';
import 'package:storyapp/routes/router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/repositories/auth_repository.dart';
import 'data/repositories/story_repository.dart';

void main() {
  runApp(const StoryApp());
}

class StoryApp extends StatefulWidget {
  const StoryApp({super.key});

  @override
  State<StoryApp> createState() => _QuotesAppState();
}

class _QuotesAppState extends State<StoryApp> {
  late MyRouterDelegate myRouterDelegate;
  late AuthProvider authProvider;
  late StoryProvider storyProvider;
  late StoryRepositories storyRepository;

  @override
  void initState() {
    super.initState();
    final sharePref = SharedPreferences.getInstance();

    final authRepository = AuthRepository(
      preferencesHelper: PreferencesHelper(
        sharedPreferences: sharePref,
      ),
    );
    authProvider = AuthProvider(authRepository: authRepository);
    storyRepository = StoryRepositories(
      preferencesHelper: PreferencesHelper(
        sharedPreferences: sharePref,
      ),
    );

    myRouterDelegate = MyRouterDelegate(authRepository);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => authProvider,
        ),
        ChangeNotifierProvider(
          create: (context) => StoryProvider(storyRepositories: storyRepository),
        )
      ],
      child: MaterialApp(
        title: 'Story App',
        home: Router(
          routerDelegate: myRouterDelegate,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
