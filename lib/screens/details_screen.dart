import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/widgets/widgets.dart';


class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //TODO: Cambiar luego por una instancia de movie

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    print(movie.title);

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            _CustomAppBar( movie ),
            SliverList(
                delegate: SliverChildListDelegate([
                  _PosterAndTitle( movie ),
                  _Overview( movie ),
                  _Overview( movie ),
                  _Overview( movie ),
                  CastingCards(movie.id  )
                ])
            )
          ],
        )
    );
  }
}
class _CustomAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomAppBar(this.movie);


  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.teal,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10, left: 10, right: 20),
          color: Colors.black12,
          child: Text(
            movie.title,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movie movie;
  const _PosterAndTitle(this.movie);


  @override
  Widget build(BuildContext context) {
    
    final  TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Hero(
            tag:movie.heroId!,
            child: ClipRRect(
              borderRadius:BorderRadius.circular(30),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                height: 150,
              ),
            ),
          ),
          SizedBox(width: 40),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 160),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(movie.title , style:textTheme.headline5, overflow: TextOverflow.ellipsis,maxLines: 2),

                Text(movie.originalTitle,style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis),
                Row(
                  children: [
                    Icon(Icons.star_outline, size: 15, color: Colors.grey),
                    SizedBox(width: 20),
                    Text('${movie.voteAverage}',style: Theme.of(context).textTheme.caption )
                  ],
                )
                
              ],
              
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {

  final Movie movie;

  const _Overview(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child:Text(
        movie.overview,
      textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}

