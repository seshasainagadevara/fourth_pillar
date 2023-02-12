import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DiscRotationAnimation extends StatefulWidget {
  const DiscRotationAnimation({Key? key, required this.child})
      : super(key: key);
  final Widget child;

  @override
  State<DiscRotationAnimation> createState() => _DiscRotationAnimationState();
}

class _DiscRotationAnimationState extends State<DiscRotationAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _animationController.forward();
    _animationController.repeat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_animationController),
      child: widget.child,
    );
  }
}
