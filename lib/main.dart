import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Лічильник',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int counter = 0;

  final TextEditingController controller = TextEditingController(text: '0');

  void setNumber() {
    int? number = int.tryParse(controller.text.trim());

    if (number != null) {
      setState(() {
        counter = number;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введіть правильне ціле число!')),
      );
    }
  }

  void increment() {
    setState(() {
      counter++;
      controller.text = counter.toString();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Головний екран'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Введіть число:', style: TextStyle(fontSize: 22)),

            const SizedBox(height: 15),

            TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ваше число',
              ),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: setNumber,
              child: const Text('Встановити число'),
            ),

            const SizedBox(height: 25),

            Text(
              'Поточне значення: $counter',
              style: const TextStyle(fontSize: 26),
            ),

            const SizedBox(height: 20),

            ElevatedButton(onPressed: increment, child: const Text('+1')),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(counter: counter),
                  ),
                );
              },
              child: const Text('Детальніше'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final int counter;

  const DetailsScreen({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детальна інформація'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Передане значення лічильника:',
              style: TextStyle(fontSize: 22),
            ),

            const SizedBox(height: 20),

            Text(
              '$counter',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Назад'),
            ),
          ],
        ),
      ),
    );
  }
}
