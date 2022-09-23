import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sayakaya_flutter_stepper/stepper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stepper Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Stepper Demo Home Page'),
    );
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  static const stepLength = 5;
  static const duration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    var currentStep = useState<int>(0);
    var controller = usePageController();
    var states = useState<List<SkStepState>>([]);

    onPageChanged() {
      int currentPage = controller.page?.round() ?? 0;
      if (currentStep.value != currentPage) {
        currentStep.value = currentPage;
      }
    }

    useEffect(() {
      states.value = [
        SkStepState.success,
        SkStepState.success,
        SkStepState.error,
        SkStepState.normal,
        SkStepState.normal,
      ];
      controller.addListener(onPageChanged);
      return () {
        controller.removeListener(onPageChanged);
      };
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(title),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SkStepper(
              stepLength: stepLength,
              currentStep: currentStep.value,
              theme: SkStepTheme(),
              states: states.value,
              onTap: (int index) {
                controller.animateToPage(
                  index,
                  duration: duration,
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemBuilder: (context, index) => Center(
                child: Text('Page ${index + 1}'),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
