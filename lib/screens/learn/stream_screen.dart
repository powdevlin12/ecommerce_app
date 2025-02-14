import 'dart:async';

import 'package:ercomerce_app/widgets/screen_widget.dart';
import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class StreamScreen extends StatefulWidget {
  const StreamScreen({super.key});

  @override
  _StreamScreenState createState() => _StreamScreenState();
}

class CounterState {
  final int count;
  final DateTime timestamp;

  CounterState(this.count, this.timestamp);
}

class _StreamScreenState extends State<StreamScreen> {
  // StreamController để quản lý stream
  final StreamController<CounterState> _streamController =
      StreamController<CounterState>();

  // State hiện tại
  CounterState _currentState = CounterState(0, DateTime.now());

  @override
  void initState() {
    super.initState();
    _streamController.add(_currentState);
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void _increment() {
    _currentState = CounterState(_currentState.count + 1, DateTime.now());
    _streamController.add(_currentState);
  }

  void _decrement() {
    _currentState = CounterState(_currentState.count - 1, DateTime.now());
    _streamController.add(_currentState);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      appBar: AppBar(
        title: const TextWidget(content: "Stream"),
      ),
      child: Center(
        child: StreamBuilder<CounterState>(
            stream: _streamController.stream,
            initialData: CounterState(0, DateTime.now()),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              final state = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Count: ${state.count}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  Text(
                    'Last updated: ${state.timestamp.toString()}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _decrement,
                        child: const Text('-'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: _increment,
                        child: const Text('+'),
                      ),
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }
}
