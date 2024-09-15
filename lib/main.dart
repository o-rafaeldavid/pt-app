import 'config/env.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: Env.supabaseUrl, anonKey: Env.supabaseAnonKey);
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
  Future<dynamic>? _future;

  @override
  void initState() {
    super.initState();
    _future = Supabase.instance.client.from('person').select();
  }

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
