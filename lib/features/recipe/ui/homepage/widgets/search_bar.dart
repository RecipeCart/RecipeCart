import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchInputState();
}
    
    class _SearchInputState extends State<SearchBarWidget> {
      @override
      Widget build(BuildContext context) {
        return Container(
          color: Colors.transparent,
          margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: TextField(
                      cursorColor: Colors.grey,
                      style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none
                        ),
                        hintText: 'Search',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 20
                        ),
                        prefixIcon: const Icon(Icons.search, color: Colors.black,),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }
    }