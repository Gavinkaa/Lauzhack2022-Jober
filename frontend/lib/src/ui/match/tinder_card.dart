import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jober/src/models/data/job.dart';
import 'package:jober/src/ui/match/match_view_model.dart';
import 'package:provider/provider.dart';

class TinderCard extends StatefulWidget {
  final Job job;
  final bool isFront;
  const TinderCard({
    Key? key,
    required this.job,
    required this.isFront,
  }) : super(key: key);

  @override
  _TinderCardState createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      final viewModel = Provider.of<MatchViewModel>(context, listen: false);
      viewModel.setScreenSize(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height-270,
      child: widget.isFront ? buildFrontCard() : buildCard(),
    );
  }

  Widget buildFrontCard() => GestureDetector(
    child: LayoutBuilder(
        builder: (context, constraints) {
          final viewModel = Provider.of<MatchViewModel>(context);
          final position = viewModel.position;
          final miliseconds = viewModel.isDragging ? 0 : 400;

          final center = constraints.smallest.center(Offset.zero);
          final angle = viewModel.angle * pi / 180;
          final rotatedMatrix = Matrix4.identity()
            ..translate(center.dx, center.dy)
            ..rotateZ(angle)
            ..translate(-center.dx, -center.dy);
          return AnimatedContainer(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: miliseconds),
              transform: rotatedMatrix..translate(position.dx, position.dy),
              child: Stack(
                  children: [
                    buildCard(),
                    buildStamps(),
                  ]
              )
          );
        }
    ),
    onPanStart: (details) {
      final viewModel = Provider.of<MatchViewModel>(context, listen: false);
      viewModel.startPosition(details);
    },
    onPanUpdate: (details) {
      final viewModel = Provider.of<MatchViewModel>(context, listen: false);
      viewModel.updatePosition(details);
    },
    onPanEnd: (details) {
      final viewModel = Provider.of<MatchViewModel>(context, listen: false);
      viewModel.endPosition();
    },
  );

  Widget buildCard() => ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Stack(
      children: [
        Hero(
          transitionOnUserGestures: true,
          tag: widget.job.hashCode,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: widget.job.imageUrl.contains("assets") ? AssetImage(widget.job.imageUrl) as ImageProvider
                    : NetworkImage(widget.job.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        buildCardOverlay(),
        buildInfo()
      ]
    ),
  );

  buildStamps() {
    final viewModel = Provider.of<MatchViewModel>(context);
    final status = viewModel.getStatus();
    final opacity = viewModel.getStatusOpacity();

    switch(status) {
      case CardStatus.like:
        final child = buildStamp(angle: -0.5, color: Colors.green, text: "LIKE", opacity: opacity);
        return Positioned(top: 64, left: 50, child: child,);
      case CardStatus.dislike:
        final child = buildStamp(angle: 0.5, color: Colors.red, text: "NOPE", opacity: opacity);
        return Positioned(top: 64, right: 50, child: child,);
      case CardStatus.superLike:
        final child = buildStamp(color: Colors.blue, text: "SUPER\nLIKE", opacity: opacity);
        return Positioned(bottom: 64, right: 50, left: 50, child: child,);
      default:
        return Container();
    }
  }

  Widget buildStamp({
    double angle = 0,
    required Color color,
    required String text,
    required double opacity,
  }) {
    return Opacity(
      opacity: opacity,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color, width: 4)
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfo() {
    return Positioned(
      bottom: 10,
      left: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.job.name, style: const TextStyle(color: Colors.white, fontSize: 42),),
          Container(
            width: MediaQuery.of(context).size.width-50,
            child: Text(widget.job.description, style: const TextStyle(color: Colors.white, fontSize: 18), maxLines: 2, overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    );
  }

  Widget buildCardOverlay() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.8),
          ],
          stops: [0.7, 1.0],
        ),
      ),
    );
  }
}
