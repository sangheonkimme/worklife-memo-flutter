import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/home/home_shell.dart';
import '../screens/home/notes_screen.dart';
import '../screens/home/folders_screen.dart';
import '../screens/home/tags_screen.dart';
import '../screens/home/settings_screen.dart';

/// 앱 라우터 설정
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Splash Screen
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),

    // Home Shell with Bottom Navigation
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomeShell(navigationShell: navigationShell);
      },
      branches: [
        // Notes Tab
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/notes',
              builder: (context, state) => const NotesScreen(),
            ),
          ],
        ),

        // Folders Tab
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/folders',
              builder: (context, state) => const FoldersScreen(),
            ),
          ],
        ),

        // Tags Tab
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tags',
              builder: (context, state) => const TagsScreen(),
            ),
          ],
        ),

        // Settings Tab
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),

    // TODO: Week 4-5에서 추가할 라우트
    // Note Editor
    // GoRoute(
    //   path: '/note/:id',
    //   builder: (context, state) {
    //     final id = state.pathParameters['id']!;
    //     return NoteEditorScreen(noteId: id);
    //   },
    // ),

    // Search Screen
    // GoRoute(
    //   path: '/search',
    //   builder: (context, state) => const SearchScreen(),
    // ),
  ],

  // 에러 페이지
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(
      title: const Text('오류'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            '페이지를 찾을 수 없습니다',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            state.error.toString(),
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => context.go('/notes'),
            child: const Text('홈으로 돌아가기'),
          ),
        ],
      ),
    ),
  ),
);
