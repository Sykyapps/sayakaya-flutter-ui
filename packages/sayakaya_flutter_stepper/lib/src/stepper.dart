import 'package:flutter/material.dart';

import 'constants.dart';
import 'state.dart';
import 'step.dart';
import 'theme.dart';

class SkStepper extends StatelessWidget {
  const SkStepper({
    Key? key,
    required this.stepLength,
    required this.currentStep,
    this.states,
    this.onTap,
    this.theme,
  }) : super(key: key);

  final int stepLength;
  final int currentStep;
  final List<SkStepState>? states;
  final Function(int)? onTap;
  final SkStepTheme? theme;

  @override
  Widget build(BuildContext context) {
    return _SkStepper(
      currentStep: currentStep,
      stepLength: stepLength,
      states: states,
      onTap: onTap,
      theme: theme,
    );
  }
}

class _SkStepper extends StatelessWidget {
  const _SkStepper({
    Key? key,
    required this.stepLength,
    required this.currentStep,
    this.states,
    this.onTap,
    this.theme,
  }) : super(key: key);

  final int stepLength;
  final int currentStep;
  final List<SkStepState>? states;
  final Function(int)? onTap;
  final SkStepTheme? theme;

  double get gap => theme?.gap ?? defaultStepGap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double autoWidth = (size.width - (stepLength * gap)) / stepLength;

    return SizedBox(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          stepLength,
          (index) => SkStep(
            theme: theme,
            state: states?[index],
            isActive: index == currentStep,
            width: theme?.width ?? autoWidth,
            onTap: () => onTap?.call(index),
          ),
        ),
      ),
    );
  }
}
