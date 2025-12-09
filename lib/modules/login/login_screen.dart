import 'package:local_shout_billing/models/login_model.dart';
import 'package:local_shout_billing/modules/job_sheet/pages/job_sheet.dart';
import 'package:local_shout_billing/modules/login/pages/login_page.dart';
import '../job_sheet/bloc/profile_bloc/profile_section_bloc.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
import '../job_sheet/bloc/profile_bloc/profile_section_event.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  Future<void> _initAsync() async {
    await app_instance.runningAppIsarServices.cleanDb();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: BlocListener<LogInCubit, LogInState>(
        listener: (context, state) async {
          if (state.status.isSubmissionSuccess) {
            final token = await app_instance.storage.read(key: 'token');
            if (token != null && token.isNotEmpty) {
              CenterLoader.hide();
              Fluttertoast.cancel();
              Fluttertoast.showToast(
                  msg: "Login Successfully",
                  backgroundColor: successColor,
                  toastLength: Toast.LENGTH_SHORT);
              context.read<ProfileSectionBloc>().add(
                    const FetchProfileInfo(),
                  );

              context.read<JobSheetBloc>().add(
                    const FetchEstimateList(status: JobSheetStatus.initial),
                  );
              context.read<JobSheetBloc>().add(
                    const FetchEstimateList(status: JobSheetStatus.initial),
                  );
              Navigator.pushNamed(context, '/dashboard_page');
            }
          }
          if (state.status.isSubmissionInProgress) {
            CenterLoader.show(context);
          }
          if (state.status.isSubmissionFailure &&
              state.errorMessage.toString().isNotEmpty) {
            CenterLoader.hide();
            Fluttertoast.cancel();
            Fluttertoast.showToast(
                msg: state.errorMessage.toString(),
                backgroundColor: redColor,
                toastLength: Toast.LENGTH_SHORT);
          }
        },
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1A1A1A),
                  Color(0xFF1A1A1A),
                ],
              ),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: ClipPath(
                        clipper: WaveClipper(),
                        child: Container(
                          color:lightbgColor,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/drawer-icon.png',
                                  color: blackColor,
                                  height: 151,
                                  width: 250,
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF1A1A1A),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Welcome Back!',
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Sign in to Continue...',
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                EmailInputBox(emailController: emailController),
                                const SizedBox(height: 14),
                                PasswordInputBox(
                                    passwordController: passwordController),
                                const SizedBox(height: 30),
                                LoginButton(
                                    emailController: emailController,
                                    passwordController: passwordController),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  const LoginButton({super.key, this.emailController, this.passwordController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInCubit, LogInState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: ElevatedButton(
            onPressed: () async {
              if (state.status.isValid) {
                await context.read<LogInCubit>().submitLoginForm(context);
              } else {
                context.read<LogInCubit>().emailChanged(emailController!.text);
                context
                    .read<LogInCubit>()
                    .passwordChanged(passwordController!.text);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              'Sign In',
              style: TextStyle(
                  fontFamily: 'Mulish',
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
        );
      },
    );
  }
}

class PasswordInputBox extends StatefulWidget {
  final TextEditingController? passwordController;
  const PasswordInputBox({super.key, this.passwordController});

  @override
  State<PasswordInputBox> createState() => _PasswordInputBoxState();
}

class _PasswordInputBoxState extends State<PasswordInputBox> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInCubit, LogInState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: TextField(
            controller: widget.passwordController,
            onChanged: (value) {
              context.read<LogInCubit>().passwordChanged(value);
            },
            obscureText: _obscureText,
            textAlign: TextAlign.start,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: whiteColor),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: blackColor,
              hintText: "Password",
              errorText: state.password.invalid &&
                      state.password.error == PasswordValidationError.empty
                  ? 'Please enter password'
                  : null,
              hintStyle: const TextStyle(
                  color: hintTextColor,
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w400,
                  fontSize: 15),
              prefixIcon: Container(
                height: 19,
                width: 20,
                padding: const EdgeInsets.all(13),
                child: Image.asset(
                  "assets/icons/lock.png",
                  color: hintTextColor,
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: blackColorLight,
                ),
                onPressed: () {
                  setState(
                    () {
                      _obscureText = !_obscureText;
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class EmailInputBox extends StatelessWidget {
  final TextEditingController? emailController;
  const EmailInputBox({super.key, this.emailController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInCubit, LogInState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: TextField(
            controller: emailController,
            onChanged: (value) {
              context.read<LogInCubit>().emailChanged(value);
            },
            textAlign: TextAlign.start,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: whiteColor),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: blackColor,
              hintText: "Email or Username",
              errorText: state.email.invalid &&
                      state.email.error == EmailValidationError.empty
                  ? 'Please enter email address or username'
                  : null,
              hintStyle: const TextStyle(
                  color: hintTextColor,
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w400,
                  fontSize: 15),
              prefixIcon: Container(
                height: 19,
                width: 20,
                padding: const EdgeInsets.all(13),
                child: Image.asset(
                  "assets/icons/email.png",
                  color: hintTextColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height - 30);
    path.quadraticBezierTo(
        3 * size.width / 4, size.height - 60, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
