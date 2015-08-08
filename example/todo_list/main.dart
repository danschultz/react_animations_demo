import 'dart:html';
import 'package:react/react.dart' as react;
import 'package:react/react_client.dart' as react_client;
import 'package:react_animations/react_animations.dart' as animation;

void main() {
  react_client.setClientConfiguration();

  var applicationElement = querySelector("#application");

  react.render(todoListView({}), applicationElement);
}

var todoListView = react.registerComponent(() => new TodoListView());

class TodoListView extends react.Component {
  int get _nextId => state["nextId"];
  Iterable<String> get _items => state["items"];

  getInitialState() {
    return {"nextId": 1, "items": []};
  }

  render() {
    return react.div({}, [
      react.button({"onClick": (_) => _addItem()}, "Add Item"),
      animation.cssTransitionGroup("todo", _items.map((item) => _renderItem(item)))
    ]);
  }

  _renderItem(String item) {
    var matcher = new RegExp(r"(\d+)");
    var key = matcher.firstMatch(item).group(1);
    return react.div({"key": key, "onClick": (_) => _removeItem(item)}, item);
  }

  void _addItem() {
    var item = "Item $_nextId. Click to remove";
    setState({"nextId": _nextId + 1, "items": _items.toList()..insert(0, item)});
  }

  void _removeItem(String item) {
    setState({"items": _items.toList()..removeWhere((element) => element == item)});
  }
}
