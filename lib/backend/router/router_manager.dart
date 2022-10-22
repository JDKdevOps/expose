class RouterBuilderManager {
  static RouterPath routerPath = RouterPath.root;
  static RouterStatus routerStatus = RouterStatus.notAuth;
}

enum RouterPath {root, auth, dash }

enum RouterStatus { auth, notAuth }
