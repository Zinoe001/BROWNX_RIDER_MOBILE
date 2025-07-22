import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rider_mobile/core/core.dart';
import 'package:rider_mobile/features/onboarding/viewmodel/splash_screen_vm.dart';
import 'package:rider_mobile/widgets/widgets.dart';

final _splashViewModel = ChangeNotifierProvider.autoDispose(
  (ref) => SplashViewModel(ref.read(localCacheProvider)),
);

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 2), ref.read(_splashViewModel).initialise);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                ImageAsset.logo2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
