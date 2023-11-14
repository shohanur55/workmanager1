import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
//import 'package:flutter_tts/flutter_tts.dart';

const simplePeriodicTask ="be.tramckrijte.workmanagerExample.simplePeriodicTask";


void sendData() {
  print("this is first workmanager demo app..........................");
}


// void speakCurrentTime() async {
//   FlutterTts flutterTts = FlutterTts();
//   DateTime now = DateTime.now();
//   String currentTime = "${now.hour} ${now.minute}";
//
//   await flutterTts.speak("The current time is $currentTime");
// }

const task = "Register one of task";
@pragma('vm:entry-point')
void callBackDispatcher() {
  Workmanager().executeTask((taskName, inputData)async {
    switch (taskName) {
      case task:
           //sendData();
           print("this is first workmanager demo app..........................");
           //speakCurrentTime();
        break;

      case "simplePeriodicTask":
        //speakCurrentTime();
        break;

    }

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager().initialize(
    callBackDispatcher,
    isInDebugMode: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              await Workmanager().registerOneOffTask(
               task,
                "normal task:- $task",
                initialDelay: Duration(seconds: 1),
              );
            },
            child:
                Text("Register One Off Task", style: TextStyle(fontSize: 30)),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              await Workmanager().registerOneOffTask(
                "single Task(need Charging & network)",
                "single Task(need Charging & network)",
                initialDelay: Duration(seconds: 1),
                constraints: Constraints(
                    networkType: NetworkType.connected, requiresCharging: true),
              );
            },
            child: Text("single Task(need Charging & network)",
                style: TextStyle(fontSize: 20)),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              await Workmanager().registerOneOffTask(
                "One Off Task(required network)",
                "One Off Task(required network)",
                initialDelay: Duration(seconds: 1),
                constraints: Constraints(
                  networkType: NetworkType.connected,
                ),
              );
            },
            child: Text("One Off Task(required network)",
                style: TextStyle(fontSize: 20)),
          ),
          SizedBox(
            height: 20,
          ),

          //periodic task

          ElevatedButton(
            onPressed: () async {
              var uniqueName = "periodic";
              await Workmanager().registerPeriodicTask(
                simplePeriodicTask,
                simplePeriodicTask,
                initialDelay: Duration(seconds: 4),
                //minimum 15 minitues time need for perodic task
              );
            },
            child: Text("Periodic Task", style: TextStyle(fontSize: 30)),
          ),

          SizedBox(
            height: 20,
          ),

          ElevatedButton(
            child: Text("Cancel All"),
            onPressed: () async {
              await Workmanager().cancelAll();
            },
          )
        ],
      ),
    )));
  }
}
