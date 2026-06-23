import 'package:cue/cue.dart';
import 'package:flutter/material.dart';

class SmoothSwitch extends StatefulWidget {
  const SmoothSwitch({super.key});

  @override
  State<SmoothSwitch> createState() => _SmoothSwitchState();
}

class _SmoothSwitchState extends State<SmoothSwitch> {
  bool _toggled = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = 44.0;
    final width = height * 2;
    final trackColor = Colors.grey.shade800;
    final thumbColor = theme.colorScheme.onSurface;
    const duration = Duration(milliseconds: 300);
    return Cue.onToggle(
      toggled: _toggled,
      motion: CueMotion.linear(duration),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _toggled = !_toggled;
          });
        },
        child: Actor(
          acts: [
            ScaleAct.keyframed(
              frames: Keyframes.fractional([
                FKeyframe.key(1.1, at: .4),
                FKeyframe.key(1.1, at: .6),
                FKeyframe.key(1.0, at: 1.0),
              ]),
            ),
          ],
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: trackColor,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.shadow.withValues(alpha: .1),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                PositionedActor.keyframed(
                  frames: Keyframes.fractional([
                    FKeyframe.key(Position.fill(end: .5), at: .0),
                    FKeyframe.key(Position.fill(end: 0, top: .15, bottom: .15), at: .45),
                    FKeyframe.key(Position.fill(end: 0, top: .15, bottom: .15), at: .55),
                    FKeyframe.key(Position.fill(start: .5), at: 1.0),
                  ]),
                  relativeTo: Size(width, height),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: thumbColor,
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: DecoratedBoxActor(
                        shape: BoxShape.circle,
                        color: AnimatableValue.tween(trackColor, thumbColor),
                        motion: CueMotion.linear(duration * .5),
                        reverse: ReverseBehavior.mirror(delay: duration * .5),
                        child: SizedBox.square(dimension: width * .16),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: DecoratedBoxActor(
                          color: AnimatableValue.tween(thumbColor, trackColor),
                          borderRadius: AnimatableValue.tween(
                            BorderRadius.circular(width * .2),
                            BorderRadius.circular(width * .2),
                          ),
                          motion: CueMotion.linear(duration * .5),
                          delay: duration * .5,
                          child: SizedBox(width: width * .08, height: width * .22),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
