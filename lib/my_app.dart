import 'package:introduction_screen/introduction_screen.dart';
import 'package:maico_land/bloc/auth_bloc/auth.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/presentation/screens/auth_screen/widgets/lib_import.dart';
import 'package:maico_land/presentation/screens/home_screen/home_screen.dart';
import 'package:maico_land/router/app_router.dart';

import 'presentation/screens/account/account_screen.dart';
import 'presentation/screens/create_option_screen/create_option_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({required this.appRouter, required this.userRepo, Key? key})
      : super(key: key);
  final UserRepository userRepo;
  final AppRouter appRouter;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  int _selectedIndex = 0;

//   accessToken
// "pk.eyJ1IjoiYW5kcmVhdHJhbjIwMDIiLCJhIjoiY2t4aXZndmk0NTFodTJwbXVlbXJpNnM0dyJ9.fOnQcO_C_2T8wlNCzIWzwQ"
// content
// "Chưa có thông tin"
// dateCreated
// January 2, 2022 at 12:00:00 AM UTC+7
// imageUrl
// "https://firebasestorage.googleapis.com/v0/b/tinevyland.appspot.com/o/images%2Fphuquoc.png%20(3).png?alt=media&token=834de6b7-3b65-4305-8eb5-d670da4bba27"
// isValidated
// true
// leftBotton
// [10.006904668867175° N, 103.980668° E]
// leftTop
// [10.085334° N, 103.980668° E]
// mapUrl
// "https://api.mapbox.com/styles/v1/andreatran2002/ckxjye6d2kw0p15o562zzeg4g/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYW5kcmVhdHJhbjIwMDIiLCJhIjoiY2t4aXZndmk0NTFodTJwbXVlbXJpNnM0dyJ9.fOnQcO_C_2T8wlNCzIWzwQ"
// rightBotton
// [10.006904668867175° N, 104.0368015904123° E]
// rightTop
// [10.085334° N, 104.036458° E]
// title
// "Quy hoạch đô thị An Thới huyện Phú Quốc tỉnh Kiên Giang"
// (string)

  final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const CreateOptionScreen(),
    AccountScreen(userRepo: UserRepository()),
    // DetailMapLandPlanning(
    //     landPlanning: LandPlanning(
    //         id: "123",
    //         title: "test",
    //         content: "Chuwa co thong tin",
    //         dateCreated: DateTime.now(),
    //         isValidated: true,
    //         leftBottom: GeoPoint(106.556801, 10.7399685),
    //         leftTop: GeoPoint(106.556801, 10.776478),
    //         rightBottom: GeoPoint(106.6087906, 10.7399533),
    //         rightTop: GeoPoint(106.6087906, 10.776478),
    //         imageUrl:
    //             "https://firebasestorage.googleapis.com/v0/b/maico-8490f.appspot.com/o/images%2F6292a378bf10704e2901.jpg?alt=media&token=b5b7874f-0c5e-48ca-bae4-f16796a90d23")),
    // CreateItemScreen(),
    // AccountScreen()
  ];
<<<<<<< HEAD
=======

  late double widthBackground, heightBackground, withIconImage, heightIconImage;
  @override
  void initState() {
    super.initState();
  }

