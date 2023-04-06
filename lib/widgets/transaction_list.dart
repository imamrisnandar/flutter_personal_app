import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx, {super.key});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
          return Column(children: <Widget>[
            Text('No transactions added yet!',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                height: constraints.maxHeight * 0.6,
                child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover)),
          ],);
        })
        : ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                radius: 30,
                child: Padding( //bisa FittedBox
                  padding: EdgeInsets.all(6),
                  child: Text(
                      '\$${transactions[index].amount}'
                  ),
                ),
              ),
              title: Text(
                transactions[index].title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: MediaQuery.of(context).size.width > 460
                  ? TextButton.icon(
                      onPressed: () => deleteTx(transactions[index].id),
                      icon: Icon(Icons.delete),
                      label: Text('Delete'),
                      style: TextButton.styleFrom(foregroundColor: Theme.of(context).errorColor),
                    )
                  : IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteTx(transactions[index].id),
                    ),
              subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),
            ),
          );
        },
        itemCount: transactions.length,
    );

  }
}
