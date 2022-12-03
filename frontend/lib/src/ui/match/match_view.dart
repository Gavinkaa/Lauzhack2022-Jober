import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jober/src/ui/match/match_view_model.dart';
import 'package:jober/src/ui/match/tinder_card.dart';
import 'package:provider/provider.dart';

class MatchView extends StatelessWidget {
  MatchView({Key? key}) : super(key: key);
  static const routeName = "/match";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                buildCards(context),
                const SizedBox(height: 16,),
                buildButtons(context),
              ],
            )
        ),
      )
    );
  }

  Widget buildCards(BuildContext context) {
    final viewModel = Provider.of<MatchViewModel>(context);
    final jobs = viewModel.jobs;
    return jobs.isEmpty ? Center(
      child: ElevatedButton(
        child: const Text("Restart"),
        onPressed: () {
          viewModel.resetUsers();
        },
      ),
    )
        : Stack(
      children: jobs.map((job) => GestureDetector(
        onTap: () {
          viewModel.navigateToDetail(context, job);
        },
        child: TinderCard(
            job: job,
            isFront: jobs.last == job
        ),
      )).toList(),
    );
  }

  Widget buildButtons(BuildContext context) {
    final viewModel = Provider.of<MatchViewModel>(context);
    final status = viewModel.getStatus();
    final isLike = status == CardStatus.like;
    final isDislike = status == CardStatus.dislike;
    final isSuperLike = status == CardStatus.superLike;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            style: ButtonStyle(
              foregroundColor: getColor(Colors.red, Colors.white, isDislike),
              backgroundColor: getColor(Colors.white, Colors.red, isDislike),
              shape: MaterialStateProperty.all(const CircleBorder()),
              side: getBorder(Colors.red, isDislike),
              minimumSize:MaterialStateProperty.all(const Size.square(70)),
              elevation: getElevation(isDislike),
            ),
            onPressed: () {
              HapticFeedback.lightImpact();
              viewModel.dislike();
            },
            child: const Icon(Icons.clear, size: 40)
        ),
        ElevatedButton(
            style: ButtonStyle(
              foregroundColor: getColor(Colors.blue, Colors.white, isSuperLike),
              backgroundColor: getColor(Colors.white, Colors.blue, isSuperLike),
              shape: MaterialStateProperty.all(const CircleBorder()),
              side: getBorder(Colors.blue, isSuperLike),
              minimumSize:MaterialStateProperty.all(const Size.square(70)),
              elevation: getElevation(isSuperLike),
            ),
            onPressed: () {
              HapticFeedback.lightImpact();
              viewModel.superlike();
            },
            child: const Icon(Icons.star, size: 40)
        ),
        ElevatedButton(
            style: ButtonStyle(
              foregroundColor: getColor(Colors.green, Colors.white, isLike),
              backgroundColor: getColor(Colors.white, Colors.green, isLike),
              shape: MaterialStateProperty.all(const CircleBorder()),
              side: getBorder(Colors.green, isLike),
              minimumSize:MaterialStateProperty.all(const Size.square(70)),
              elevation: getElevation(isLike),
            ),
            onPressed: () {
              HapticFeedback.lightImpact();
              viewModel.like();
            },
            child: const Icon(Icons.favorite, size: 40)
        ),
      ],
    );
  }

  MaterialStateProperty<Color> getColor(Color color, Color colorPressed, bool force) {
    getColor(Set<MaterialState> states) {
      if (force || states.contains(MaterialState.pressed)) {
        return colorPressed;
      }
      return color;
    }
    return MaterialStateProperty.resolveWith(getColor);
  }

  MaterialStateProperty<double> getElevation(bool force) {
    getElevation(Set<MaterialState> states) {
      if (force || states.contains(MaterialState.pressed)) {
        return 3.0;
      }
      return 8.0;
    }
    return MaterialStateProperty.resolveWith(getElevation);
  }

  MaterialStateProperty<BorderSide> getBorder(Color color, bool force) {
    getBorder(Set<MaterialState> states) {
      if (force || states.contains(MaterialState.pressed)) {
        return const BorderSide(color: Colors.transparent);
      }
      return BorderSide(color: color, width: 2);
    }
    return MaterialStateProperty.resolveWith(getBorder);
  }
}
