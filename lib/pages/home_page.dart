import 'package:flutter/material.dart';
import 'package:flutter_pizza_app_ui/models/pizza_data.dart';
import 'package:flutter_pizza_app_ui/pages/detail_page.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setNavigationBarColor(Color(0xff000000));
    return Scaffold(
      body: HomePageRootWidget(),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class HomePageRootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 50.0, right: 30.0),
      child: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              titleBar(),
              tabs(),
            ],
          ),
        ],
      ),
    );
  }
}

Widget titleBar() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        height: 70,
      ),
      Text(
        'Featured',
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 50,
        ),
      ),
      Text(
        'Food',
        style: TextStyle(
          fontSize: 50,
        ),
      ),
    ],
  );
}

Widget tabs() {
  return Container(
    height: 600,
    width: double.infinity, // Max width
    child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20), // Add extra height to appbar
              child: Container(
                color: Colors.transparent,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      TabBar(
                        isScrollable: true,
                        labelPadding: EdgeInsets.only(top: 15),
                        indicatorColor: Colors.transparent,
                        labelColor: Colors.black,
                        labelStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Slabo'),
                        unselectedLabelColor: Colors.black26,
                        unselectedLabelStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w200,
                            fontFamily: 'Slabo'),
                        tabs: <Widget>[
                          Text('Pizza'),
                          Container(
                              padding: EdgeInsets.only(left: 30.0),
                              child: Text('Rolls')),
                          Container(
                              padding: EdgeInsets.only(left: 30.0),
                              child: Text('Burger')),
                          Container(
                              padding: EdgeInsets.only(left: 30.0),
                              child: Text('Sandwiches'))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              pizzaShowCase(),
              Center(
                child: Text(
                  "Rolls Tab",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Center(
                child: Text(
                  "Burgers Tab",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Center(
                child: Text(
                  "Sandwiches Tab",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        )),
  );
}

Widget pizzaShowCase() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 30),
    child: ListView.builder(
        itemCount: pizzaList.pizzas.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return PizzaItem(pizzaList.pizzas[index]);
        }),
  );
}

class PizzaItem extends StatelessWidget {
  final Pizza _pizza;

  PizzaItem(this._pizza);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DetailPage(_pizza)));
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 35, horizontal: 20),
            width: 225,
            decoration: BoxDecoration(
                color: _pizza.background,
                borderRadius: BorderRadius.circular(40.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 180,
                  child: Image.asset(_pizza.image),
                ),
                SizedBox(
                  height: 30,
                ),
                RichText(
                  softWrap: true,
                  text: TextSpan(
                      style: TextStyle(
                          color: _pizza.foreground,
                          fontSize: 25,
                          fontFamily: 'Slabo'),
                      children: [
                        TextSpan(text: _pizza.name),
                        TextSpan(
                            text: "\nPizza",
                            style: TextStyle(fontWeight: FontWeight.w800))
                      ]),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('\$${_pizza.price}',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: _pizza.foreground,
                              fontFamily: 'arial')),
                    ),
                    FavouriteIcon(_pizza.foreground)
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class FavouriteIcon extends StatefulWidget {
  final Color _foreground;

  FavouriteIcon(this._foreground);

  @override
  _FavouriteIconState createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<FavouriteIcon> {
  bool _isFav;

  @override
  void initState() {
    super.initState();
    _isFav = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFav = !_isFav;
        });
      },
      child: Icon(
        _isFav ? Icons.favorite : Icons.favorite_border,
        color: widget._foreground,
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  final double _size = 60;
  final double _padding = 17;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0.0,
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: _size + 15,
              width: _size + 15,
              padding: EdgeInsets.all(_padding),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  'https://wallpapercave.com/wp/wp5042848.jpg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              height: _size,
              width: _size,
              padding: EdgeInsets.all(_padding),
              child: Image.asset(
                'assets/images/home_icon.png',
                fit: BoxFit.contain,
              ),
            ),
            Container(
              height: _size,
              width: _size,
              padding: EdgeInsets.all(_padding),
              child: Image.asset(
                'assets/images/search_icon.png',
                fit: BoxFit.contain,
              ),
            ),
            Container(
              height: _size,
              width: _size,
              padding: EdgeInsets.all(_padding),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(50)),
              child: Image.asset(
                'assets/images/bag_icon.png',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
