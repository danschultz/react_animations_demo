part of react_animations;

cssTransitionGroup(String transitionName, [Iterable children = const []]) {
  return _createElement("CSSTransitionGroup", {"transitionName": transitionName}, children);
}

_createElement(String elementName, Map props, [Iterable children = const []]) {
  var module = _moduleForPath("React.addons");

  var extendedProps = new Map.from(props);

  var args = [new js.JsObject.jsify(extendedProps), new js.JsArray.from(children)];
  return module.callMethod(elementName, args);
}

js.JsObject _moduleForPath(String path) {
  var segments = path.split(".");
  var object = js.context;
  while (segments.isNotEmpty) {
    object = object[segments.removeAt(0)];
  }
  return object;
}
