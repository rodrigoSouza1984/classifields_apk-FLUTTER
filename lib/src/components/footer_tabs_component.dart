import 'package:flutter/material.dart';

class FooterTabsComponent extends StatefulWidget {
  final List<FooterTabItem> tabs;
  final Function(String) onTabSelected;

  FooterTabsComponent({required this.tabs, required this.onTabSelected});

  @override
  _FooterTabsComponentState createState() => _FooterTabsComponentState();
}

class _FooterTabsComponentState extends State<FooterTabsComponent> {
  int _selectedIndex = 0;

  String getSelectedIconName() {
    return widget.tabs[_selectedIndex].name;
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
      widget.onTabSelected(widget.tabs[index].name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.tabs.map((tab) {
          return _buildTabItem(
            icon: tab.icon,
            index: tab.index,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabItem({required IconData icon, required int index}) {
    return GestureDetector(
      onTap: () => _onTabSelected(index),
      child: Container(
        height: 60,
        padding: EdgeInsets.all(10),
        child: Icon(
          icon,
          color: _selectedIndex == index ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}

class FooterTabItem {
  final IconData icon;
  final String name;
  final int index;

  FooterTabItem({required this.icon,required this.name, required this.index});
}