>>>>>>> f061ebe89943e46eedca486ab6d11dec7a93d0a3
  final listPageIntro = [
    PageViewModel(
        decoration: const PageDecoration(
            // fullScreen: true,
            titlePadding: EdgeInsets.all(0),
            imagePadding: EdgeInsets.only(bottom: 0),
            contentMargin: EdgeInsets.only(bottom: 10),
            imageFlex: 1),
        titleWidget: const Text(
          "Your property, our priority",
          style: textLargeBlack,
          textAlign: TextAlign.center,
        ),
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              width: 600,
              height: 100,
              image: NetworkImage(
                  'https://maicogroup.com/wp-content/uploads/2022/01/5-1448x2048.png'),
            ),
            Text(
              "Chúng tôi đã và đang thay đổi cách thức thực hiện dịch vụ và giao dịch Bất động sản tại Việt Nam ",
              maxLines: 3,
              style: textNormalBlack,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Xây dựng Mô hình dịch vụ và Nền tảng công nghệ làm cho ",
              style: textNormalBlack,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Bất động sản Dễ hơn bao giờ hết!",
              style: textLargeBlack,
              textAlign: TextAlign.center,
            )
          ],
        ),
        image: const Image(
          fit: BoxFit.scaleDown,
          // width: MediaQuery.of(context).size.width,
          height: 600,
          image: AssetImage('assets/logo.png'),
        )),
    PageViewModel(
        decoration: const PageDecoration(
          // fullScreen: true,
          titlePadding: EdgeInsets.all(5),
        ),
        titleWidget: const Text(
          "Với mục tiêu",
          style: textLargeBlack,
          textAlign: TextAlign.center,
        ),
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Image(
                      height: 140,
                      image: NetworkImage(
                          "https://maicogroup.com/wp-content/uploads/2022/01/5-1448x2048.png"),
                    ),
                    Text(
                      "Giao dịch Minh bạch",
                      style: textMediumGreen,
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Image(
                      height: 140,
                      image: NetworkImage(
                          "https://maicogroup.com/wp-content/uploads/2022/01/6-1448x2048.png"),
                    ),
                    Text(
                      "Thông tin chính xác",
                      style: textMediumGreen,
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Image(
                      height: 140,
                      image: NetworkImage(
                          "https://maicogroup.com/wp-content/uploads/2022/01/7-1-1448x2048.png"),
                    ),
                    Text(
                      "Không ngừng phát triển",
                      style: textMediumGreen,
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Image(
                      height: 140,
                      image: NetworkImage(
                          "https://maicogroup.com/wp-content/uploads/2022/01/8-1448x2048.png"),
                    ),
                    Text(
                      "Tử tế là cốt lõi",
                      style: textMediumGreen,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
        image: const Image(
          width: 600,
          height: 1000,
          image: NetworkImage(
              "https://firebasestorage.googleapis.com/v0/b/helloworld-926c4.appspot.com/o/1579238229095%20(1).png?alt=media&token=aa3aaa3a-5624-493c-abba-8eca3dee3567"),
        )),
    PageViewModel(
        titleWidget: const Text(
          "Phát triển bền vững",
          style: textLargeBlack,
          textAlign: TextAlign.center,
        ),
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              height: 140,
              image: NetworkImage(
                  "https://maicogroup.com/wp-content/uploads/2022/01/Design-Website-maicogroup.com_-1-300x85.png"),
            ),
            Text(
              "Hãy đồng hành cùng MAICO vươn lên tầm cao mới!",
              style: textMediumGreen,
            )
          ],
        ),
        image: const Image(
          width: 600,
          height: 1000,
          image: NetworkImage(
              "https://maicogroup.com/wp-content/uploads/2022/01/one-day-with-maico-768x512.jpg"),
        ))
  ];
<<<<<<< HEAD
  late double widthBackground, heightBackground, withIconImage, heightIconImage;
  @override
  void initState() {
    super.initState();
  }
