import 'package:flutter/material.dart';
import 'package:flutter_pizza_app_ui/models/pizza_data.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class DetailPage extends StatelessWidget {
  final Pizza _pizza;

  DetailPage(this._pizza);

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setNavigationBarColor(Color(0xff000000));
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  BackgroundContent(_pizza.background),
                  ForegroundContent(_pizza)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundContent extends StatelessWidget {
  final Color _background;

  BackgroundContent(this._background);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: BackgroundPainter(_background),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final Color _color;
  Path path = Path();

  BackgroundPainter(this._color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint painter = Paint()..color = _color;
    path.moveTo(250, 0);
    path.quadraticBezierTo(150, 125, 240, 270);
    path.quadraticBezierTo(300, 345, 450, 350);
    path.lineTo(500, 0);
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ForegroundContent extends StatelessWidget {
  final Pizza _pizza;

  ForegroundContent(this._pizza);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 70),
            child: IconButton(
              iconSize: 32.0,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        PizzaImage(_pizza.image),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(left: 100, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TitleWidget(_pizza.name),
              SizedBox(height: 30),
              StarRating(_pizza.starRating),
              SizedBox(height: 30),
              Description(_pizza.desc),
              SizedBox(height: 30),
              Price(_pizza.price),
              SizedBox(
                height: 20,
              ),
              BottomButtons(),
              SizedBox(
                height: 35,
              )
            ],
          ),
        )
      ],
    );
  }
}

class PizzaImage extends StatelessWidget {
  final String _pizzaImageURI;

  PizzaImage(this._pizzaImageURI);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: Image.asset(_pizzaImageURI),
    );
  }
}

class TitleWidget extends StatelessWidget {
  final String _title;
  final double _fontSize = 40;

  TitleWidget(this._title);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: _title,
            style: TextStyle(
                color: Colors.black,
                fontSize: _fontSize,
                fontFamily: 'Slabo',
                fontWeight: FontWeight.w500)),
        TextSpan(
            text: " Pizza",
            style: TextStyle(
                color: Colors.black,
                fontSize: _fontSize,
                fontFamily: 'Slabo',
                fontWeight: FontWeight.w600))
      ]),
    );
  }
}

class StarRating extends StatelessWidget {
  final double _rating;

  StarRating(this._rating);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          '$_rating',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        SizedBox(
          width: 5,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow[600],
        )
      ],
    );
  }
}

class Description extends StatelessWidget {
  final String _description;

  Description(this._description);

  @override
  Widget build(BuildContext context) {
    return Text(
      _description,
      softWrap: true,
      style: TextStyle(
          fontSize: 17,
          color: Colors.black87,
          letterSpacing: 1.3,
          textBaseline: TextBaseline.alphabetic),
    );
  }
}

class Price extends StatelessWidget {
  final double _price;

  Price(this._price);

  @override
  Widget build(BuildContext context) {
    return Text(
      '\$$_price',
      style: TextStyle(
          fontSize: 25, fontWeight: FontWeight.w700, color: Colors.black),
    );
  }
}

class BottomButtons extends StatefulWidget {
  @override
  _BottomButtonsState createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
  bool _isFav;
  bool _isCart;

  @override
  void initState() {
    super.initState();
    _isFav = false;
    _isCart = false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.black, width: 5.0))),
          child: FlatButton(
            onPressed: () {
              setState(() {
                _isCart = !_isCart;
              });
            },
            child: Text(
              _isCart ? 'Remove from Cart' : 'Add to Cart',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            setState(() {
              _isFav = !_isFav;
            });
          },
          child: Icon(
            _isFav ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
          backgroundColor: Colors.white,
          elevation: 3,
        )
      ],
    );
  }
}
