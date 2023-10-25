import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon_map/blocs/login_bloc.dart';
import 'package:pokemon_map/repositories/login_repository.dart';
import 'package:pokemon_map/repositories/pokemon_repository.dart';
import 'package:pokemon_map/screens/about_screen.dart';
import 'package:pokemon_map/screens/add_pokemon_bottomsheet.dart';
import 'package:pokemon_map/screens/home_screen.dart';
import 'package:pokemon_map/screens/login_screen.dart';
import 'package:pokemon_map/screens/map_screen.dart';
import 'package:pokemon_map/screens/profile_screen.dart';

import 'blocs/pokemon_bloc.dart';
import 'model/pokemon.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Hive.registerAdapter(PokemonAdapter());
  await Hive.openBox<Pokemon>('pokemonBox');

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF1B5D1B)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> _tabs = [
    HomeScreen(),
    MapScreen(),
    ProfileScreen(),
    AboutScreen(),
  ];

  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => LoginRepository(),
      child: BlocProvider(
        create: (context) =>
            LoginBloc(repository: context.read<LoginRepository>())
              ..add(InitializeEvent()),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is! LoginSuccessState) {
              FlutterNativeSplash.remove();
            }

            if (state is LoginErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to login.')),
              );
            }
          },
          builder: (context, state) {
            if (state is LoginSuccessState) {
              return buildPokeApp();
            }

            return LoginScreen(bloc: context.read<LoginBloc>());
          },
        ),
      ),
    );
  }

  RepositoryProvider<PokemonRepository> buildPokeApp() {
    return RepositoryProvider(
      create: (context) => PokemonRepository(),
      child: BlocProvider(
        create: (context) =>
            PokemonBloc(repository: context.read<PokemonRepository>()),
        child: BlocListener<PokemonBloc, PokemonState>(
          listener: (context, state) {
            if (state is PokemonErrorState || state is PokemonLoadedState) {
              Future.delayed(const Duration(milliseconds: 100), () {
                FlutterNativeSplash.remove();
              });
            }

            if (state is PokemonErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
              );
            }

            if (state is PokemonAddedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Added ${state.addedPokemon.displayName}')),
              );
            }
          },
          child: Scaffold(
            body: _tabs[_currentIndex],
            bottomNavigationBar: NavigationBar(
              selectedIndex: _currentIndex,
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(icon: Icon(Icons.map), label: 'Map'),
                NavigationDestination(
                    icon: Icon(Icons.person), label: 'Profile'),
                NavigationDestination(icon: Icon(Icons.info), label: 'About'),
              ],
              onDestinationSelected: _onTabTapped,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            floatingActionButton: BlocBuilder<PokemonBloc, PokemonState>(
              builder: (context, state) {
                return FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      builder: (contextInner) {
                        return SizedBox(
                          height: 500, // Change the height here
                          child: AddPokemonBottomSheet(
                              pokemonBloc: context.read<PokemonBloc>()),
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.add),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
