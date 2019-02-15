# simple_debt_manager

Small project to learn flutter where you can manage your debts.

This project started as a joke. 

Debts are onesided.

## Description

### Create debts and store them in a small sqlite database.
<div align="center">
<img src="https://raw.githubusercontent.com/NauzetAduen/simple-debt-manager/master/screenshots/1%20-%20main_screen.png" width="135">
<img src="https://raw.githubusercontent.com/NauzetAduen/simple-debt-manager/master/screenshots/2%20-%20new_debt_screen.png" width="135">
<br>
<img src="https://raw.githubusercontent.com/NauzetAduen/simple-debt-manager/master/screenshots/4%20-%20main_list.png" width="135">
<img src="https://raw.githubusercontent.com/NauzetAduen/simple-debt-manager/master/screenshots/5%20-%20main_list_multiple.png" width="135">
</div>


### Edit/delete those debts.
<div align="center">
<img src="https://raw.githubusercontent.com/NauzetAduen/simple-debt-manager/master/screenshots/6%20-%20editing_debt.png" width="135">
<img src="https://raw.githubusercontent.com/NauzetAduen/simple-debt-manager/master/screenshots/7%20-%20editing_partial_debt.png" width="135">
<br>
https://raw.githubusercontent.com/NauzetAduen/simple-debt-manager/master/screenshots/8%20-%20main_screen_colors.png

</div>

### Error messages.
<div align="center">
<img src="https://raw.githubusercontent.com/NauzetAduen/simple-debt-manager/master/screenshots/3%20-%20error_message.png" width="135">

<img src="https://raw.githubusercontent.com/NauzetAduen/simple-debt-manager/master/screenshots/9%20-%20edit_control_quantity.png" width="135">

</div>

### States
Debts will be listed colored by "state". Fully paid, not paid or partialy paid.
<div align="center">
<img src="https://raw.githubusercontent.com/NauzetAduen/simple-debt-manager/master/screenshots/10%20-%20main_screen_all_types.png" width="135">
</div>



### General tab with a resume
<div align="center">
<img src="https://raw.githubusercontent.com/NauzetAduen/simple-debt-manager/master/screenshots/11%20-%20general_screen.png" width="135">
</div>




## Plugins used
- [sqflite](https://pub.dartlang.org/packages/sqflite)
- [charts_flutter](https://pub.dartlang.org/packages/charts_flutter)
- [flutter_launcher_icons](https://pub.dartlang.org/packages/flutter_launcher_icons)

## Future
- Filter the list by users or quantity

## Known bugs
- DataHolder not updating properly when a new debt is added