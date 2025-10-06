import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn ABC & 123',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple[200]!, Colors.blue[200]!],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                '🎓 Learn ABC & 123 🎓',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black26,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 80),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildMenuButton(
                      context,
                      'Learn ABC 🔤',
                      Colors.pink[300]!,
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ABCScreen()),
                      ),
                    ),
                    SizedBox(height: 30),
                    _buildMenuButton(
                      context,
                      'Learn 123 🔢',
                      Colors.blue[300]!,
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NumberScreen()),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context,
    String text,
    Color color,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 80,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shadowColor: Colors.black26,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ABCScreen extends StatelessWidget {
  final List<String> alphabets = ['A', 'B', 'C', 'D', 'E', 'F'];
  final AudioPlayer player = AudioPlayer();

  ABCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.pink[100]!, Colors.pink[50]!],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.pink[600],
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        'Learn ABC 🔤',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 50),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    children:
                        alphabets.map((letter) {
                          return _buildLetterCard(letter);
                        }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLetterCard(String letter) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.pink[200]!, Colors.pink[100]!],
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () async {
            try {
              // Playing your alphabet.mp3 file
              await player.play(AssetSource('sounds/alphabet.mp3'));
              print('Playing sound for $letter');
            } catch (e) {
              print('Error playing audio: $e');
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Using your atoz.png image
              SizedBox(
                width: 60,
                height: 60,
                child: Image.asset(
                  'assets/images/atoz.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.image, size: 60, color: Colors.pink[300]);
                  },
                ),
              ),
              SizedBox(height: 10),
              Text(
                letter,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[800],
                ),
              ),
              SizedBox(height: 5),
              Icon(Icons.volume_up, color: Colors.pink[600], size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class NumberScreen extends StatelessWidget {
  final List<int> numbers = [1, 2, 3, 4, 5, 6];
  final AudioPlayer player = AudioPlayer();

  NumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlue[100]!, Colors.lightBlue[50]!],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.blue[600],
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        'Learn 123 🔢',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 50),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    children:
                        numbers.map((number) {
                          return _buildNumberCard(number);
                        }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberCard(int number) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.lightBlue[200]!, Colors.lightBlue[100]!],
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () async {
            try {
              // Playing your alphabet.mp3 file
              await player.play(AssetSource('sounds/alphabet.mp3'));
              print('Playing sound for $number');
            } catch (e) {
              print('Error playing audio: $e');
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Using your atoz.png image
              SizedBox(
                width: 60,
                height: 60,
                child: Image.asset(
                  'assets/images/atoz.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.looks_one,
                      size: 60,
                      color: Colors.blue[300],
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Text(
                number.toString(),
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              SizedBox(height: 5),
              Icon(Icons.volume_up, color: Colors.blue[600], size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
