import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MathKidsApp());
}

class MathKidsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Kids — Fun with Numbers',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.indigo[900],
          ),
          bodyMedium: TextStyle(color: Colors.indigo[800]),
        ),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  final List<OperationCardData> ops = [
    OperationCardData('Addition', Icons.add, Colors.orange),
    OperationCardData('Subtraction', Icons.remove, Colors.teal),
    OperationCardData('Multiplication', Icons.close, Colors.purple),
    OperationCardData('Division', Icons.horizontal_split, Colors.cyan),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Math Kids — Fun with Numbers'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose an operation',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 12),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children:
                    ops
                        .map(
                          (o) => OperationCard(
                            data: o,
                            onTap:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) =>
                                            QuizConfigPage(operation: o.title),
                                  ),
                                ),
                          ),
                        )
                        .toList(),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                'Made with ❤️ for curious kids',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OperationCardData {
  final String title;
  final IconData icon;
  final Color color;
  OperationCardData(this.title, this.icon, this.color);
}

class OperationCard extends StatelessWidget {
  final OperationCardData data;
  final VoidCallback onTap;
  OperationCard({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [data.color.withOpacity(0.9), data.color.withOpacity(0.6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: data.color.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 6),
            ),
          ],
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.9),
              child: Icon(data.icon, size: 36, color: data.color),
              radius: 32,
            ),
            SizedBox(height: 12),
            Text(
              data.title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizConfigPage extends StatefulWidget {
  final String operation;
  QuizConfigPage({required this.operation});
  @override
  _QuizConfigPageState createState() => _QuizConfigPageState();
}

class _QuizConfigPageState extends State<QuizConfigPage> {
  String difficulty = 'Easy';
  int questions = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.operation)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select difficulty',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 12),
            Row(
              children:
                  ['Easy', 'Medium', 'Hard'].map((d) {
                    final selected = difficulty == d;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => difficulty = d),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 250),
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          padding: EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color:
                                selected
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              d,
                              style: TextStyle(
                                color: selected ? Colors.white : Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
            SizedBox(height: 18),
            Text(
              'Number of questions',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              min: 5,
              max: 20,
              divisions: 3,
              value: questions.toDouble(),
              label: questions.toString(),
              onChanged: (v) => setState(() => questions = v.toInt()),
            ),
            SizedBox(height: 18),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.play_arrow),
                label: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 8,
                  ),
                  child: Text('Start ${widget.operation} — $difficulty'),
                ),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(horizontal: 18),
                ),
                onPressed:
                    () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => QuizPage(
                              operation: widget.operation,
                              difficulty: difficulty,
                              totalQuestions: questions,
                            ),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  final String operation;
  final String difficulty;
  final int totalQuestions;
  QuizPage({
    required this.operation,
    required this.difficulty,
    required this.totalQuestions,
  });

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage>
    with SingleTickerProviderStateMixin {
  late int score;
  late int current;
  late MathQuestion currentQuestion;
  final TextEditingController answerController = TextEditingController();
  final Random rnd = Random();
  bool showCorrect = false;
  bool lastAnswerCorrect = false;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    score = 0;
    current = 0;
    _pulseController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    nextQuestion();
  }

  @override
  void dispose() {
    answerController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  int maxNumberForDifficulty() {
    switch (widget.difficulty) {
      case 'Easy':
        return 10;
      case 'Medium':
        return 20;
      default:
        return 50;
    }
  }

  void nextQuestion() {
    if (current >= widget.totalQuestions) {
      // show results
      WidgetsBinding.instance.addPostFrameCallback((_) => _showResultDialog());
      return;
    }

    final maxN = maxNumberForDifficulty();
    setState(() {
      currentQuestion = MathQuestion.generate(widget.operation, maxN, rnd);
      answerController.clear();
      showCorrect = false;
    });
  }

  void submitAnswer() {
    final text = answerController.text.trim();
    if (text.isEmpty) return;

    bool correct = false;
    double? input;
    try {
      input = double.parse(text);
    } catch (_) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter a number')));
      return;
    }

    // Compare with a tolerance for division
    if (widget.operation == 'Division') {
      correct = (input - currentQuestion.answer).abs() < 0.001;
    } else {
      correct = (input - currentQuestion.answer).abs() < 0.0001;
    }

    setState(() {
      showCorrect = true;
      lastAnswerCorrect = correct;
      if (correct) {
        score += 1;
        _pulseController.forward(from: 0.0);
      }
    });

    // small delay then go next
    Future.delayed(Duration(milliseconds: 800), () {
      setState(() => current++);
      nextQuestion();
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Well done!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Your score: $score / ${widget.totalQuestions}'),
                SizedBox(height: 12),
                LinearProgressIndicator(value: score / widget.totalQuestions),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text('Back to home'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    score = 0;
                    current = 0;
                  });
                  nextQuestion();
                },
                child: Text('Play again'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final questionText =
        '${currentQuestion.a} ${currentQuestion.symbol} ${currentQuestion.b} = ?';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.operation} — Question ${current + 1}/${widget.totalQuestions}',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Center(
              child: Text(
                'Score: $score',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 6,
              child: Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (_, child) {
                        final scale = 1 + _pulseController.value * 0.08;
                        return Transform.scale(scale: scale, child: child);
                      },
                      child: Text(
                        questionText,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo[900],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    if (showCorrect)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            lastAnswerCorrect
                                ? Icons.check_circle
                                : Icons.cancel,
                            color:
                                lastAnswerCorrect ? Colors.green : Colors.red,
                            size: 28,
                          ),
                          SizedBox(width: 8),
                          Text(
                            lastAnswerCorrect
                                ? 'Correct!'
                                : 'Oops — Answer: ${currentQuestion.displayAnswer()}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      )
                    else
                      SizedBox(height: 36),
                  ],
                ),
              ),
            ),
            SizedBox(height: 18),
            TextField(
              controller: answerController,
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Your answer',
                hintText: 'Type number here',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => answerController.clear(),
                ),
              ),
              onSubmitted: (_) => submitAnswer(),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.check),
                    label: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text('Submit'),
                    ),
                    onPressed: submitAnswer,
                  ),
                ),
                SizedBox(width: 12),
                OutlinedButton.icon(
                  icon: Icon(Icons.skip_next),
                  label: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text('Skip'),
                  ),
                  onPressed: () {
                    setState(() => current++);
                    nextQuestion();
                  },
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Operation: ${widget.operation}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Difficulty: ${widget.difficulty}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MathQuestion {
  final int a;
  final int b;
  final double answer;
  final String symbol;

  MathQuestion({
    required this.a,
    required this.b,
    required this.answer,
    required this.symbol,
  });

  String displayAnswer() {
    if (symbol == '/') {
      // show with max 2 decimal places if not integer
      return answer % 1 == 0
          ? answer.toInt().toString()
          : answer.toStringAsFixed(2);
    }
    return answer.toInt().toString();
  }

  static MathQuestion generate(String op, int maxNumber, Random rnd) {
    int x, y;
    switch (op) {
      case 'Addition':
        x = rnd.nextInt(maxNumber) + 1;
        y = rnd.nextInt(maxNumber) + 1;
        return MathQuestion(
          a: x,
          b: y,
          answer: (x + y).toDouble(),
          symbol: '+',
        );
      case 'Subtraction':
        x = rnd.nextInt(maxNumber) + 1;
        y = rnd.nextInt(maxNumber) + 1;
        if (y > x) {
          final t = x;
          x = y;
          y = t;
        }
        return MathQuestion(
          a: x,
          b: y,
          answer: (x - y).toDouble(),
          symbol: '-',
        );
      case 'Multiplication':
        x = rnd.nextInt(maxNumber) + 1;
        y = rnd.nextInt(maxNumber) + 1;
        return MathQuestion(
          a: x,
          b: y,
          answer: (x * y).toDouble(),
          symbol: '×',
        );
      case 'Division':
        // create a divisible pair for cleaner answers normally — but sometimes allow decimal answers for higher difficulty
        if (maxNumber <= 10) {
          y = rnd.nextInt(maxNumber - 1) + 1; // avoid zero
          int quotient = rnd.nextInt(maxNumber) + 1;
          x = y * quotient;
          return MathQuestion(
            a: x,
            b: y,
            answer: quotient.toDouble(),
            symbol: '/',
          );
        } else {
          // medium/hard: sometimes non-integer
          y = rnd.nextInt(maxNumber - 1) + 1;
          x = rnd.nextInt(maxNumber) + 1;
          // ensure y != 0
          double ans = x / y;
          return MathQuestion(
            a: x,
            b: y,
            answer: double.parse(ans.toStringAsFixed(2)),
            symbol: '/',
          );
        }
      default:
        x = 1;
        y = 1;
        return MathQuestion(a: x, b: y, answer: 2.0, symbol: '+');
    }
  }
}
