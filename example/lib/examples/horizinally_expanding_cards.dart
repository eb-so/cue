import 'package:cue/cue.dart';
import 'package:flutter/material.dart';

class HorizontallyExpandingCards extends StatefulWidget {
  const HorizontallyExpandingCards({super.key});

  @override
  State<HorizontallyExpandingCards> createState() => _HorizontallyExpandingCardsState();
}

const cardsInfo = <({String title, String imageUrl})>[
  (
    title: 'Elegant',
    imageUrl: 'https://images.pexels.com/photos/261181/pexels-photo-261181.jpeg',
  ),
  (
    title: 'Awesome',
    imageUrl: 'https://images.pexels.com/photos/1166209/pexels-photo-1166209.jpeg',
  ),
  (
    title: 'Glamorous',
    imageUrl: 'https://images.pexels.com/photos/313032/pexels-photo-313032.jpeg',
  ),
];

class _HorizontallyExpandingCardsState extends State<HorizontallyExpandingCards> {
  int _expandedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 200,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final spacing = 8.0;
            final availableWidth = constraints.maxWidth - (spacing * 2);
            return Row(
              spacing: spacing,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < cardsInfo.length; i++)
                  Cue.onToggle(
                    toggled: i == _expandedIndex,
                    motion: CueMotion.smooth(),
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 0,
                      shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(20)),
                      clipBehavior: Clip.antiAlias,
                      child: Actor(
                        acts: [
                          Act.sizedClip(
                            from: NSize.width(availableWidth * 0.16),
                            to: NSize.width(availableWidth * 0.6),
                          ),
                        ],
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: .3), BlendMode.color),
                              image: NetworkImage(cardsInfo[i].imageUrl),
                              fit: BoxFit.cover,
                              opacity: .8,
                            ),
                          ),
                          child: InkWell(
                            onTap: () => setState(() {
                              if (_expandedIndex == i) {
                                _expandedIndex = -1;
                                return;
                              }
                              _expandedIndex = i;
                            }),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(14, 14, 14, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Actor(
                                    acts: [
                                      Act.align(from: Alignment.bottomCenter, to: Alignment.bottomLeft),
                                      Act.rotateLayout(from: -1, unit: RotateUnit.quarterTurns),
                                    ],
                                    child: Text(
                                      cardsInfo[i].title,
                                      style: textTheme.titleMedium?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Flexible(
                                    child: Actor(
                                      acts: [
                                        Act.fadeIn(),
                                        Act.clipHeight(fromFactor: .25),
                                      ],
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 14),
                                        child: Text(
                                          'This is a bunch of text that should only be visible when the card is expanded.',
                                          style: textTheme.bodySmall?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
