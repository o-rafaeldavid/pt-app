import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
/* import 'package:flutter_dotenv/flutter_dotenv.dart'; */

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /* await dotenv.load(fileName: ".env"); */
  final SUPABASE_URL = const String.fromEnvironment('SUPABASE_URL');
  final SUPABASE_ANON_KEY = const String.fromEnvironment('SUPABASE_ANON_KEY');

  await Supabase.initialize(url: SUPABASE_URL, anonKey: SUPABASE_ANON_KEY);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Todos',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _future = Supabase.instance.client.from('aaaa').select();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('Snapshot Data: ${snapshot.data}');
          } else if (snapshot.hasError) {
            print('Snapshot Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return const Column(children: <Widget>[
              CircularProgressIndicator(),
              Text('Loading')
            ]);
          }
          final personalTrainers = snapshot.data!;
          return Column(children: <Widget>[
            const Text('Personal Trainers'),
            Expanded(
                child: ListView.builder(
              itemCount: personalTrainers.length,
              itemBuilder: ((context, index) {
                final personalTrainer = personalTrainers[index];
                return ListTile(
                  title: Text(personalTrainer['name']),
                );
              }),
            ))
          ]);
        },
      ),
    );
  }
}
