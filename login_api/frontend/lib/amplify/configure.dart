import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:login_api/controllers/new_account.dart';
import 'package:login_api/models/new_user_info.dart';
import 'package:login_api/models/user.model.dart';
import 'package:login_api/pages/uteis/snackbar.dart';
import '../amplifyconfiguration.dart';
import '../pages/uteis/validators.dart';

Future<bool> configureAmplify(context) async {
  final auth = AmplifyAuthCognito();
  final api = AmplifyAPI();

  if (Amplify.isConfigured) return true;

  try {
    Amplify.addPlugins([api, auth]);
    await Amplify.configure(amplifyconfig);

    return true;
  } on AmplifyAlreadyConfiguredException catch (e) {
    displayError(context, e.message);
    return false;
  }
}

Future<AuthAmp?> getCurrentUserId(context) async {
  try {
    final user = await Amplify.Auth.getCurrentUser();

    final result = await Amplify.Auth.fetchUserAttributes();
    for (final element in result) {
      safePrint('key: ${element.userAttributeKey}; value: ${element.value}');
    }

    return AuthAmp.fromAmplify(user, result);
  } on AuthException catch (e) {
    //displayError(context, 'Could not retrieve current user: ${e.message}');
    return null;
  }
}

Future<bool> onLogin(context, String user, String pwd) async {
  try {
    final res = await Amplify.Auth.signIn(
      username: user,
      password: pwd,
    );
    return true;
  } on AuthException catch (e) {
    displayError(context, e.message);
    return false;
  }
}

Future<String?> get_customer(context, String taxId, String dob) async {
  try {
    dob = dateToStr(strToDate(dob, "MM/dd/yyyy"), "yyyyMMdd");
    final restOperation = Amplify.API.post(
      '/validateCustomer',
      body: HttpPayload.json({'taxId': taxId, 'dateOfBirth': dob}),
    );
    final response = await restOperation.response;
    print('POST call succeeded');
    return response.decodeBody();
  } on HttpStatusException catch (e) {
    displayError(context, e.message);
    //print('${e.message} - ${e..recoverySuggestion}');
    return null;
  }
}

Future<String?> onSignUp(context, String username, String password) async {
  try {
    var userInfo = NewAccountController.instance.user;

    final userAttributes = <AuthUserAttributeKey, String>{
      //AuthUserAttributeKey.email: user_info["email"],
      AuthUserAttributeKey.email: "melque_ex@yahoo.com.br",
      const _AuthUserAttributeKey("custom:taxid"): userInfo.tax_id ?? "",
      const _AuthUserAttributeKey("custom:custkey"): userInfo.cust_key ?? ""
    };

    final res = await Amplify.Auth.signUp(
      username: username,
      password: password,
      options: SignUpOptions(userAttributes: userAttributes),
    );
    return "Ok";
  } on AuthException catch (e) {
    displayError(context, e.message);
    //return '${e.message} - ${e..recoverySuggestion}';
    return null;
  }
}

Future<String?> onValidate(context, username, confirmationCode) async {
  try {
    final res = await Amplify.Auth.confirmSignUp(
        username: username, confirmationCode: confirmationCode);
    if (res.isSignUpComplete) {
      return "Ok";
    }
    displayError(context, "Error Validating!");
    return null;
  } on AuthException catch (e) {
    displayError(context, e.message);
    //return '${e.message} - ${e..recoverySuggestion}';
    return null;
  }
}

Future<void> onResent(context, username) async {
  try {
    final res = await Amplify.Auth.resendSignUpCode(username: username);
    displaySuccess(context, "Code sent successfuly!");
  } on AuthException catch (e) {
    displayError(context, e.message);
    //return '${e.message} - ${e..recoverySuggestion}';
  }
}

class _AuthUserAttributeKey extends AuthUserAttributeKey {
  const _AuthUserAttributeKey(this.key);

  @override
  final String key;
}

Future<String?> load_portfolio(context, String cust_key) async {
  try {
    final restOperation = Amplify.API.post(
      '/loadportfolio',
      body: HttpPayload.json({'cust_key': cust_key}),
    );
    final response = await restOperation.response;
    print('POST call succeeded');
    return response.decodeBody();
  } on HttpStatusException catch (e) {
    displayError(context, e.message, fixed: true);
    //print('${e.message} - ${e..recoverySuggestion}');
    return null;
  }
}

Future<String?> load_transactions(context, String account) async {
  try {
    final restOperation = Amplify.API.post(
      '/loadtransactions',
      body: HttpPayload.json({'accnbr': account}),
    );
    final response = await restOperation.response;
    print('POST call succeeded');
    return response.decodeBody();
  } on HttpStatusException catch (e) {
    displayError(context, e.message);
    //print('${e.message} - ${e..recoverySuggestion}');
    return null;
  }
}

Future<String?> load_profile(context, String cust_key) async {
  try {
    final restOperation = Amplify.API.post(
      '/loadprofile',
      body: HttpPayload.json({'cust_key': cust_key}),
    );
    final response = await restOperation.response;
    print('POST call succeeded');
    return response.decodeBody();
  } on HttpStatusException catch (e) {
    displayError(context, e.message, fixed: false);
    //print('${e.message} - ${e..recoverySuggestion}');
    return null;
  }
}

Future<String?> logout(context) async {
  try {
    final result = await Amplify.Auth.signOut();
    if (result is CognitoCompleteSignOut) {
      safePrint('Sign out completed successfully');
    } else if (result is CognitoFailedSignOut) {
      safePrint('Error signing user out: ${result.exception.message}');
    }
  } on HttpStatusException catch (e) {
    displayError(context, e.message, fixed: true);
    //print('${e.message} - ${e..recoverySuggestion}');
    return null;
  }
}


Future<String?> load_statements(context, String account) async {
  try {
    final restOperation = Amplify.API.post(
      '/statements',
      body: HttpPayload.json({'account': account}),
    );
    final response = await restOperation.response;
    print('POST call succeeded');
    return response.decodeBody();
  } on HttpStatusException catch (e) {
    displayError(context, e.message);
    //print('${e.message} - ${e..recoverySuggestion}');
    return null;
  }
}
