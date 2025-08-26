<<<<<<< Updated upstream
import 'package:flutter/material.dart';

=======
import 'package:flutter/material.dart'; //lutterのUI部品を使うためのパッケージをインポート
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart'; // 日付フォーマット用パッケージをインポート
import 'package:proximity_sensor/proximity_sensor.dart'; // 近接センサーを使うためのパッケージをインポート
import 'package:table_calendar/table_calendar.dart'; // カレンダー表示用パッケージをインポート

class info {
  info(this.subject, this.count);
  
  String subject;
  int count;
}

class AlertDialogSample extends StatelessWidget {
  const AlertDialogSample(this.selectedDay);
  final DateTime selectedDay;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("${DateFormat('yyyy.M.d').format(selectedDay)}", textAlign: TextAlign.center, style: TextStyle(fontSize: 25.0,),),
      content: Icon(Icons.circle),//まるばつくん
      actions: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextButton( 
              child: Text('Back'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ]
        )
      ],
    );
  }
}
>>>>>>> Stashed changes
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  int _counter = 0;

<<<<<<< Updated upstream
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
=======
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 画面のレイアウトを定義
      appBar: AppBar(
        title: const Text('Calendar App'), // AppBarのタイトル
        backgroundColor: Theme.of(context).colorScheme.primary, // AppBarの背景色
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // 画面の余白を設定
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1), // カレンダーの開始日
              lastDay: DateTime.utc(2200, 12, 31), // カレンダーの終了日
              focusedDay: _focusedDay, // 現在フォーカスされている日付
              selectedDayPredicate: (day) =>
                  isSameDay(_selectedDay, day), // 選択判定
              onDaySelected: (selectedDay, focusedDay) {
                showDialog<void>(
                  context: context,
                  builder: (_) {
                    return AlertDialogSample(selectedDay);
                  }
                );
                // 日付選択時の処理
                setState(() {
                  _selectedDay = selectedDay; // 選択日を更新
                  _focusedDay = focusedDay; // フォーカス日を更新
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => NextPage('KBOY')),
                  // );
                });
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.deepPurple, // 選択日の背景色
                  shape: BoxShape.circle, // 選択日の形状
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.orangeAccent, // 今日の背景色
                  shape: BoxShape.circle, // 今日の形状
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false, // フォーマット切替ボタン非表示
                titleCentered: true, // タイトル中央揃え
              ),
            ),
            const SizedBox(height: 20), // 余白
            OutlinedButton( // ボタンウィジェット
              onPressed: () { // ボタン押下時の処理
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PushUpCounterScreen(),
                  ), // PushUpCounterScreenへ遷移
                );
              },
              child: const Text('Start',style: TextStyle(fontSize: 50.0,),), // ボタンのラベル
            ),
          ],
        ),
      ),
    );
  }
}

class PushUpCounterScreen extends StatefulWidget {
  // 状態を持つ画面ウィジェット
  const PushUpCounterScreen({super.key}); // コンストラクタ

  @override
  State<PushUpCounterScreen> createState() => _PushUpCounterScreenState(); // 状態管理クラスを生成
}

class _PushUpCounterScreenState extends State<PushUpCounterScreen> {
  // 状態管理クラス
  int _pushUpCount = 0; // 腕立ての回数を保持する変数
  bool _isNear = false; // 近接センサーが近いかどうかを保持
  late Stream<bool> _proximityStream; // 近接センサーの状態を監視するストリーム

  @override
  void initState() {
    super.initState();
    _startListening(); // 初期化時に近接センサーの監視を開始
  }

  void _startListening() {
    // proximity_sensorのStream<int>をboolに変換
    _proximityStream = ProximitySensor.events.map(
      (event) => event > 0,
    ); // センサー値が0より大きければtrue

    _proximityStream.listen((isNear) {
      // センサーの状態変化を監視
      if (isNear && !_isNear) {
        // 近づいた瞬間のみカウントアップ（ステップ関数）
        setState(() {
          _pushUpCount++; // 腕立て回数を増やす
        });
        if (_pushUpCount == 2) {
          // 2回目で何か処理（例：メッセージ表示）をしたい場合
          // ここに処理を書く
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResultScreen(_pushUpCount)),
          );
        }
      }
      _isNear = isNear; // 状態を更新（過去の状態として残しておく）
>>>>>>> Stashed changes
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
<<<<<<< Updated upstream
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
=======
              '$_pushUpCount', // 腕立て回数を表示
              style: const TextStyle(
                fontSize: 80,
                color: Colors.green,
              ), // 文字サイズと色
            ),
            const SizedBox(height: 40), // 余白
            const Text(
              'スマホを地面に置いて、\n胸を近づけるとカウントされます！', // 説明文
              style: TextStyle(fontSize: 18, color: Colors.white60), // 文字サイズと色
              textAlign: TextAlign.center, // 中央揃え
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatefulWidget {
  // 状態を持つ画面ウィジェット
  ResultScreen(this.count); // コンストラクタ
  int count;

  @override
  State<ResultScreen> createState() => _ResultScreenState(count); // 状態管理クラスを生成
}

class _ResultScreenState extends State<ResultScreen> {
  _ResultScreenState(this.count); // コンストラクタ
  int count;

  Future<void> setDate() async {
    await Hive.initFlutter();
    late Box box;
    box = await Hive.openBox('box1');

    box.put('${DateTime.now()}', count);
    print(box.get('count', defaultValue: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 画面のレイアウトを定義
      backgroundColor: Colors.black, // 背景色を黒に設定
      body: Center(
        // 中央に配置
        child: Column(
          // 縦方向にウィジェットを並べる
          mainAxisAlignment: MainAxisAlignment.center, // 中央揃え
          children: [
            const Text(
              'Result', // タイトル表示
              style: TextStyle(fontSize: 32, color: Colors.orange), // 文字サイズと色
            ),
            const SizedBox(height: 20), // 余白
            Text(
              '$count', // 腕立て回数を表示
              style: const TextStyle(
                fontSize: 80,
                color: Colors.green,
              ), // 文字サイズと色
            ),
            //const SizedBox(height: 40), // 余白
            // const Text(
            //   'スマホを地面に置いて、\n胸を近づけるとカウントされます！', // 説明文
            //   style: TextStyle(fontSize: 18, color: Colors.white60), // 文字サイズと色
            //   textAlign: TextAlign.center, // 中央揃え
            // ),
            ElevatedButton(
              // ボタンウィジェット
              onPressed: () {
                setDate();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Calendar()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text(
                'Main menu',
                style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
              ), // ボタンのラベル
>>>>>>> Stashed changes
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
