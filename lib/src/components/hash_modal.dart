import 'package:flutter/material.dart';
import 'package:pactcheck_front/src/pages/past-contracts/past_contract_view.dart';

class PopHashModal extends StatelessWidget {
  const PopHashModal({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => showDialog<void>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                content: const Text('Hash data of this image'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'Cancel');
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'OK');
                      },
                      child: const Text('OK'))
                ],
              ),
            ),
        icon: const Icon(Icons.link, color: Colors.white));
  }
}
