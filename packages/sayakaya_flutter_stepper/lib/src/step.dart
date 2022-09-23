import 'package:flutter/material.dart';

import 'constants.dart';
import 'state.dart';
import 'theme.dart';

class SkStep extends StatelessWidget {
  const SkStep({
    Key? key,
    this.state,
    this.theme,
    this.width,
    this.isActive = false,
    this.onTap,
  }) : super(key: key);

  final SkStepState? state;
  final SkStepTheme? theme;
  final double? width;
  final bool isActive;
  final Function()? onTap;

  Color get normalColor => theme?.color ?? defaultColor;
  Color get activeColor => theme?.activeColor ?? defaultActiveColor;
  Color get successColor => theme?.successColor ?? defaultSuccessColor;
  Color get errorColor => theme?.errorColor ?? defaultErrorColor;

  Color get color {
    if (isActive) return activeColor;
    switch (state) {
      case SkStepState.success:
        return successColor;
      case SkStepState.error:
        return errorColor;
      default:
        return normalColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: Container(
        height: theme?.height ?? defaultStepHeight,
        width: width ?? defaultStepWidth,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(defaultStepRadius),
        ),
      ),
    );
  }
}
