import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

//Widget personalizado
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //Oculta o banner de debug
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
  //Criando variavel para o contador na tela
  int count = 0;

  void decrement() {
    setState(() {
      count--;
    });
    print("Valor do contador ${count}");
  }

  void increment() {
    setState(() => count++);
    print("Valor do contador:${count}");
  }

  bool get isEmpty => count == 0;
  bool get isFull => count == 50;
  bool get isAlmostFull => count >= 45 && count < 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 145, 1, 1),
        title: Text(
          "Contador de Pessoas",
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fundocinema.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
               isFull
                  ? "Sala lotada"
                  : isAlmostFull
                  ? "Sala quase cheia!"
                  : "Pode entrar",
              style: TextStyle(
                fontSize: 26,
                color: const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w700,
              ),
            ),
            
            Text(
              count.toString(),
              style: TextStyle(fontSize: 100, color: Colors.white),
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: isEmpty ? null : decrement,
                  style: TextButton.styleFrom(
                    backgroundColor: isEmpty
                        ? Colors.white.withAlpha(90)
                        : Colors.white,
                    //padding: EdgeInsets.only(left: 32,right: 32)
                    fixedSize: Size(100, 20),
                  ),
                  child: Text(
                    "Saiu",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                TextButton(
                  onPressed: isFull ? null : increment,
                  style: TextButton.styleFrom(
                    backgroundColor: isFull
                        ? Colors.white.withAlpha(90)
                        : Colors.white,
                    fixedSize: Size(100, 20),
                  ),
                  child: Text(
                    "Entrou",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
