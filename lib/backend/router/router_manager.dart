class RouterBuilderManager {
  static RouterPath routerPath = RouterPath.root;
  static RouterStatus routerStatus = RouterStatus.notAuth;
}

enum RouterPath { notFound, root, help, login, register, dash }

enum RouterStatus { auth, notAuth }
