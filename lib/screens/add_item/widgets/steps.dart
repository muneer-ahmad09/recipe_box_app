import 'package:flutter/material.dart';

class Steps extends StatefulWidget {
  final ValueChanged<List<String>> onStepsChanged;

  const Steps({super.key, required this.onStepsChanged});

  @override
  State<StatefulWidget> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  final List<TextEditingController> _stepControllers = [
    TextEditingController(),
  ];

  @override
  void dispose() {
    super.dispose();
    for (final controller in _stepControllers) {
      controller.dispose();
    }
  }

  void _notifySteps() {
    final steps = _stepControllers
        .map((controller) => controller.text)
        .toList();
    widget.onStepsChanged(steps);
  }

  void _addStep() {
    setState(() {
      _stepControllers.add(TextEditingController());
    });
    _notifySteps();
  }

  void _removeStep(int index) {
    setState(() {
      if (_stepControllers.length > 1) {
        final controller = _stepControllers.removeAt(index);
        controller.dispose();
      }
    });
    _notifySteps();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Steps",
              style: Theme.of(context).textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                _addStep();
              },
              child: Text("Add"),
            ),
          ],
        ),
        Column(
          children: [
            for (int i = 0; i < _stepControllers.length; i++)
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _stepControllers[i],
                      decoration: InputDecoration(
                        hintText: "Step ${i + 1}",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                    ),
                  ),
                  if (_stepControllers.length > 1)
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removeStep(i),
                      color: Colors.red,
                    ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