=======
>>>>>>> f061ebe89943e46eedca486ab6d11dec7a93d0a3

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MaicoLand',
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: widget.appRouter.onGenerateRoute,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            // print(user);
            return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.white,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                elevation: 0,
                mouseCursor: SystemMouseCursors.grab,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add_circle_outline),
                    label: 'Thêm tin',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    label: 'Account',
                  ),
                ],
                currentIndex: _selectedIndex, //New
                onTap: _onItemTapped,
              ),
              body: Center(
                child: _pages.elementAt(_selectedIndex), //New
              ),
            );
          }
          if (state is AuthenticationUnauthenticated) {
            return Scaffold(
              body: IntroductionScreen(
                pages: [
                  PageViewModel(
                      decoration: const PageDecoration(
                          // fullScreen: true,
                          titlePadding: EdgeInsets.all(0),
                          imagePadding: EdgeInsets.only(bottom: 0),
                          contentMargin: EdgeInsets.only(bottom: 10),
                          imageFlex: 1),
                      titleWidget: const Text(
                        "Your property, our priority",
                        style: textLargeBlack,
                        textAlign: TextAlign.center,
                      ),
                      bodyWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: MediaQuery.of(context).size.width * 0.3,
                            image: const AssetImage('assets/images/hand.png'),
                          ),
                          const Text(
                            "Chúng tôi đã và đang thay đổi cách thức thực hiện dịch vụ và giao dịch Bất động sản tại Việt Nam ",
                            maxLines: 3,
                            style: textNormalBlack,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Xây dựng Mô hình dịch vụ và Nền tảng công nghệ làm cho ",
                            style: textNormalBlack,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            "Bất động sản Dễ hơn bao giờ hết!",
                            style: textLargeBlack,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                      image: Image(
                        height: MediaQuery.of(context).size.height,
                        image: const AssetImage('assets/logo.png'),
                      )),
                  PageViewModel(
                      decoration: const PageDecoration(
                        // fullScreen: true,
                        titlePadding: EdgeInsets.all(5),
                      ),
                      titleWidget: const Text(
                        "Với mục tiêu",
                        style: textLargeBlack,
                        textAlign: TextAlign.center,
                      ),
                      bodyWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    image: const AssetImage(
                                        'assets/images/hand.png'),
                                  ),
                                  const Text(
                                    "Giao dịch Minh bạch",
                                    style: textMediumGreen,
                                  )
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    image: const AssetImage(
                                        'assets/images/tick.png'),
                                  ),
                                  const Text(
                                    "Thông tin chính xác",
                                    style: textMediumGreen,
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    image: const AssetImage(
                                        'assets/images/growup.png'),
                                  ),
                                  const Text(
                                    "Không ngừng phát triển",
                                    style: textMediumGreen,
                                  )
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    image: const AssetImage(
                                        'assets/images/heart.png'),
                                  ),
                                  const Text(
                                    "Tử tế là cốt lõi",
                                    style: textMediumGreen,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      image: Image(
                        width: MediaQuery.of(context).size.width,
                        image:
                            const AssetImage('assets/images/background2.png'),
                      )),
                  PageViewModel(
                      titleWidget: const Text(
                        "Phát triển bền vững",
                        style: textLargeBlack,
                        textAlign: TextAlign.center,
                      ),
                      bodyWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            height: MediaQuery.of(context).size.height * 0.2,
                            image: const AssetImage(
                                'assets/images/maicosystem.png'),
                          ),
                          const Text(
                            "Hãy đồng hành cùng MAICO vươn lên tầm cao mới!",
                            style: textMediumGreen,
                          )
                        ],
                      ),
                      image: const Image(
                        image: AssetImage('assets/images/image4.jpg'),
                      ))
                ],
                onDone: () {
                  // When done button is press
                },
                showBackButton: false,
                showSkipButton: true,
                next: Container(
                    decoration: boxBorderGreen,
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: const Text(
                      "Tiếp",
                      style: textMediumWhite,
                    )),
                skip: const Text("Bỏ qua"),
                onSkip: () {
                  Navigator.of(context).pushNamed('/loginorregister');
                },
                done: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/loginorregister');
                  },
                  child: Container(
                      decoration: boxBorderGreen,
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: const Text("Xong", style: textMediumWhite)),
                ),
              ),
            );
            // return RegisterScreen(userRepo: widget.userRepo);
          }
          if (state is AuthenticationLoading) {
            return const Scaffold(body: CircularProgressIndicator());
          }
          return const Scaffold(body: CircularProgressIndicator());
        }));
  }
}

final ThemeData appTheme = _buildAppTheme();

ThemeData _buildAppTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.appGreen2,
        onPrimary: AppColors.white,
        secondary: AppColors.appGreen4,
        error: AppColors.appErrorRed,
      ),
      textTheme: _buildAppTextTheme(base.textTheme),
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: AppColors.appGreen1,
      ),
      backgroundColor: AppColors.appGreen1);
}

TextTheme _buildAppTextTheme(TextTheme base) {
  return base
      .copyWith(
          headline1: base.headline1!.copyWith(
            fontSize: 30.0,
          ),
          headline5: base.headline5!.copyWith(
            fontWeight: FontWeight.w500,
          ),
          headline6: base.headline6!.copyWith(
            fontSize: 18.0,
          ),
          caption: base.caption!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
          bodyText1: base.bodyText1!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ))
      .apply(
        fontFamily: 'Montsterrat',
        displayColor: Colors.black,
        bodyColor: Colors.black,
      );
}
