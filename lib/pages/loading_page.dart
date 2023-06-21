import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SimpleCircularProgressBar(
              progressColors: const [
                Color(0xff005C97),
                Color(0xff7076E0),
                Color(0xffAC42A3),
                Color(0xffB60054),
                Color(0xff960000),
              ],
              backStrokeWidth: 0,
              //mergeMode: true,
              onGetText: (double value) {
                return Text('${value.toInt()}%');
              },
            ),
            const SizedBox(height: 25),
            // Text(
            //   'Carregando...',
            //   style: TextStyle(
            //     color: Theme.of(context).primaryTextTheme.titleLarge?.color,
            //   ),
            //)
          ],
        ),
      ),
    );
  }
}
