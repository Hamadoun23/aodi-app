import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Barre supérieure avec logo AODI centré, cloche de notifications et avatar.
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onBackTap;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onProfileTap;
  final int notificationCount;
  final bool showLogo;

  const AppTopBar({
    super.key,
    this.onMenuTap,
    this.onBackTap,
    this.onNotificationsTap,
    this.onProfileTap,
    this.notificationCount = 3,
    this.showLogo = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: onBackTap ?? onMenuTap,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Icon(
                  onBackTap != null ? Icons.arrow_back_rounded : Icons.menu_rounded,
                  color: AppColors.textDark,
                ),
              ),
            ),
            Expanded(
              child: showLogo
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/logo_icon.png', height: 26),
                        const SizedBox(width: 4),
                        Text(
                          'AODI',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: onNotificationsTap,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.notifications_none_rounded, color: AppColors.textDark),
                    if (notificationCount > 0)
                      Positioned(
                        right: -2,
                        top: -2,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(color: AppColors.danger, shape: BoxShape.circle),
                          constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                          child: Text(
                            '$notificationCount',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onProfileTap,
              child: const CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/images/avatar_astou.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
