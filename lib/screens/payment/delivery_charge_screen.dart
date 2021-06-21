import 'package:commerce/screens/order/order_screen.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:progress_hud/progress_hud.dart';

class DeliveryChargeScreen extends StatefulWidget {
  static String routeName = "/delivery_payment";
  @override
  _DeliveryChargeScreenState createState() => _DeliveryChargeScreenState();
}

class _DeliveryChargeScreenState extends State<DeliveryChargeScreen> {
  WebViewController _webViewController;
  String filePath = '';

  bool _loading = false;
  ProgressHUD _progressHUD;

  bool isSuccessfull = false;
  void _initializeProgressHud() {
    _progressHUD = new ProgressHUD(
      backgroundColor: Colors.black12,
      color: Colors.redAccent,
      containerColor: Colors.blueAccent,
      borderRadius: 5.0,
      //text: 'Loading...',
    );
  }

  void _showProgressHud() {
    if (this.mounted) {
      setState(() {
        _loading = true;
      });
    }
  }

  void _hideProgressHud() {
    if (this.mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<bool> _onBackPressed() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final DeliveryArguments agrs = ModalRoute.of(context).settings.arguments;
    print('$baseUrl/order/${agrs.orderId}/pay-delivery');
    return WillPopScope(
        child: Scaffold(
          appBar: _appbar(),
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.transparent,
                child: WebView(
                  initialUrl: '$baseUrl/order/${agrs.orderId}/pay-delivery',
                  javascriptMode: JavascriptMode.unrestricted,
                  javascriptChannels: <JavascriptChannel>[
                    _alertJavascriptChannel(context),
                  ].toSet(),
                  onWebViewCreated:
                      (WebViewController webViewController) async {
                    _webViewController = webViewController;
                    //_loadHtmlFromAssets();

                    _webViewController.loadUrl(filePath);
                  },
                  onPageStarted: (String url) {
                    print(
                        "==============================================================");
                    print('Page started loading: $url');
                    print(
                        "==============================================================");
                    _showProgressHud();

                    if (url.contains("success") && url.contains(rootUrl)) {
                      isSuccessfull = true;
                      Navigator.popAndPushNamed(
                        context,
                        OrderScreen.routeName,
                        arguments: OrderDetailsArguments(agrs.orderId),
                      );
                      _onBackPressed();
                    } else if (url.contains("cancel")) {
                      isSuccessfull = false;
                      _onBackPressed();
                    } else if (url.contains("fail")) {
                      isSuccessfull = false;
                      _onBackPressed();
                    } else if (url.contains("payment/error")) {
                      isSuccessfull = false;
                      _onBackPressed();
                    }
                  },
                  onPageFinished: (String url) {
                    print(
                        "==============================================================");
                    print('Page finished loading: $url');
                    print(
                        "==============================================================");
                    _hideProgressHud();
                  },
                  gestureNavigationEnabled: true,
                ),
              ),
              Visibility(
                visible: _loading,
                child: Center(child: CircularProgressIndicator()),
              )
            ],
          ),
        ),
        onWillPop: _onBackPressed);
  }

  Widget _appbar() {
    return AppBar(
      leading: SizedBox(),
      title: Text(
        "Online Payment",
        style: new TextStyle(fontSize: 25.0),
      ),
      backgroundColor: Colors.white,
      elevation: 4.0,
    );
  }

  JavascriptChannel _alertJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toast',
        onMessageReceived: (JavascriptMessage message) {
          print("${message.message}");

          if (message.message == "ready") {
            //_webViewController.evaluateJavascript('getAuthToken()');
          }
        });
  }
}

class DeliveryArguments {
  final orderId;
  DeliveryArguments(this.orderId);
}
