import 'package:flutter/material.dart';
import 'package:jober/src/models/data/job.dart';
import 'package:jober/src/ui/match_detail/match_detail_view_model.dart';
import 'package:palette_generator/palette_generator.dart';


class MatchDetailView extends StatefulWidget {
  Job job;
  MatchDetailView({Key? key, required this.job}) : super(key: key);

  @override
  State<MatchDetailView> createState() => _MatchDetailViewState();
}

class _MatchDetailViewState extends State<MatchDetailView> {
  PaletteGenerator? _paletteGenerator;
  final _viewModel = MatchDetailViewModel();


  @override
  void initState() {
    super.initState();
    getPalette();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _viewModel.scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 400.0,
                floating: true,
                pinned: true,
                backgroundColor: _paletteGenerator?.dominantColor?.color,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: widget.job.hashCode,
                    child: Stack(
                      children: [
                        Positioned.fill(child: widget.job.imageUrl.contains("assets") ? Image.asset(widget.job.imageUrl, fit: BoxFit.cover)
                            : Image.network(widget.job.imageUrl, fit: BoxFit.cover),),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.8),
                              ],
                              stops: const [0.8, 1.0],
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                  title: Text(widget.job.name),
                  centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                )
              ),
            ];
          },
          body: Center(
            child: Text("TODO IMPLEMENTS"),
          ),
      ),
    );
  }

  void getPalette() async {
    PaletteGenerator.fromImageProvider(
      widget.job.imageUrl.contains("assets") ? Image.asset(widget.job.imageUrl).image : Image.network(widget.job.imageUrl).image
    ).then((value) =>
      setState(() => _paletteGenerator = value)
    );
  }

  @override
  void dispose() {
    _viewModel.disposeController();
    super.dispose();
  }
}
