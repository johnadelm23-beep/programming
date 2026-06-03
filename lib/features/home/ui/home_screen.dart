import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:programmin/core/theme/app_colors.dart';
import 'package:programmin/features/game/ui/logic_game.dart';
import 'package:programmin/features/home/cubit/cubit/home_cubit.dart';
import 'package:programmin/features/home/cubit/cubit/home_state.dart';
import 'package:programmin/features/home/ui/widgets/custm_card_container.dart';
import 'package:programmin/features/home/ui/widgets/custom_animated_item.dart';
import 'package:programmin/features/home/ui/widgets/custom_fun_card.dart';
import 'package:programmin/features/home/ui/widgets/custom_header_row.dart';
import 'package:programmin/features/home/ui/widgets/custom_hero_card.dart';
import 'package:programmin/features/home/ui/widgets/custom_qoute_card.dart';
import 'package:programmin/features/home/ui/widgets/custom_section_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<HomeCubit>().getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is GetUserDataLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryPurple,
                  ),
                );
              }

              if (state is GetUserDataError) {
                return Center(
                  child: Text(
                    state.error,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              if (state is GetUserDataSuccess) {
                final user = state.user;

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAnimatedItem(
                        index: 0,
                        child: CustomHeaderRow(user: user.name ?? ""),
                      ),

                      SizedBox(height: 20.h),

                      CustomAnimatedItem(index: 1, child: CustomHeroCard()),

                      SizedBox(height: 20.h),

                      CustomAnimatedItem(
                        index: 2,
                        child: CustomSectionTitle(title: "Explore Worlds"),
                      ),

                      SizedBox(height: 12.h),

                      Row(
                        children: [
                          Expanded(
                            child: CustomAnimatedItem(
                              index: 3,
                              child: CustmCardContainer(
                                title: "Code Lab",
                                icon: Icons.code,
                                onTap: () {},
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: CustomAnimatedItem(
                              index: 4,
                              child: CustmCardContainer(
                                title: "Logic Game",
                                icon: Icons.gamepad,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                          ) => const LogicGame(),
                                      transitionsBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                            child,
                                          ) {
                                            const begin = Offset(1.0, 0.0);
                                            const end = Offset.zero;
                                            const curve = Curves.ease;

                                            final tween = Tween(
                                              begin: begin,
                                              end: end,
                                            ).chain(CurveTween(curve: curve));

                                            return SlideTransition(
                                              position: animation.drive(tween),
                                              child: child,
                                            );
                                          },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      CustomAnimatedItem(
                        index: 5,
                        child: CustomSectionTitle(title: "Daily Inspiration"),
                      ),

                      SizedBox(height: 12.h),

                      CustomAnimatedItem(index: 6, child: CustomQouteCard()),

                      SizedBox(height: 20.h),

                      CustomAnimatedItem(index: 7, child: CustomFunCard()),

                      SizedBox(height: 30.h),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
