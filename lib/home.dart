import 'package:flutter/material.dart';

class Pringles extends StatefulWidget {
  const Pringles({Key? key}) : super(key: key);

  @override
  State<Pringles> createState() => _PringlesState();
}

class _PringlesState extends State<Pringles> {

  int prev_index = 0;
  int color_index = 0;
  int temp = -1;

  List<Color> backgroundColors = [Colors.red, Color(0xffea9e30), Color(0xff4aac41), Color(0xff740d3d), Color(0xff302d74)];
  Color background_color = Colors.red;

  List<String>descriptions = [
    "Crispy potato perfection with the classic Original Pringles, delivering a timeless snack experience that's impossible to resist.",
    "Indulge in the bold and savory flavor of Cheddar Cheese Pringles, where the irresistible combination of real cheese and crispy potato chips creates a snack that's cheesier than ever.",
    "Unleash the zesty harmony of sour cream and savory onion with Sour Cream and Onion Pringles, a deliciously seasoned chip that will keep you reaching for more.",
    "Satisfy your craving for smoky, tangy goodness with BBQ Pringles, where each chip is infused with the perfect blend of barbecue spices for a flavor explosion in every bite."
  ];
  List<String>   headings = ["Original Pringles", "Cheddar Cheese Pringles", "Sour Cream and Onion Pringles", "BBQ Pringles"];

  List<String> product_images = ['product3_pringles.png', 'product6_pringles.png', 'product4_pringles.png', 'product5_pringles.png',];

  PageController _pageController = PageController(viewportFraction: 0.5);

  Color getCurrentBackgroundColor() {
    return backgroundColors[color_index];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    background_color = backgroundColors[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      body: Stack(
        children: [
          _buildBackgroundContainer(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildBackgroundContainer() {
    return AnimatedPositioned(
      onEnd: () {
        background_color = backgroundColors[color_index];

        if (prev_index != color_index) {
          temp = prev_index;
        }

        prev_index = color_index;
        setState(() {});
      },
      curve: Curves.linear,
      top: color_index != temp ? MediaQuery.of(context).size.height * 0.5 : -MediaQuery.of(context).size.height * 0.8,
      bottom: color_index != temp ? MediaQuery.of(context).size.height * 0.5 : -MediaQuery.of(context).size.height * 0.8,
      left: color_index != temp ? MediaQuery.of(context).size.width * 0.5 : -MediaQuery.of(context).size.width * 0.3,
      right: color_index != temp ? MediaQuery.of(context).size.width * 0.5 : -MediaQuery.of(context).size.width * 0.3,
      duration: Duration(milliseconds: 500),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: color_index != temp ? 10 : MediaQuery.of(context).size.height,
        width: color_index != temp ? 10 : MediaQuery.of(context).size.width,
        curve: Curves.linear,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: getCurrentBackgroundColor().withOpacity(1.0),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        _buildTopBar(),
        Expanded(
          child: _buildMainContent(),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return Row(
      children: [
        _buildCircleContainer(),
        _buildCheddarCheeseInfo(),
        _buildVerticalDivider(),
        _buildListView(),
      ],
    );
  }

  Widget _buildTopBar() {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _getTitleText('PRODUCTS'),
          _getTitleText('FLAVOURS'),
          _getTitleText('STORE'),
          Image.asset(
            'assets/pringles/logo_pringles.png',
            height: 40,
          ),
          _getTitleText('ABOUT'),
          _getTitleText('FOUNDERS'),
          _getTitleText('CONTACT'),
        ],
      ),
    );
  }

  Widget _buildCheddarCheeseInfo() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getTitleText('${headings[color_index]}', fontSize: 36, fontWeight: FontWeight.bold),
            SizedBox(height: 20),
            _getTitleText(
              '${descriptions[color_index]}',
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Order now',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleContainer() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.5 - MediaQuery.of(context).size.width * 0.1,
      child: Stack(
        children: [
          Positioned(
            left: -(MediaQuery.of(context).size.width * 0.1),
            top: 0,
            bottom: 0,
            child: ClipOval(
              child: Container(
                width: MediaQuery.of(context).size.width / 2.8,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage('assets/pringles/potato.jpeg'), fit: BoxFit.fitHeight),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 2,
      height: MediaQuery.of(context).size.height * 0.85,
      color: Colors.white70,
    );
  }

  Widget _buildListView() {
    return Expanded(
      child: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: product_images.length,
        onPageChanged: (int index) {
          if (color_index == index) {
            return;
          }

          if (temp != color_index && color_index == prev_index) {
            color_index = index;
            temp = index;
            setState(() {});
          }
        },
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () {
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 300),
                curve: Curves.linear,
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 35, right: 35),
              height: 300,
              width: 200,
              child: Image.asset(
                'assets/pringles/${product_images[index]}',
                height: (index == color_index) ? 300 : 180,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _getTitleText(String text, {double fontSize = 14, FontWeight fontWeight = FontWeight.w500}) {
    return Text(
      text, maxLines: 3,
      style: TextStyle(color: Colors.white70, fontWeight: fontWeight, fontSize: fontSize),
    );
  }
}


